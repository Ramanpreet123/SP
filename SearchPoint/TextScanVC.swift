//
//  TextScanVC.swift
//  VisionExample
//
//  Created by Mobile Programming on 26/12/22.
//  Copyright © 2022 Google Inc. All rights reserved.
//

import UIKit
import Vision
import Photos
import CropViewController

class TextScanVC: UIViewController, CropViewControllerDelegate {
    
    @IBOutlet weak var imgView: UIImageView!
    var overlay: UIView = UIView()
    private var image: UIImage?
    private var croppedRect = CGRect.zero
    private var croppedAngle = 0
    
    @IBAction func scanImageForText(_ sender: UIButton) {
        recognizeText(image: imgView.image)
    }
    
    var delegate: scannedOCRProtocol?
    private var croppingStyle = CropViewCroppingStyle.default
    
    
    private let stackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        return stackView
    }()
    
    private let recognizeButton : UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.tintColor = .white
        button.backgroundColor = .purple
        button.setTitleColor(.white, for: .normal)
        button.setImage(UIImage(named: "doc.text.viewfinder"), for: .normal)
        button.setTitle(" Recognize Text ", for: .normal)
        button.layer.cornerRadius = 15.0
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.addTarget(TextScanVC.self, action: #selector(sendImage), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let label : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.backgroundColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private let recognizeImage : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    @objc func openCamera(sender: UIButton!){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available")
            picker.sourceType = .camera
        } else {
            print("Camera is not available so we will use photo library instead")
            picker.sourceType = .photoLibrary
        }
        self.present(picker, animated: true, completion: nil)
    }
    
    var imageViewController = UIImagePickerController()
    
    @objc func openLibrary(sender: UIButton){
        self.imageViewController.sourceType = .photoLibrary
        self.present(self.imageViewController, animated: true, completion: nil)
    }
    
    
    func checkPermissions(){
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized{
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()
                
            })
        }
        
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
        }else {
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
    }
    
    
    
    func requestAuthorizationHandler(status: PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("Access granted to use photo library.")
        }else {
            print("We don't have access to your photos.")
        }
    }
    
    @objc func sendImage(){
        recognizeText(image: recognizeImage.image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkPermissions()
        imageViewController.delegate = self
        
        self.view.backgroundColor = .white
        
        openAcnSheet()
        view.addSubview(stackView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if #available(iOS 11.0, *) {
            stackView.frame = CGRect(x: 20, y: view.safeAreaInsets.top,
                                     width: view.frame.size.width-40,
                                     height: 60)
        } else {
        }
        if #available(iOS 11.0, *) {
            stackView.frame = CGRect(x: 20, y: view.safeAreaInsets.top,
                                     width: view.frame.size.width-40,
                                     height: 60)
        } else {
        }
        
        if #available(iOS 11.0, *) {
            recognizeImage.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 60,
                                          width: view.frame.size.width-40,
                                          height: view.frame.size.width-40)
        } else {
        }
        if #available(iOS 11.0, *) {
            recognizeImage.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 60,
                                          width: view.frame.size.width-40,
                                          height: view.frame.size.width-40)
        } else {
        }
        
        if #available(iOS 11.0, *) {
            recognizeButton.frame = CGRect(x: 20, y: view.frame.size.width + view.safeAreaInsets.top,
                                           width: view.frame.size.width-40,
                                           height: 60)
        } else {
        }
        
        if #available(iOS 11.0, *) {
            label.frame = CGRect(x: 20, y: view.frame.size.width + view.safeAreaInsets.top + 70,
                                 width: view.frame.size.width-40,
                                 height: 250)
        } else {
        }
    }
    
    @IBAction func acnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func openAcnSheet() {
        let alert = UIAlertController(title: "Select Image Source", message: "", preferredStyle: .actionSheet)
        
      alert.addAction(UIAlertAction(title: "Camera".localized, style: .default , handler:{ (UIAlertAction)in
            print("User click Approve button")
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                print("Camera is available")
                picker.sourceType = .camera
            } else {
                print("Camera is not available so we will use photo library instead")
                picker.sourceType = .photoLibrary
            }
            self.present(picker, animated: true, completion: nil)
        }))
        
      alert.addAction(UIAlertAction(title: "Gallery".localized, style: .default , handler:{ (UIAlertAction)in
            self.croppingStyle = .default
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            imagePicker.delegate = self
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }))
        
      
      alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default , handler:{ (UIAlertAction)in
        alert.dismiss(animated: false, completion: {
          self.navigationController?.popViewController(animated: true)
        })
          
      }))
      
      self.present(alert, animated: true, completion: {
          print("completion block")
      })
    }
    
    
    private func recognizeText(image: UIImage?) {
        var toastString = ""
        guard let cgImage = image?.cgImage else {
            print("fatal error could not cgimage")
            return
        }

        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        if #available(iOS 13.0, *) {
            let request = VNRecognizeTextRequest { [weak self] request, error in
                guard let observations = request.results as? [VNRecognizedTextObservation], error == nil else{
                    return
                }
                var text = observations.compactMap({
                    $0.topCandidates(1).first?.string
                }).joined(separator: "")
                
                toastString = "269" + text
                text = text.trimmingCharacters(in: .whitespacesAndNewlines)
                print("Text 269 ---> \(text)")
                toastString = toastString + "273   After trimming -- >" + text
                let arr = text.indicesOfNumbers
                if arr.count > 0 {
                    let index1 = arr[0]
                    if index1 > 0 {
                        text = text.deletingPrefix(index1)
                    }
                }
                
                print("Text 278 ---> \(text)")
                toastString = toastString + " 287   After deleting prefix -->" + text
                
                let charSet = "abcdefghijklmnopqrstuvwxyz"
                let characters = Array(text)
                var numberArr = [String]()
                for item in characters {
                    if charSet.contains(item.lowercased()) {
                        break
                        print("Breaking ---> \(item)")
                    } else {
                        numberArr.append("\(item)")
                        print("Appending ---> \(item)")
                    }
                }
                
                var finalText = numberArr.joined()
                self?.hideIndicator()
                
                if let index = finalText.firstIndex(of: "8") {
                    let distance = finalText.distance(from: finalText.startIndex, to: index)
                    
                    print("Index of 8 is: \(distance)")
                    if distance > 1 && distance < 5 {
                        finalText = finalText.deletingPrefix(distance)
                    }
                } else {
                    print("Character not found")
                }
                finalText = finalText.trimmingCharacters(in: .whitespacesAndNewlines)
                finalText = finalText.components(separatedBy: " ").joined()
                
                toastString = toastString + " Final Text --> " + finalText
                
                if finalText.count > 3 {
                    print("Correct Text  ---> \(finalText)")
                    self?.delegate?.ocrDetected(finalText /*+ "Index --- > \(subStringg)"*/)
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    print("Incorrect Text  ---> \(finalText)")
                    let alert = UIAlertController(title: "Error Occured", message: "Some error occured, please click the tag again" /*finalText + "\(subStringg)*/, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                          self?.navigationController?.popViewController(animated: true)
                        case .cancel:
                            print("cancel")
                        case .destructive:
                            print("destructive")
                        @unknown default:
                            print("Unknown")
                        }
                    }))
                    self?.present(alert, animated: true, completion: nil)
                }
            }
            
            do{
                try handler.perform([request])
            }catch{
                print(error.localizedDescription)
            }
            
        } else {
        }
    }
}


