//
//  Copyright (c) 2018 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//

import AVFoundation
import CoreVideo
import MLImage
import MLKit
import UIKit
import Vision


@objc(CameraViewController)
class CameraViewController: UIViewController {
    private let detectors: [Detector] = [
        .onDeviceText,
        .onDeviceBarcode,
      
    ]
    
    private var currentDetector: Detector = .onDeviceBarcode
    private var isUsingFrontCamera = false
    private var isAutoFocus: Int = 1
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private lazy var captureSession = AVCaptureSession()
    private lazy var sessionQueue = DispatchQueue(label: Constant.sessionQueueLabel)
    private var lastFrame: CMSampleBuffer?
    
    private lazy var previewOverlayView: UIImageView = {
        
        precondition(isViewLoaded)
        let previewOverlayView = UIImageView(frame: .zero)
        previewOverlayView.contentMode = UIView.ContentMode.scaleAspectFill
        previewOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return previewOverlayView
    }()
    
    private lazy var annotationOverlayView: UIView = {
        precondition(isViewLoaded)
        let annotationOverlayView = UIView(frame: .zero)
        annotationOverlayView.translatesAutoresizingMaskIntoConstraints = false
        return annotationOverlayView
    }()
   
    var isTorchOn: Bool = false
    private var lastDetector: Detector?
    private var cameraDevice: AVCaptureDevice?
    // MARK: - IBOutlets
    
    @IBOutlet private weak var cameraView: UIView!
    @IBOutlet private weak var btnTorch: UIButton!
    @IBOutlet private weak var lblValue: UILabel!
    
    
    var delegate: QrScannerProtocol?
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        setUpPreviewOverlayView()
        setUpAnnotationOverlayView()
        setUpCaptureSessionInput()
        setUpCaptureSessionOutput()
        
        btnTorch.setTitle("Turn on Flashlight".localized, for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startSession()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopSession()
    }
    
