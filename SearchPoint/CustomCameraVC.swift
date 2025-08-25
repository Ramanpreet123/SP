//
//  CustomCameraVC.swift
//  VisionExample
//
//  Created by Mobile Programming on 10/01/23.
//  Copyright © 2023 Google Inc. All rights reserved.
//

import UIKit
import AVFoundation


class CustomCameraVC: UIViewController {
    
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image:UIImage?
    var delegate: CustomCamVCDelegate?
    
    
    @IBOutlet weak var camButton: UIButton? {
        didSet {
            camButton?.layer.cornerRadius = 35.0
            camButton?.backgroundColor = .white
            camButton?.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices{
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
                
            }else if device.position == AVCaptureDevice.Position.front{
                frontCamera = device
            }
        }
        
        currentCamera = backCamera
    }
    
    func setupInputOutput() {
        do {
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format:[AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
        let overlay = createOverlay()
        self.view.addSubview(overlay)
    }
    
    func startRunningCaptureSession() {
        captureSession.startRunning()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func cameraButtonTouch(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func createOverlay() -> UIView {
        let overlayView = UIView(frame: CGRect(x: 20, y: (Int(self.view.frame.height) / 2) - 100, width: (Int(self.view.frame.width) - 40), height: 200))
        overlayView.backgroundColor = UIColor.gray.withAlphaComponent(0.01)
        
        let path = CGMutablePath()
        path.addRoundedRect(in: CGRect(x: 10, y: 10, width: overlayView.frame.width - 20, height: overlayView.frame.height - 20), cornerWidth: 15, cornerHeight: 15)
        
        
        path.closeSubpath()
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 1.5
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
    
}

extension CustomCameraVC: AVCapturePhotoCaptureDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        self.delegate?.imageCaptured(image!)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        if let imageData = photo.fileDataRepresentation(){
            image = UIImage(data: imageData)
            UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            self.delegate?.imageCaptured(image!)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
}