extension TextScanVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: false, completion: {
      self.openAcnSheet()
    })
   
  }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if picker.sourceType == .photoLibrary{
            recognizeImage.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            imgView?.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            guard let image = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
            
            let cropController = CropViewController(croppingStyle: croppingStyle, image: image)
            cropController.delegate = self
            self.image = image
            picker.dismiss(animated: false, completion: {
                self.present(cropController, animated: true, completion: nil)
            })
        } else {
            recognizeImage.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            imgView?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            label.text = " "
            showIndicator(self.view, withTitle: NSLocalizedString("Analyzing Image Data...", comment: ""), and: "")
            dismiss(animated: true) {
                DispatchQueue.main.async {
                    self.recognizeText(image: self.imgView.image)
                }
            }
        }
    }
    
    public func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        self.croppedRect = cropRect
        self.croppedAngle = angle
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    
    public func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        imgView.image = image
        layoutImageView()
        DispatchQueue.main.async {
            self.recognizeText(image: self.imgView.image)
        }
        
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.imgView.isHidden = false
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
    public func layoutImageView() {
        guard imgView.image != nil else { return }
        
        let padding: CGFloat = 20.0
        var viewFrame = self.view.bounds
        viewFrame.size.width -= (padding * 2.0)
        viewFrame.size.height -= ((padding * 2.0))
        
        var imageFrame = CGRect.zero
        imageFrame.size = imgView.image!.size;
        
        if imgView.image!.size.width > viewFrame.size.width || imgView.image!.size.height > viewFrame.size.height {
            let scale = min(viewFrame.size.width / imageFrame.size.width, viewFrame.size.height / imageFrame.size.height)
            imageFrame.size.width *= scale
            imageFrame.size.height *= scale
            imageFrame.origin.x = (self.view.bounds.size.width - imageFrame.size.width) * 0.5
            imageFrame.origin.y = (self.view.bounds.size.height - imageFrame.size.height) * 0.5
            imgView.frame = imageFrame
        }
        else {
            self.imgView.frame = imageFrame;
            self.imgView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
        }
    }
    
}





extension String {
   
    var indicesOfNumbers: [Int] {
        var indices = [Int]()
        var searchStartIndex = self.startIndex
        while searchStartIndex < self.endIndex,
              let range = self.rangeOfCharacter(from: CharacterSet.decimalDigits,
                                                range: searchStartIndex..<self.endIndex),
              !range.isEmpty
        {
            let index = distance(from: self.startIndex, to: range.lowerBound)
            if index > 0 {
                let previousIndex = self.index(self.startIndex, offsetBy: index - 1)
                if let previousCharacter = self[previousIndex].unicodeScalars.first,
                   (previousCharacter == "." || previousCharacter == "," || previousCharacter == "*" || previousCharacter == "-")
                {
                    indices.append(index - 1)
                }
            }
            indices.append(index)
            searchStartIndex = range.upperBound
        }
        return indices
    }
    
    func deletingPrefix(_ count: Int) -> String {
        return String(self.dropFirst(count))
    }
    
}


extension TextScanVC: CustomCamVCDelegate {
    func imageCaptured(_ image: UIImage) {
        label.text = " "
        self.imgView.image = image
        DispatchQueue.main.async {
            self.recognizeText(image: self.imgView.image)
        }
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
              let range = self[startIndex...]
                .range(of: string, options: options) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}