    func createOverlay() -> UIView {
        let overlayView = UIView(frame: CGRect(x: 100, y: (Int(self.view.frame.height) / 2) - 100, width: (Int(self.view.frame.width) - 200), height: 150))
        overlayView.backgroundColor = UIColor.gray.withAlphaComponent(0.01)
        
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: 0, y: 0, width: overlayView.frame.width , height: overlayView.frame.height ), cornerWidth: 20, cornerHeight: 20)
        path.closeSubpath()
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 9
        shape.strokeColor = UIColor.green.cgColor
        shape.fillColor = UIColor.white.cgColor
        
        overlayView.layer.addSublayer(shape)
        
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))
        
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd // kCAFillRuleEvenOdd // CAShapeLayerFillRule.evenOdd
        
        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        previewLayer.frame = cameraView.frame
    }
    
    // MARK: - IBActions
    
    @IBAction func selectDetector(_ sender: Any) {
        presentDetectorsAlertController()
    }
    
    @IBAction func switchCamera(_ sender: Any) {
        isUsingFrontCamera = !isUsingFrontCamera
        removeDetectionAnnotations()
        setUpCaptureSessionInput()
    }
    
    // MARK: On-Device Detections
    
    private func scanBarcodesOnDevice(in image: VisionImage, width: CGFloat, height: CGFloat) {
        let format = BarcodeFormat.all
        let barcodeOptions = BarcodeScannerOptions(formats: format)
        let barcodeScanner = BarcodeScanner.barcodeScanner(options: barcodeOptions)
        var barcodes: [Barcode] = []
        var scanningError: Error?
        
        do {
            barcodes = try barcodeScanner.results(in: image)
        } catch let error {
            scanningError = error
        }
        weak var weakSelf = self
        DispatchQueue.main.sync {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.updatePreviewOverlayViewWithLastFrame()
            
            if let scanningError = scanningError {
                print("Failed to scan barcodes with error: \(scanningError.localizedDescription).")
                return
            }
            guard !barcodes.isEmpty else {
                print("Barcode scanner returrned no results.")
                return
            }
            for barcode in barcodes {
                let normalizedRect = CGRect(
                    x: self.cameraView.frame.origin.x,
                    y: self.cameraView.frame.origin.y,
                    width: self.cameraView.frame.size.width,
                    height: self.cameraView.frame.size.height
                )
                
                
                let convertedRect = strongSelf.previewLayer.layerRectConverted(
                    fromMetadataOutputRect: normalizedRect
                )
                
                UIUtilities.addRectangle(
                    convertedRect,
                    to: strongSelf.annotationOverlayView,
                    color: UIColor.green
                )
                
                let label = UILabel(frame: convertedRect)
                label.text = barcode.displayValue
                label.adjustsFontSizeToFitWidth = true
                strongSelf.rotate(label, orientation: image.orientation)
                strongSelf.annotationOverlayView.addSubview(label)
                
                self.delegate?.qrCodeScannedResult(barcode.displayValue ?? "")
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
 
    
    private func recognizeTextOnDevice(
        in image: VisionImage, width: CGFloat, height: CGFloat, detectorType: Detector
    ) {
        var options: CommonTextRecognizerOptions
        options = TextRecognizerOptions.init()
        
        var recognizedText: Text?
        var detectionError: Error?
        do {
            recognizedText = try TextRecognizer.textRecognizer(options: options)
                .results(in: image)
        } catch let error {
            detectionError = error
        }
        weak var weakSelf = self
        DispatchQueue.main.sync {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.updatePreviewOverlayViewWithLastFrame()
            if let detectionError = detectionError {
                print("Failed to recognize text with error: \(detectionError.localizedDescription).")
                return
            }
            guard let recognizedText = recognizedText else {
                print("Text recognition returned no results.")
                return
            }
            
            for block in recognizedText.blocks {
                let points = strongSelf.convertedPoints(
                    from: block.cornerPoints, width: width, height: height)
                UIUtilities.addShape(
                    withPoints: points,
                    to: strongSelf.annotationOverlayView,
                    color: UIColor.purple
                )
                
                // Lines.
                for line in block.lines {
                    let points = strongSelf.convertedPoints(
                        from: line.cornerPoints, width: width, height: height)
                    UIUtilities.addShape(
                        withPoints: points,
                        to: strongSelf.annotationOverlayView,
                        color: UIColor.orange
                    )
                    
                    // Elements.
                    for element in line.elements {
                        let normalizedRect = CGRect(
                            x: element.frame.origin.x / width,
                            y: element.frame.origin.y / height,
                            width: element.frame.size.width / width,
                            height: element.frame.size.height / height
                        )
                        let convertedRect = strongSelf.previewLayer.layerRectConverted(
                            fromMetadataOutputRect: normalizedRect
                        )
                        UIUtilities.addRectangle(
                            convertedRect,
                            to: strongSelf.annotationOverlayView,
                            color: UIColor.green
                        )
                        let label = UILabel(frame: convertedRect)
                        label.text = element.text
                        label.adjustsFontSizeToFitWidth = true
                        strongSelf.rotate(label, orientation: image.orientation)
                        strongSelf.annotationOverlayView.addSubview(label)
                        
                        if element.text.count > 4 {
                            lblValue.text = element.text
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func setUpCaptureSessionOutput() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.beginConfiguration()
            strongSelf.captureSession.sessionPreset = AVCaptureSession.Preset.hd1280x720
            
            let output = AVCaptureVideoDataOutput()
            output.videoSettings = [
                (kCVPixelBufferPixelFormatTypeKey as String): kCVPixelFormatType_32BGRA
            ]
            output.alwaysDiscardsLateVideoFrames = true
            let outputQueue = DispatchQueue(label: Constant.videoDataOutputQueueLabel)
            output.setSampleBufferDelegate(strongSelf, queue: outputQueue)
            guard strongSelf.captureSession.canAddOutput(output) else {
                print("Failed to add capture session output.")
                return
            }
            strongSelf.captureSession.addOutput(output)
            strongSelf.captureSession.commitConfiguration()
        }
    }
    
    private func addInputToSession(device:AVCaptureDevice, session:AVCaptureSession){
        let cameraInput = try! AVCaptureDeviceInput(device: device)
        if(session.canAddInput(cameraInput)){
            
            do{
                try device.lockForConfiguration()
                cameraInput.device.videoZoomFactor = 5
                cameraInput.device.autoFocusRangeRestriction = .near
                session.addInput(cameraInput)
                device.unlockForConfiguration()
                
                let alert = UIAlertController(title: "My Title", message: "adding inputs", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }catch{
                print(error)
            }
        }
    }
    
    
    private func setUpCaptureSessionInput() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            
            let cameraPosition: AVCaptureDevice.Position = strongSelf.isUsingFrontCamera ? .front : .back
            guard let device = strongSelf.captureDevice(forPosition: cameraPosition) else {
                print("Failed to get capture device for camera position: \(cameraPosition)")
                return
            }
            
            do {
                strongSelf.captureSession.beginConfiguration()
                let currentInputs = strongSelf.captureSession.inputs
                for input in currentInputs {
                    strongSelf.captureSession.removeInput(input)
                }
                
                let input = try AVCaptureDeviceInput(device: device)
                guard strongSelf.captureSession.canAddInput(input) else {
                    print("Failed to add capture session input.")
                    return
                }
               
                strongSelf.captureSession.addInput(input)
                strongSelf.captureSession.commitConfiguration()
            } catch {
                print("Failed to create capture device input: \(error.localizedDescription)")
            }
        }
    }
    
    private func startSession() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.startRunning()
        }
    }
    
    private func stopSession() {
        weak var weakSelf = self
        sessionQueue.async {
            guard let strongSelf = weakSelf else {
                print("Self is nil!")
                return
            }
            strongSelf.captureSession.stopRunning()
        }
    }
    
    private func setUpPreviewOverlayView() {
        cameraView.addSubview(previewOverlayView)
        
        NSLayoutConstraint.activate([
            
            previewOverlayView.leadingAnchor.constraint(equalTo: cameraView.leadingAnchor),
            previewOverlayView.topAnchor.constraint(equalTo: cameraView.topAnchor),
            previewOverlayView.trailingAnchor.constraint(equalTo: cameraView.trailingAnchor),
            previewOverlayView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            
            
        ])
        
        self.view.layer.insertSublayer(previewLayer!, at: 0)
        let overlay = createOverlay()
        self.view.addSubview(overlay)
        
    }
    
    
    private func setUpAnnotationOverlayView() {
        cameraView.addSubview(annotationOverlayView)
        
        NSLayoutConstraint.activate([
            annotationOverlayView.topAnchor.constraint(equalTo: cameraView.topAnchor),
            annotationOverlayView.leadingAnchor.constraint(equalTo: cameraView.leadingAnchor),
            annotationOverlayView.trailingAnchor.constraint(equalTo: cameraView.trailingAnchor),
            annotationOverlayView.bottomAnchor.constraint(equalTo: cameraView.bottomAnchor),
            
            
        ])
    }
    
    
    private func captureDevice(forPosition position: AVCaptureDevice.Position) -> AVCaptureDevice? {
        if #available(iOS 13.0 , *) {
            let discoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDuoCamera, .builtInTelephotoCamera],
                mediaType: .video,
                position: .back // builtInWideAngleCamera
            )
            self.cameraDevice = discoverySession.devices.first { $0.position == position }
            return discoverySession.devices.first { $0.position == position }
        }
        
        return nil
    }
    
    private func presentDetectorsAlertController() {
        let alertController = UIAlertController(
            title: Constant.alertControllerTitle,
            message: Constant.alertControllerMessage,
            preferredStyle: .alert
        )
        weak var weakSelf = self
        detectors.forEach { detectorType in
            let action = UIAlertAction(title: detectorType.rawValue, style: .default) {
                [unowned self] (action) in
                guard let value = action.title else { return }
                guard let detector = Detector(rawValue: value) else { return }
                guard let strongSelf = weakSelf else {
                    print("Self is nil!")
                    return
                }
                strongSelf.currentDetector = detector
                strongSelf.removeDetectionAnnotations()
            }
            if detectorType.rawValue == self.currentDetector.rawValue { action.isEnabled = false }
            alertController.addAction(action)
        }
        alertController.addAction(UIAlertAction(title: Constant.cancelActionTitleText, style: .cancel))
        present(alertController, animated: true)
    }
    
    private func removeDetectionAnnotations() {
        for annotationView in annotationOverlayView.subviews {
            annotationView.removeFromSuperview()
        }
    }
    
    private func updatePreviewOverlayViewWithLastFrame() {
        guard let lastFrame = lastFrame,
              let imageBuffer = CMSampleBufferGetImageBuffer(lastFrame)
        else {
            return
        }
        self.updatePreviewOverlayViewWithImageBuffer(imageBuffer)
        self.removeDetectionAnnotations()
    }
    
    private func updatePreviewOverlayViewWithImageBuffer(_ imageBuffer: CVImageBuffer?) {
        guard let imageBuffer = imageBuffer else {
            return
        }
        let orientation: UIImage.Orientation = isUsingFrontCamera ? .leftMirrored : .right
        let image = UIUtilities.createUIImage(from: imageBuffer, orientation: orientation)
        previewOverlayView.image = image
    }
    
    private func convertedPoints(
        from points: [NSValue]?,
        width: CGFloat,
        height: CGFloat
    ) -> [NSValue]? {
        return points?.map {
            let cgPointValue = $0.cgPointValue
            let normalizedPoint = CGPoint(x: cgPointValue.x / width, y: cgPointValue.y / height)
            let cgPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
            let value = NSValue(cgPoint: cgPoint)
            return value
        }
    }
    
    private func normalizedPoint(
        fromVisionPoint point: VisionPoint,
        width: CGFloat,
        height: CGFloat
    ) -> CGPoint {
        let cgPoint = CGPoint(x: point.x, y: point.y)
        var normalizedPoint = CGPoint(x: cgPoint.x / width, y: cgPoint.y / height)
        normalizedPoint = previewLayer.layerPointConverted(fromCaptureDevicePoint: normalizedPoint)
        return normalizedPoint
    }
 
    private func resetManagedLifecycleDetectors(activeDetector: Detector) {
        if activeDetector == self.lastDetector {
            return
        }
        switch self.lastDetector {
        default:
            break
        }
        switch activeDetector {
        default:
            break
        }
        self.lastDetector = activeDetector
    }
    
    private func rotate(_ view: UIView, orientation: UIImage.Orientation) {
        var degree: CGFloat = 0.0
        switch orientation {
        case .up, .upMirrored:
            degree = 90.0
        case .rightMirrored, .left:
            degree = 180.0
        case .down, .downMirrored:
            degree = 270.0
        case .leftMirrored, .right:
            degree = 0.0
        }
        view.transform = CGAffineTransform.init(rotationAngle: degree * 3.141592654 / 180)
    }
}

