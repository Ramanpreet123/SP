//
//  ADHAnimalVCBluetoothExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 26/08/25.
//

import Foundation
import UIKit
import Vision
import VisionKit
import CoreBluetooth

//MARK: BLUETOOTH METHODS
extension ADHAnimalVC {
    
    func isOCRScannerSelected() -> Bool {
        return UserDefaults.standard.string(forKey: keyValue.scannerSelection.rawValue) == keyValue.ocrKey.rawValue
    }
    
    func isBluetoothOff() -> Bool {
        return BluetoothCentre.shared.manager.state == .poweredOff
    }
    
    func presentBluetoothOffAlert() {
        let alertController = UIAlertController(
            title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),
            message: NSLocalizedString(AlertMessagesStrings.bluetoothOffText, comment: ""),
            preferredStyle: .alert
        )
        
        let settingsAction = UIAlertAction(title: NSLocalizedString(LocalizedStrings.settingsText, comment: ""), style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl) else { return }
            
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl)
            } else {
                UIApplication.shared.openURL(settingsUrl)
            }
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default)
        
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func handleBluetoothState() {
        guard let state = BluetoothCentre.shared.smartBowPeripheral?.state else {
            showPairedList()
            return
        }
        
        switch state {
        case .disconnected:
            showPairedList()
        case .connected, .connecting:
            BluetoothCentre.shared.manager.scanForPeripherals(withServices: nil, options: nil)
            showPairedList()
        default:
            break
        }
    }
    
    func showPairedList() {
        pairedBackroundView.isHidden = false
        pairedTableView.reloadData()
    }
    
    func setVisionTextRecognizeImage(image: UIImage) {
        var textStr = ""
        
        func cleanText(_ rawText: String) -> String {
            let trimmed = String(rawText.compactMap { $0.isWhitespace ? nil : $0 })
            return String(trimmed.filter { !"\n\t\r(),.-[]:}{".contains($0) })
        }
        
        func presentAlert(with text: String, useScannedValueHandler: @escaping () -> Void) {
            let message = LocalizedStrings.unableToReadValue.localized(with: text)
            let alert = UIAlertController(
                title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),
                message: message,
                preferredStyle: .alert
            )
            
            let retryAction = UIAlertAction(title: NSLocalizedString("Retry", comment: ""), style: .default) { _ in
                let storyboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
                if let vc = storyboard.instantiateViewController(withIdentifier: ClassIdentifiers.textScanVC) as? TextScanVC {
                    vc.delegate = self
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            alert.addAction(retryAction)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default))
            alert.addAction(UIAlertAction(
                title: NSLocalizedString(LocalizedStrings.useScannedValue, comment: ""),
                style: .default
            ) { _ in useScannedValueHandler() })
            
            self.present(alert, animated: true)
        }
        
        func applyScannedText(_ processedText: String, updateTag: Bool) {
            self.searchTextField.text = processedText
            self.imageView.isHidden = true
            self.searchTextField.delegate = self
            if updateTag {
                self.searchTextField.returnKeyType = .done
                self.searchTextField.tag = 1
            }
            self.textFieldDidEndEditing(self.searchTextField)
        }
        
        request = VNRecognizeTextRequest { request, _ in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                fatalError("Received invalid observation")
            }
            
            for observation in observations {
                if let topCandidate = observation.topCandidates(1).first {
                    textStr += "\n\(topCandidate.string)"
                }
            }
            
            DispatchQueue.main.async {
                let processedText = cleanText(textStr)
                
                // Reset before presenting alert
                self.searchTextField.text = ""
                self.imageView.isHidden = true
                
                let shouldUpdateTag = (self.searchTextField.tag == 0)
                presentAlert(with: processedText) {
                    applyScannedText(processedText, updateTag: shouldUpdateTag)
                }
                
                self.searchTextField.becomeFirstResponder()
            }
        }
        
        // Configure request
        request.customWords = ["custOm"]
        request.minimumTextHeight = 0.03125
        request.recognitionLevel = .accurate
        request.recognitionLanguages = ["en_US"]
        request.usesLanguageCorrection = true
        
        // Perform request asynchronously
        DispatchQueue.global(qos: .userInitiated).async {
            guard let cgImage = image.cgImage else {
                fatalError("Missing image to scan")
            }
            let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
            try? handler.perform([self.request])
        }
    }
}
