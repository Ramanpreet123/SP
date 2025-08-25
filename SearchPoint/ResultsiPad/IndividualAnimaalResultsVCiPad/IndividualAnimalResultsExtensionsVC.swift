//
//  IndividualAnimalResultsExtensionsVC.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 21/05/25.
//

import Foundation
import UIKit
import Alamofire

//MARK: IMAGEPICKER CONTROLLER DELEGATE AND GET NOTES AND PHOTOS API
extension IndividualAnimalResultsVCiPad: UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIPopoverPresentationControllerDelegate {
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    func showAlert() {
        let alert = UIAlertController(title:NSLocalizedString(LocalizedStrings.imageSelection, comment: "") , message: NSLocalizedString(LocalizedStrings.pickImageStr, comment: ""), preferredStyle: .actionSheet)
        alert.popoverPresentationController?.delegate = self
        alert.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .camera)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Photo Library", comment: ""), style: .default, handler: {(action: UIAlertAction) in
            self.getImage(fromSourceType: .photoLibrary)
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.sourceView = self.view
        popoverPresentationController.sourceRect = CGRect(x: 100, y: 100, width: 1, height: 1)
    }
    
    private func getImage(fromSourceType sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = sourceType
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    func noteupdateinapi(animalId:String,notes:String, completionHandler:  @escaping (Bool) -> ()){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.savenote.rawValue).getUrl()
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else{
            animalIDIS = animalID ?? ""
        }
        let parameters : [String: Any] = [keyValue.animalId.rawValue: animalIDIS,keyValue.notes.rawValue:notes]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case .success(_):
                    return completionHandler(true)
                    
                case let .failure(error):
                    print(error)
                }
            }
            else {
                self.hideIndicator()
            }
        }
        return
    }
    
    func getPhoto() {
        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else{
            animalIDIS = animalID ?? ""
        }
        let urlString = Configuration.Dev(packet: ApiKeys.getPhotoByAnimalId.rawValue + "/\(animalIDIS)").getUrl()
        print(urlString)
        var request = URLRequest(url: (URL(string: urlString) ?? URL(string: ""))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
        }
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    print(value)
                    let groupid = value as? NSDictionary
                    if groupid?.value(forKey: keyValue.messageKey.rawValue) as! String == LocalizedStrings.noPhotoSaved{
                        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                            updategroupPhotoNil(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                            self.profileImgView.image = nil
                        }
                        else{
                            updatePhotoNil(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                            self.profileImgView.image = nil
                        }
                    }
                    
                    else  if groupid?.value(forKey: keyValue.messageKey.rawValue) as! String == "Okay"{
                        let imageBase64 = groupid?.value(forKey: keyValue.photoBase64Encoded.rawValue) as? String ?? ""
                        if imageBase64 != "" {
                            let newImage = self.convertBase64StringToImage(imageBase64String: imageBase64 )
                            let img =   newImage
                            if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                                updategroupPhotoAgainstFarmIdOfficalId(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID ),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",photos: img)
                            }
                            else{
                                updatePhotoAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID ),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",photos: img)
                            }
                        }
                    }
                    
                    
                case let .failure(error):
                    print(error)
                }
                
            } else {
                self.hideIndicator()
            }
            
            if statusCode == 200 {
                
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
            self.hideIndicator()
        }
    }
    
    func getNote() {
        self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else{
            animalIDIS = animalID ?? ""
        }
        let urlString = Configuration.Dev(packet: ApiKeys.getnotes.rawValue + "/\(animalIDIS)").getUrl()
        print(urlString)
        var request = URLRequest(url: (URL(string: urlString) ?? URL(string: ""))!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
        }
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    print(value)
                    let groupid = value as? NSDictionary
                    
                    let getnotestext = groupid?.value(forKey:keyValue.notes.rawValue) ?? ""
                    self.notesTextView.text = getnotestext as? String
                    updateNotesAgainstgroupscren(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",notes: self.notesTextView.text ?? "")
                    updateNotesAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID) ,onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",notes: self.notesTextView.text ?? "")
                    self.getPhoto()
                case let .failure(error):
                    print(error)
                }
            }
            else {
                self.hideIndicator()
            }
            
            if statusCode == 200 {
                DispatchQueue.main.async {
                    self.hideIndicator()
                }
            }
            self.hideIndicator()
        }
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        let imageData = Data.init(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters)
        let image = UIImage(data: imageData!)
        return image!
    }
    
    func photoupdateinapi(animalId:String,photoBase64Encoded:String,fileName:String, completionHandler:  @escaping (NSDictionary) -> ()){
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        let urlString = Configuration.Dev(packet: ApiKeys.savephoto.rawValue).getUrl()
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else{
            animalIDIS = animalID ?? ""
        }
        
        let parameters : [String: Any] = [keyValue.animalId.rawValue: animalIDIS,keyValue.photoBase64Encoded.rawValue:photoBase64Encoded,"fileName": ".jpg"]
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                
                switch response.result {
                case let .success(value):
                    return completionHandler(value as! NSDictionary)
                    
                case let .failure(error):
                    print(error)
                }
            }
            else {
                self.hideIndicator()
            }
        }
        return
    }
    
    func deletePhoto(animalId:String,customerId:Int64) {
        let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
        let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
        var animalIDIS = String()
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let animalidgroup = UserDefaults.standard.value(forKey: keyValue.groupOnAnimalId.rawValue)
            animalIDIS = animalidgroup as? String ?? ""
        }
        else{
            animalIDIS = animalID ?? ""
        }
        
        let urlString = Configuration.Dev(packet: ApiKeys.deletphoto.rawValue + "/\(animalIDIS)").getUrl()
        let parameters = [String: Any]()
        var request = URLRequest(url: URL(string: urlString)! )
        request.httpMethod = "DELETE"
        request.allHTTPHeaderFields = headerDict
        request.setValue(LocalizedStrings.appJson, forHTTPHeaderField: LocalizedStrings.contentType)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
        
        AF.request(request as URLRequestConvertible).responseJSON { response in
            let statusCode =  response.response?.statusCode
            if statusCode == 200 {
                switch response.result {
                case let .success(value):
                    print(value)
                    if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                        updategroupPhotoNil(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                    }
                    else{
                        updatePhotoNil(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "")
                    }
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.imageDeleted, comment: ""), duration: 0.5, position: .bottom)
                    self.getPhoto()
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        self.dismiss(animated: true) { [weak self] in
            guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else { return }
            self?.imageBackroundView.isHidden = false
            self?.imageBackroundView.isHidden = false
            self?.imageContainer.isHidden = false
            self?.donebuttonlb.isHidden = false
            self?.deleteLbl.isHidden = false
            self?.replaceLbl.isHidden = false
            self?.replaceBtnOutlet.isHidden = false
            self?.deleteBtnOutlet.isHidden = false
            self?.profileImgView.isHidden = false
            self?.profileImgView.image = image
            self?.profileImgView.alpha = 1
            let chosenImage = self?.profileImgView.image
            let fixedImage = chosenImage!.fixedOrientation()
            let fixedImageNew = self?.resizeImage(image: fixedImage, targetSize: CGSize(width: 400.0, height: 400.0))
            let compressData = fixedImageNew?.jpegData(compressionQuality:0.8)
            let compressedImage = UIImage(data: compressData!)
            let binaryString = compressedImage?.toBase64()
            if Connectivity.isConnectedToInternet() {
                self?.showIndicator((self?.view)!, withTitle: NSLocalizedString("", comment: ""), and: "")
                
                self?.photoupdateinapi(animalId: self?.animalID ?? "", photoBase64Encoded: binaryString ?? "", fileName: "", completionHandler: { (success) -> Void in
                    print(success)
                    updatePhotoAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self?.custmerID ?? 0),onFarmID: self?.farmID ?? "" ,officialID: self?.officialID ?? "",photos: image)
                    self?.hideIndicator()
                })
            }
        }
    }
    
    @objc func imageWasSavedSuccessfully(_ image: UIImage, didFinishSavingWithError error: NSError!, context: UnsafeMutableRawPointer){
        if error != nil {
        } else {
            let actualHeight:CGFloat = image.size.height
            let actualWidth:CGFloat = image.size.width
            let imgRatio:CGFloat = actualWidth/actualHeight
            let maxWidth:CGFloat = 50
            let resizedHeight:CGFloat = maxWidth/imgRatio
            let compressionQuality:CGFloat = 0.5
            let rect:CGRect = CGRect(x: 0, y:0, width: maxWidth, height: resizedHeight)
            UIGraphicsBeginImageContext(rect.size)
            image.draw(in: rect)
            let img = UIGraphicsGetImageFromCurrentImageContext()
            
            if img != nil{
                let imageData:Data = img?.jpegData(compressionQuality: compressionQuality) ?? Data()
                UIGraphicsEndImageContext()
                let image = UIImage(data: imageData)!
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    updategroupPhotoAgainstFarmIdOfficalId(entity: Entities.resultGroupAnimalsTblEntity,custmerId: Int(self.custmerID ),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",photos: image)
                }
                else{
                    updatePhotoAgainstFarmIdOfficalId(entity: Entities.resultMyherdDataTblEntity,custmerId: Int(self.custmerID ),onFarmID: self.farmID ?? "" ,officialID: self.officialID ?? "",photos: image)
                }
            }
        }
    }
    
    func convertImageToBase64String(img: UIImage) -> String {
        let imageData:NSData = img.jpegData(compressionQuality: 0.3)! as NSData
        let imgString = imageData.base64EncodedString(options: .init(rawValue: 0))
        return imgString
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imageBackroundView.isHidden = true
        imageContainer.isHidden = true
        deleteLbl.isHidden = true
        replaceLbl.isHidden = true
        donebuttonlb.isHidden = true
        replaceBtnOutlet.isHidden = true
        deleteBtnOutlet.isHidden = true
        profileImgView.isHidden = true
        
        picker.dismiss(animated: true, completion: nil)
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