extension CameraViewController {
    
    @IBAction func toggleTorch(sender: UIButton) {
      guard
        let device = AVCaptureDevice.default(for: AVMediaType.video),
        device.hasTorch
      else { return }
      
      do {
        try device.lockForConfiguration()
        if isTorchOn {
          device.torchMode = .off
          isTorchOn = false
          btnTorch.setTitle("Turn on Flashlight".localized, for: .normal)
          device.videoZoomFactor = 1.0
          
        } else {
          device.torchMode = .on
          isTorchOn = true
          btnTorch.setTitle("Turn off Flashlight".localized, for: .normal)
          if UIDevice.modelName == "iPhone 15 Pro Max" || UIDevice.modelName == "iPhone 15 Pro" || UIDevice.modelName == "iPhone 15" || UIDevice.modelName == "iPhone 15 Plus"  {
            device.videoZoomFactor = 1.8
          }
          else {
            device.videoZoomFactor = 2.0
          }
          do {
            if UIDevice.modelName == "iPhone 15 Pro Max" || UIDevice.modelName == "iPhone 15 Pro" || UIDevice.modelName == "iPhone 15" || UIDevice.modelName == "iPhone 15 Plus" {
              try device.setTorchModeOn(level: 0.050)
            }
            else {
              try device.setTorchModeOn(level: 0.060)
            }
            
          } catch {
            print("Error")
            
          }
          
        }
        device.unlockForConfiguration()
      } catch {
        print("Torch could not be used")
      }
    }
    
}


// MARK: AVCaptureVideoDataOutputSampleBufferDelegate

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(
        _ output: AVCaptureOutput,
        didOutput sampleBuffer: CMSampleBuffer,
        from connection: AVCaptureConnection
    ) {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            print("Failed to get image buffer from sample buffer.")
            return
        }
  
        let activeDetector = self.currentDetector
        resetManagedLifecycleDetectors(activeDetector: activeDetector)
        
        lastFrame = sampleBuffer
        let visionImage = VisionImage(buffer: sampleBuffer)
        let orientation = UIUtilities.imageOrientation(
            fromDevicePosition: isUsingFrontCamera ? .front : .back
        )
        visionImage.orientation = orientation
        
        guard let inputImage = MLImage(sampleBuffer: sampleBuffer) else {
            print("Failed to create MLImage from sample buffer.")
            return
        }
        inputImage.orientation = orientation
        
        let imageWidth = CGFloat(CVPixelBufferGetWidth(imageBuffer))
        let imageHeight = CGFloat(CVPixelBufferGetHeight(imageBuffer))
        
        switch activeDetector {
        case .onDeviceBarcode:
            scanBarcodesOnDevice(in: visionImage, width: imageWidth, height: imageHeight)
        case .onDeviceText:
            recognizeTextOnDevice(
                in: visionImage, width: imageWidth, height: imageHeight, detectorType: activeDetector)
         
            
        }
    }
}

// MARK: - Constants

public enum Detector: String {
    case onDeviceBarcode = "Barcode Scanning"
    case onDeviceText = "Text Recognition"
 
}

private enum Constant {
    static let alertControllerTitle = "Vision Detectors"
    static let alertControllerMessage = "Select a detector"
    static let cancelActionTitleText = "Cancel"
    static let videoDataOutputQueueLabel = "com.google.mlkit.visiondetector.VideoDataOutputQueue"
    static let sessionQueueLabel = "com.google.mlkit.visiondetector.SessionQueue"
    static let noResultsMessage = "No Results"
    static let localModelFile = (name: "bird", type: "tflite")
    static let labelConfidenceThreshold = 0.75
    static let smallDotRadius: CGFloat = 4.0
    static let lineWidth: CGFloat = 1.0
    static let originalScale: CGFloat = 1.0
    static let padding: CGFloat = 1.0
    static let resultsLabelHeight: CGFloat = 200.0
    static let resultsLabelLines = 5
    static let imageLabelResultFrameX = 0.4
    static let imageLabelResultFrameY = 0.1
    static let imageLabelResultFrameWidth = 0.5
    static let imageLabelResultFrameHeight = 0.8
    static let segmentationMaskAlpha: CGFloat = 0.5
}


extension AVCaptureDevice {
    func getUIZoomValues() -> [Float] {
        let maxDigitalZoom: Float = 5
        guard #available(iOS 13, *) else { return [1, maxDigitalZoom] }
        
        let uiZoomValues: [Float]
        let factors = virtualDeviceSwitchOverVideoZoomFactors
        
        switch deviceType {
        case .builtInTripleCamera, .builtInDualWideCamera:
            let firstZoom: Float = 1.0 / factors.first!.floatValue
            uiZoomValues = [firstZoom] + factors.map { $0.floatValue * firstZoom } + [firstZoom * factors.last!.floatValue * maxDigitalZoom]
        case .builtInDualCamera:
            uiZoomValues = [1.0] + factors.map { $0.floatValue } + [factors.last!.floatValue * maxDigitalZoom]
        case .builtInWideAngleCamera:
            uiZoomValues = [1, maxDigitalZoom]
        default:
            fatalError("this should not happen on a real device")
        }
        
        return uiZoomValues
    }
}


extension AVCaptureVideoPreviewLayer {
    func rectOfInterestConverted(parentRect: CGRect, fromLayerRect: CGRect) -> CGRect {
        let parentWidth = parentRect.width
        let parentHeight = parentRect.height
        let newX = (parentWidth - fromLayerRect.maxX)/parentWidth
        let newY = 1 - (parentHeight - fromLayerRect.minY)/parentHeight
        let width = 1 - (fromLayerRect.minX/parentWidth + newX)
        let height = (fromLayerRect.maxY/parentHeight) - newY
        
        return CGRect(x: newX, y: newY, width: width, height: height)
    }
    
    
    
}
