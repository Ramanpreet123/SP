//
//  InheritBeefVCExtensions.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 03/02/25.
//

import Foundation
import UIKit
import CoreBluetooth

extension InheritBeefVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

extension InheritBeefVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblView {
            return importListArray.count
        }
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        }
        
        if btnTag == 20 {
            return tissueArr.count
        }
        else if btnTag == 10{
            return  breedArr.count
        }
        else if btnTag == 40{
            return damRegArr.count
        }
        else if btnTag == 50{
            return inheritTissueArr.count
        }
        else if btnTag == 60{
            return inheritBreedArr.count
        }
        else if btnTag == 70{
            return inheritRegArr.count
        }
        else if btnTag == 80{
            return breedRegArr.count
        } else if btnTag == 90{
            return inheritRegArr.count
        }
        else if btnTag == 110 {
            return self.genderArray.count
        }
        else{
            return sireRegArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 19)
        
        if tableView == importTblView {
            let cell :ImportListCell = importTblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImportListCell
            cell.listNameLabel.text = importListArray[indexPath.row].listName
            cell.listNameDescLbl.text = importListArray[indexPath.row].listDesc
            return cell
        }
        
      
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! PairedDeviceCell
            var deviceName = arrNearbyDevice[indexPath.row].name
            if deviceName == nil {
                deviceName = String(describing: arrNearbyDevice[indexPath.row].identifier)
            }
            
            cell.deviceLbl?.text = deviceName
            let state = arrNearbyDevice[indexPath.row].state
            if state == .connected{
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
                
            }
            return cell
        }
        
   //     if tableView == droperTableView {
            if btnTag == 20{
                let tissue = self.tissueArr[indexPath.row]  as? GetSampleTbl
                cell.textLabel?.text = tissue?.sampleName?.localized
                return cell
            }
            
            if btnTag == 10{
                let breed = breedArr[indexPath.row] as? GetBreedsTbl
                if breed?.threeCharCode == LocalizedStrings.breedNameX{
                    cell.textLabel?.text = "XX"
                    return cell
                }
                cell.textLabel?.text = breed?.threeCharCode
                return cell
            }
            if btnTag == 30 {
                let tissue = self.sireRegArr[indexPath.row]  as? GetBreedSocieties
                cell.textLabel?.text = tissue?.association
                return cell
            }
            if btnTag == 40{
                let tissue = self.damRegArr[indexPath.row]  as? GetBreedSocieties
                cell.textLabel?.text = tissue?.association
            }
            if btnTag == 80{
                let tissue = self.breedRegArr[indexPath.row]  as? GetBreedSocieties
                cell.textLabel?.text = tissue?.association
            }
            if btnTag == 50{
                if inheritTissueArr.count > 0 {
                    let tissue = self.inheritTissueArr[indexPath.row]  as? GetSampleTbl
                    cell.textLabel?.text = tissue?.sampleName?.localized
                }
            
                return cell
            }
            
            if btnTag == 60{
                let breed = inheritBreedArr[indexPath.row] as? GetBreedsTbl
                if breed?.threeCharCode == LocalizedStrings.breedNameX{
                    cell.textLabel?.text = "XX"
                    return cell
                }
                cell.textLabel?.text = breed?.threeCharCode
                return cell
                
            }
            
            if btnTag == 110 {
                let gender = self.genderArray[indexPath.row] as? String
                cell.textLabel?.text = gender
                return cell
                
            }
            
            if btnTag == 70{
                let tissue = self.inheritRegArr[indexPath.row]  as? GetBreedSocieties
                cell.textLabel?.text =  tissue?.association
            }
            if btnTag == 90{
                let tissue = self.inheritRegArr[indexPath.row]  as? GetBreedSocieties
                cell.textLabel?.text =  tissue?.association
            }
            return cell
      //  }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        if tableView == importTblView {
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            listNameString = listName ?? ""
            listId = Int(listId1)
            return
        }
        
        if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row] as? GetSampleTbl
            tissuId = Int(tissue?.sampleId ?? 0)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(tissue?.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 10  {
            let breed = self.breedArr[indexPath.row] as? GetBreedsTbl
            breedId = breed?.breedId! ?? ""
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            if breed?.threeCharCode == LocalizedStrings.breedNameX{
                breedBtnOutlet.setTitle("XX", for: .normal)
            } else {
                breedBtnOutlet.setTitle(breed?.threeCharCode, for: .normal)
            }
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 110  {
            let gender = self.genderArray[indexPath.row]
            inheritGenderString = gender
            inheritMaleFemaleBttn.titleLabel?.font = inheritMaleFemaleBttn.titleLabel?.font.withSize(20)
            inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
            inheritMaleFemaleBttn.setTitle(gender, for: .normal)
            buttonbg2.removeFromSuperview()
            self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
            
        }
        
        if btnTag == 30{
            let sireReg = sireRegArr[indexPath.row] as? GetBreedSocieties
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            sireRegDropdownOutlet.setTitle(sireReg?.association, for: .normal)
            UserDefaults.standard.set(sireReg?.association, forKey: keyValue.beefSireReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 40{
            let damReg = damRegArr[indexPath.row] as? GetBreedSocieties
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            damRegDropdownOutlet.setTitle(damReg?.association, for: .normal)
            UserDefaults.standard.set(damReg?.association, forKey: keyValue.beefDamReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 80{
            let breedReg = breedRegArr[indexPath.row] as? GetBreedSocieties
            breedRegBttn.setTitleColor(.black, for: .normal)
            breedRegBttn.setTitle(breedReg?.association, for: .normal)
            UserDefaults.standard.set(breedReg?.association, forKey: keyValue.beefBreedReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 50{
            let tissue = self.inheritTissueArr[indexPath.row] as? GetSampleTbl
            tissuId = Int(tissue?.sampleId ?? 0)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(tissue?.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            self.sampleTypeView.layer.borderColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if btnTag == 60{
            let breed = self.inheritBreedArr[indexPath.row] as? GetBreedsTbl
            breedId = breed?.breedId! ?? ""
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            if breed?.threeCharCode == LocalizedStrings.breedNameX{
                inheritBreedBttn.setTitle("XX", for: .normal)
            } else {
                inheritBreedBttn.setTitle(breed?.threeCharCode, for: .normal)
            }
            buttonbg2.removeFromSuperview()
            self.breedTypeView.layer.borderColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if btnTag == 70{
            let breedReg = inheritRegArr[indexPath.row] as? GetBreedSocieties
            inheritRegAssociationBttn.setTitleColor(.black, for: .normal)
            inheritRegAssociationBttn.setTitle(breedReg?.association?.localized, for: .normal)
            UserDefaults.standard.set(breedReg?.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
            self.breedAssociationView.layer.borderColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if btnTag == 90{
            let breedReg = inheritRegArr[indexPath.row] as? GetBreedSocieties
            inheriSireRedOutlet.setTitleColor(.black, for: .normal)
            inheriSireRedOutlet.setTitle(breedReg?.association, for: .normal)
            UserDefaults.standard.set(breedReg?.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
            self.sireRegAssociationView.layer.borderColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor
        }
        
        if tableView == pairedTableView {
            if BluetoothCentre.shared.smartBowPeripheral != nil {
                BluetoothCentre.shared.manager.cancelPeripheralConnection(BluetoothCentre.shared.smartBowPeripheral!)
            }
            BluetoothCentre.shared.ConnectArgument(peripheral: arrNearbyDevice[indexPath.row])
            pairedBackroundView.isHidden = true
            pairedDeviceView.isHidden = true
            pairedTableView.reloadData()
            return
        }
    }
}

extension InheritBeefVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if scanEarTagTextField == textField || inheritEarTagTextfield == textField {
            //  scanEarTagTextField.returnKeyType = .next
            inheritEarTagTextfield.returnKeyType = .next
        }
        
        if textField == inheritEarTagTextfield {
            viewsArray = [inheritBarcodeView, secondaryIDView, inheritEIDTagView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.inheritEarTagView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritBarcodeTextfield {
            viewsArray = [inheritEarTagView, secondaryIDView, inheritEIDTagView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.inheritBarcodeView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritEIDTextfield {
            viewsArray = [inheritEarTagView, secondaryIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.inheritEIDTagView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritSecondaryIdTextfield {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.secondaryIDView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritBreedRegTextfield {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.breedRegNumberView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritSireRegTextfield {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.sireRegNumberView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritSireYobBttn {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.sireYOBView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritDamIdTextfield {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, sireYOBView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.damIDView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
        if textField == inheritDamYobBttn {
            viewsArray = [inheritEarTagView, inheritEIDTagView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, sireYOBView, damIDView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1).cgColor)
            self.damYOBView.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if barAutoPopu == false {
            barcodeflag = true
        } else {
            let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
            if orederStatus.count > 0 {
                if textField == scanEarTagTextField || textField == inheritEarTagTextfield || textField == breedRegTextfield || textField == inheritBreedRegTextfield ||  textField == animalNameTextfield || textField == sireRegTextfield || textField == damRegTextfield || textField == inheritSireRegTextfield    || textField == inheritDamIdTextfield || textField == inheritEIDTextfield || textField == inheritSecondaryIdTextfield || textField == inheritDamYobBttn || textField == inheritSireYobBttn   {
                    barcodeEnable = true
                }
            }
        }
        if (string == " ") {
            return false
        }
        
        if textField == scanBarcodeTextfield {
            let currentString: NSString = scanBarcodeTextfield.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if textField == inheritBarcodeTextfield {
            let currentString: NSString = inheritBarcodeTextfield.text! as NSString
            let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
            barcodeflag = true
            if self.isBarcodeAutoIncrementedEnabled {
                if isBarCodeEndsWithNumber_GetIncrementedBarCode(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.checkImg)
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                    
                } else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField == scanEarTagTextField{
                    if scanEarTagTextField.text!.count == 1 {
                        textFieldBackroungGrey()
                    } else {
                        textFieldBackroungWhite()
                    }
                    isautoPopulated = false
                }
                if textField == inheritEarTagTextfield{
                    if newString.count == 1  {
                        inheritTextFieldBackroungGrey()
                    } else {
                        
                        inherittextFieldBackroungWhite()
                    }
                    isautoPopulated = false
                    
                }
                if textField == breedRegTextfield{
                    if breedRegTextfield.text!.count == 1 {
                    }
                }
                if textField == damRegTextfield{
                    if damRegTextfield.text!.count == 1 {
                    }
                }
                if textField == inheritSireRegTextfield{
                    if inheritSireRegTextfield.text!.count == 1 {
                        inheriSireRedOutlet.setTitleColor(.black, for: .normal)
                    }
                }
                
                if textField == scanBarcodeTextfield {
                    barcodeflag = true
                    if scanBarcodeTextfield.text!.count == 1 {
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    }
                }
                if textField == inheritBarcodeTextfield {
                    barcodeflag = true
                    if inheritBarcodeTextfield.text!.count == 1 {
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        checkBarcode = false
                    }
                }
                
            } else {
                if textField == inheritDamYobBttn || textField == inheritSireYobBttn {
                    let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let length = textstring.count
                    let ACCEPTABLE_CHARACTERS = "0123456789"
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    if check == false {
                        return false
                    }
                    if length > 4 {
                        return false
                    }
                }
                if textField == inheritBarcodeTextfield || textField == scanBarcodeTextfield {
                    let ACCEPTABLE_CHARACTERS = LocalizedStrings.abcdNumberFormat
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    if check == false {
                        return false
                    }
                }
                if textField == inheritEarTagTextfield || textField == scanEarTagTextField {
                    let ACCEPTABLE_CHARACTERS = LocalizedStrings.earTagRegex
                    let check  = ACCEPTABLE_CHARACTERS.contains(string)
                    if check == false {
                        return false
                    }
                }
                
                if textField == inheritDateTextField {
                    if inheritDateTextField.text?.count == 2 || inheritDateTextField.text?.count == 5{
                        inheritDateTextField.text?.append("/")
                    }
                    if inheritDateTextField.text?.count == 10 {
                        return false
                    }
                    
                }
                if textField == globalDateTextField {
                    if globalDateTextField.text?.count == 2 || globalDateTextField.text?.count == 5{
                        globalDateTextField.text?.append("/")
                    }
                    if globalDateTextField.text?.count == 10 {
                        return false
                    }
                    
                }
                if textField == scanEarTagTextField{
                    isautoPopulated = false
                    textFieldBackroungWhite()
                }
                if textField == inheritEarTagTextfield{
                    isautoPopulated = false
                    inherittextFieldBackroungWhite()
                }
                if textField == breedRegTextfield{
                    breedRegBttn.isEnabled = true
                }
                if textField ==  sireRegTextfield {
                    sireRegDropdownOutlet.isEnabled = true
                }
                if textField == inheritSireRegTextfield {
                    inheriSireRedOutlet.backgroundColor = UIColor.white
                    inheriSireRedOutlet.setTitleColor(.black, for: .normal)
                }
                if textField == damRegTextfield{
                    damRegDropdownOutlet.isEnabled = true
                }
            }
            if editIngText == true{
                editIngText = false
            }
            
            else if isUpdate == true {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder == true{
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.beefAnimalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = false
                    }
                }
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == inheritDateTextField {
            if inheritDateTextField.text!.count != 0{
                if inheritDateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: inheritDateTextField.text ?? "")
                    if validate == LocalizedStrings.correctFormatStr {
                        //                        inheritDobBttn.layer.borderColor = UIColor.gray.cgColor
                        //                        inheritDobBttn.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                }
                else {
                    inheritDobBttn.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
        
        if textField == globalDateTextField {
            if globalDateTextField.text!.count != 0{
                if globalDateTextField.text?.count == 10 {
                    let validate = isValidDate(dateString: globalDateTextField.text ?? "")
                    if validate == LocalizedStrings.correctFormatStr {
                        //                        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
                        //                        dateBttnOutlet.layer.borderWidth = 0.5
                        validateDateFlag = true
                    } else {
                        dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                } else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
        
        if textField == scanEarTagTextField {
            if scanEarTagTextField.text != "" {
                dataPopulateInFocusChange()
                
            }
        }
        else if textField == inheritEarTagTextfield {
            if inheritEarTagTextfield.text != "" {
                dataPopulateInFocusChange()
                incrementalBarcodeTitleLabelInherit.textColor = .black
                incrementalBarcodeButtonInherit.isEnabled = true
                incrementalBarcodeCheckBoxInherit.alpha = 1
                incrementalBarcodeTitleLabelInherit.alpha = 1
            }
        }
    }
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:"", farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId )
        if inheritEarTagTextfield.text != "" {
            let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
            let inheritAddAnimal = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalAddTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
            
            
            if isautoPopulated == false{
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                
                if inheritAddAnimal.count > 0 {
                    let data =  inheritAddAnimal.lastObject as! BeefAnimaladdTbl
                    let cartAnimal = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId)) as! [BeefAnimaladdTbl]
                    
                    if cartAnimal.count == 0 {}
                    else {
                        let filterAnimalCart = cartAnimal.filter({$0.animalbarCodeTag == data.animalbarCodeTag && $0.orderstatus == "false"})
                        if filterAnimalCart.count > 0  {
                            isAnimalComingFromCart = true
                        }
                    }
                    
                    autoPopulateAnimalData = data
                    let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                    animalId1 = Int(data.animalId)
                    barcodeflag = false
                    inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                    inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                    let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                    let formatter = DateFormatter()
                    inheritDobBttn.titleLabel?.text = ""
                    
                    if data.date != ""{
                        if dateStr == "MM"{
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = month + "/" + date + "/" + year
                                yearPublic = Int(year)!
                            }
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.MMddyyyyFormat
                        }
                        else {
                            var dateVale = ""
                            let values = data.date!.components(separatedBy: "/")
                            
                            if values.count > 1{
                                let date = values[0]
                                let month = values[1]
                                let year = values[2]
                                dateVale = date + "/" + month + "/" + year
                                yearPublic = Int(year)!
                            }
                            
                            if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                                inheritDateTextField.text = dateVale
                            } else {
                                inheritDobBttn.setTitle(dateVale, for: .normal)
                            }
                            formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                        }
                        
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        }
                        else {
                            if inheritDobBttn.titleLabel!.text == nil {
                                self.InheritSelectedDate = Date()
                            }
                            else{
                                self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                            }
                        }
                    }
                    
                    inheritBreedRegTextfield.text = data.offPermanentId
                    inheritSireRegTextfield.text = data.offsireId
                    inheritDamIdTextfield.text = data.offDamId
                    inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                    let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                    if dataFetch.count == 0 {
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                        incrementalBarcodeButtonInherit.isEnabled = true
                    } else {
                        let orStatus = dataFetch[0] as? BeefAnimaladdTbl
                        if orStatus?.orderstatus == "true"{
                            checkBarcode = false
                            incrementalBarcodeTitleLabelInherit.textColor = .black
                            incrementalBarcodeButtonInherit.isEnabled = true
                            incrementalBarcodeTitleLabelInherit.alpha = 1
                            incrementalBarcodeCheckBoxInherit.alpha = 1
                        } else {
                            inheritBarcodeTextfield.text = data.animalbarCodeTag
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                            UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                            self.isBarcodeAutoIncrementedEnabled = false
                            incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                            incrementalBarcodeButtonInherit.isEnabled = false
                            incrementalBarcodeTitleLabelInherit.textColor = .gray
                            checkBarcode = false
                        }}
                    if data.breedName == LocalizedStrings.breedNameX{
                        inheritBreedBttn.setTitle("XX", for: .normal)
                    } else {
                        inheritBreedBttn.setTitle(data.breedName, for: .normal)
                    }
                    
                    inheritTissueBttn.setTitleColor(.black, for: .normal)
                    inheritBreedBttn.setTitleColor(.black, for: .normal)
                    inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefInheritTSU.rawValue)
                    inheritSireYobBttn.text = data.sireYOB
                    inheritDamYobBttn.text = data.damYOB
                    breedId = data.breedId!
                    UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                    inheritEIDTextfield.text = data.sireIDAU
                    inheritSecondaryIdTextfield.text = data.nationHerdAU
                    inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
                    if data.gender == "Male".localized || data.gender == "M"{
                        //    self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                        inheritGenderToggleFlag = 1
                        inheritGenderString = NSLocalizedString("Male", comment: "")
                    }
                    else {
                        // self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                        inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                        inheritGenderToggleFlag = 0
                        inheritGenderString = "Female".localized
                    }
                    
                    tissuId = Int(data.tissuId)
                    
                    inheritDobBttn.setTitleColor(.black, for: .normal)
                    statusOrder = false
                    messageCheck = false
                    let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        messageCheck = true
                    }
                    
                    if data.eT == "" || data.eT == nil {
                        inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                    }
                    if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                        inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                    }
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:"", farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId )
        let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
        
        if isautoPopulated == false{
            if animalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                textFieldBackroungWhite()
                updateOrder = true
                let data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                    incrementalBarcodeButtonGlobal.isEnabled = true
                } else {
                    if data.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .black
                        incrementalBarcodeButtonGlobal.isEnabled = true
                        incrementalBarcodeTitleLabelGlobal.alpha = 1
                        incrementalBarcodeCheckBoxGlobal.alpha = 1
                    }
                    else {
                        scanBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxGlobal.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonGlobal.isEnabled = false
                        incrementalBarcodeTitleLabelGlobal.textColor = .gray
                        incrementalBarcodeTitleLabelGlobal.alpha = 0.6
                        incrementalBarcodeCheckBoxGlobal.alpha = 0.6
                        checkBarcode = false
                    }
                }
                
                earTagView.layer.borderColor = UIColor.gray.cgColor
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                dateBttnOutlet.titleLabel?.text = ""
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                if data.date != ""{
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1 {
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            globalDateTextField.text = dateVale
                        } else {
                            dateBttnOutlet.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        
                    } else {
                        if dateBttnOutlet.titleLabel!.text == nil {
                            self.selectedDate = Date()
                        }
                        else {
                            self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                            
                        }
                    }
                }
                
                barcodeflag = false
                breedRegTextfield.text = data.offPermanentId
                sireRegTextfield.text = data.offsireId
                damRegTextfield.text = data.offDamId
                animalNameTextfield.text  = data.eT
                if data.breedName == LocalizedStrings.breedNameX{
                    breedBtnOutlet.setTitle("XX", for: .normal)
                } else {
                    breedBtnOutlet.setTitle(data.breedName, for: .normal)
                }
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.beefTSU.rawValue)
                
                if data.farmId != ""{
                    breedRegBttn.setTitle(data.farmId, for: .normal)
                    breedRegBttn.setTitleColor(.black, for: .normal)
                }
                if data.sireIDAU != ""{
                    sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                if data.nationHerdAU != ""{
                    damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                breedRegBttn.backgroundColor = .white
                sireRegDropdownOutlet.backgroundColor = .white
                damRegDropdownOutlet.backgroundColor = .white
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.beefBreed.rawValue)
                
                if data.gender == "Male".localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString("Male", comment: "")
                    
                } else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = "Female".localized
                    
                }
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
            }
            
            if inheritAnimalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                let data =  inheritAnimalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                self.isBarcodeAutoIncrementedEnabled = false
                barcodeflag = false
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                inheritDobBttn.titleLabel?.text = ""
                
                if data.date != "" {
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = month + "/" + date + "/" + year
                            yearPublic = Int(year)!
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.MMddyyyyFormat
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                        
                        if values.count > 1{
                            let date = values[0]
                            let month = values[1]
                            let year = values[2]
                            dateVale = date + "/" + month + "/" + year
                            yearPublic = Int(year)!
                            
                        }
                        if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                            inheritDateTextField.text = dateVale
                        }else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String == keyValue.defaultEntry.rawValue {
                        
                    }else {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                    }
                }
                
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    incrementalBarcodeButtonInherit.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? BeefAnimaladdTbl
                    
                    if orStatus?.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    } else {
                        inheritBarcodeTextfield.text = data.animalbarCodeTag
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                        UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncrementalClear.rawValue)
                        self.isBarcodeAutoIncrementedEnabled = false
                        incrementalBarcodeCheckBoxInherit.image = UIImage(named: ImageNames.incrementalCheckImg)
                        incrementalBarcodeButtonInherit.isEnabled = false
                        incrementalBarcodeTitleLabelInherit.textColor = .gray
                        checkBarcode = false
                    }
                }
                
                inheritBreedRegTextfield.text = data.offPermanentId
                inheritSireRegTextfield.text = data.offsireId
                inheritDamIdTextfield.text = data.offDamId
                inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                
                if data.breedName == LocalizedStrings.breedNameX{
                    inheritBreedBttn.setTitle("XX", for: .normal)
                } else {
                    inheritBreedBttn.setTitle(data.breedName, for: .normal)
                }
                
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritBreedBttn.setTitleColor(.black, for: .normal)
                inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.beefInheritTSU.rawValue)
                inheritSireYobBttn.text = data.sireYOB
                inheritDamYobBttn.text = data.damYOB
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritRegAssociationBttn.setTitle(data.eT?.localized, for: .normal)
                if data.gender == "Male".localized || data.gender == "M"{
                    //  self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString("Male", comment: "")
                }
                else {
                    //   self.inheritMaleFemaleBttn.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                    inheritGenderToggleFlag = 0
                    inheritGenderString = "Female".localized
                }
                
                tissuId = Int(data.tissuId)
                textField.resignFirstResponder()
                inheritDobBttn.setTitleColor(.black, for: .normal)
                statusOrder = false
                messageCheck = false
                let adata = fetchAllDataOrderStatusMaster(entityName: Entities.beefAnimalMasterTblEntity, ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    messageCheck = true
                }
            }
        }
        else{
            //            if scanEarTagTextField.text!.count > 0 {
            //                textFieldBackroungWhite()
            //            }
            //            else{
            //                textFieldBackroungGrey()
            //            }
        }
        
        //        if textField == scanEarTagTextField {
        //            if scanEarTagTextField.text == ""{
        //                earTagView.layer.borderColor = UIColor.red.cgColor
        //            }
        //            else {
        //                earTagView.layer.borderColor = UIColor.gray.cgColor
        //            }
        //            scanBarcodeTextfield.becomeFirstResponder()
        //        }
        //
        //        if textField == scanBarcodeTextfield {
        //            if scanBarcodeTextfield.text == ""{
        //                barcodeView.layer.borderColor = UIColor.red.cgColor
        //            }
        //            else {
        //                barcodeView.layer.borderColor = UIColor.gray.cgColor
        //            }
        //            breedRegTextfield.becomeFirstResponder()
        //        }
        //
        //        if textField == breedRegTextfield {
        //            animalNameTextfield.becomeFirstResponder()
        //        }
        //
        //        if textField == animalNameTextfield {
        //            sireRegTextfield.becomeFirstResponder()
        //        }
        //
        //        if textField == sireRegTextfield {
        //            damRegTextfield.becomeFirstResponder()
        //        }
        //
        //        if textField == damRegTextfield {
        //            textField.resignFirstResponder()
        //        }
        
        if textField == inheritEarTagTextfield {
            if inheritEarTagTextfield.text == ""{
                inheritEarTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            }
            inheritBarcodeTextfield.becomeFirstResponder()
        }
        if textField == inheritBarcodeTextfield{
            if inheritBarcodeTextfield.text == ""{
                inheritBarcodeView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
            }
            inheritEIDTextfield.becomeFirstResponder()
        }
        
        if textField == inheritEIDTextfield {
            inheritSecondaryIdTextfield.becomeFirstResponder()
        }
        if textField == inheritSecondaryIdTextfield {
            inheritBreedRegTextfield.becomeFirstResponder()
        }
        if textField == inheritBreedRegTextfield{
            inheritSireRegTextfield.becomeFirstResponder()
        }
        if textField == inheritSireRegTextfield{
            inheritSireYobBttn.becomeFirstResponder()
        }
        if textField == inheritSireYobBttn{
            inheritDamIdTextfield.becomeFirstResponder()
        }
        if textField == inheritDamIdTextfield{
            inheritDamYobBttn.becomeFirstResponder()
        }
        if textField == inheritDamYobBttn{
            textField.resignFirstResponder()
        }
        return true
    }
    
    func pageLoading() {
        self.NavigateToBeefOrderingScreen()
    }
    
    func timeStamp()-> String{
        let time1 = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatters.MMddyyyyHHmmssFormat
        let timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let udid = UserDefaults.standard.value(forKey: keyValue.applicationIdentifier.rawValue)! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    
}
extension InheritBeefVC : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
        isAnimalComingFromCart = true
        let animalID = temp
        let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalAddTblEntity, animalId:animalID,orderststus:"false", customerId: self.custmerId) as! [BeefAnimaladdTbl]
        if existAnimalData.count > 0{
            autoPopulateAnimalData = existAnimalData[0]
        }
    }
    
    func anOptionalMethod(check :Bool){
        if check == true{
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            inheritByDefaultSetting()
            textFieldBackroungGrey()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

extension InheritBeefVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.showbeefInheritTable.rawValue)
        inheritEarTagTextfield.becomeFirstResponder()
        UserDefaults.standard.set(InheritQuestionaireManager.shared.inheritQuestionaireModel?.selectedPrimaryBreedId, forKey: keyValue.selectedPrimaryBreed.rawValue)
        let arr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        for i in arr  {
            if (i as! GetBreedsTbl).breedName == InheritQuestionaireManager.shared.inheritQuestionaireModel?.getSelectedBreedType() {
                self.breedId = (i as! GetBreedsTbl).breedId ?? ""
                
                if (i as! GetBreedsTbl).breedId == "87c30632-8da0-4f86-8d94-46da17c520dd" {
                    inheritBreedBttn.setTitle("XX", for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).breedName, forKey: keyValue.inheritBeefbreed.rawValue)
                } else {
                    inheritBreedBttn.setTitle((i as! GetBreedsTbl).threeCharCode, for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.inheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).threeCharCode, forKey: keyValue.inheritBeefbreed.rawValue)
                }
            }
        }
    }
}

extension InheritBeefVC : AnimalMergeProtocol{
    func refreshUI() {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.cartView.isHidden = true
                //                self.globalCrossBtnOutlet.isHidden = true
                //                self.globalMergeListBtnOulet.isHidden = true
            }
            else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.cartView.isHidden = false
                //                self.globalCrossBtnOutlet.isHidden = false
                //                self.globalMergeListBtnOulet.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                    
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                globalMergeListBtnOulet.isHidden = true
                globalCrossBtnOutlet.isHidden = true
            }
        }
        else {
            let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
            self.notificationLblCount.text = String(animalCount.count)
            if animalCount.count == 0 {
                self.notificationLblCount.isHidden = true
                self.countLbl.isHidden = true
                self.cartView.isHidden = true
                //                self.inheritCrossBtnOutlet.isHidden = true
                //                self.InheritmergeListBtnOulet.isHidden = true
                self.mergeListView.isHidden = true
            }
            else {
                self.notificationLblCount.isHidden = false
                self.countLbl.isHidden = false
                self.cartView.isHidden = false
                //                self.inheritCrossBtnOutlet.isHidden = false
                //                self.InheritmergeListBtnOulet.isHidden = false
                self.mergeListView.isHidden = false
            }
            
            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid)
            if fetchObj.count != 0 {
                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                let obj = objectFetch?.listName
                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                
                if fetchAllMergeDta == 0 {
                    let fetchNameDisplay = String(obj ?? "")
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                } else {
                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                }
            }else {
                let attributeString = NSMutableAttributedString(string: "", attributes: self.attrs)
                InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                InheritmergeListBtnOulet.isHidden = true
                inheritCrossBtnOutlet.isHidden = true
                self.mergeListView.isHidden = true
            }
        }
    }
}

private typealias DataListGlobalHD50KCartHelper = InheritBeefVC
extension DataListGlobalHD50KCartHelper {
    func fetchDatalistDetailbyName(listName: String) -> [DataEntryList] {
        let fetchDataEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        return fetchDataEntry
    }
    
    func CheckCartanimalCount() {
        let viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        if viewAnimalArray.count > 0{
            createDataList()
        }
    }
    
    func createDataList(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: custmerId , providerID: pvid)
        if listName != "" {
            var animalID1 = UserDefaults.standard.integer(forKey: keyValue.listId.rawValue)
            if animalID1 == 0 {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
                
            } else {
                animalID1 = animalID1 + 1
                UserDefaults.standard.set(animalID1, forKey: keyValue.listId.rawValue)
            }
            self.hideIndicator()
            
            if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String == marketNameType.Beef.rawValue {
                if self.pvid == 5  {
                    var fetchDatEntry = [DataEntryList]()
                    var productType  = ""
                    fetchDatEntry =  fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(custmerId ),listName: listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
                    if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.capsInherit.rawValue {
                        productType = keyValue.capsInherit.rawValue
                    }
                    else {
                        productType = keyValue.globalHD50K.rawValue
                    }
                    
                    if fetchDatEntry.count == 0 {
                        saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(custmerId ),listDesc: "",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: productType, productName: marketNameType.Beef.rawValue)
                        
                        SaveAnimalDatInList(listID: Int64(animalID1), animalID: animalID1)
                        
                    } else {
                        let listIdGet = fetchDatEntry[0].listId
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry[0].listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let animalVal = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                                deleteAnimalfromdataEntry(enitityName: Entities.dataEntryBeefAnimalAddTblEntity, Int(animalVal.animalId), listId: Int(animalVal.listId))
                                //                                            deleteDataWithAnimaldataEntry(Int(animalVal.animalId),entityName: Entities.dataEntryBeefAnimalAddTblEntity)
                            }
                        }
                        SaveAnimalDatInList(listID: listIdGet, animalID: animalID1)
                    }
                }
            }
        }
    }
    
    func SaveAnimalDatInList(listID:Int64,animalID:Int){
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue{
            let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid) as! [BeefAnimaladdTbl]
            
            for data in animals {
                let animalData = checkAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:data.animalTag ?? ""  ,listId: Int(listID ), custmerId: custmerId ,providerID: self.pvid)
                if animalData.count == 0 {
                    saveAnimalInDataBeefAnimalGlobalHD50K(listID: listID, animalDetails: data, animalID: animalID)
                }
            }
        } else {
            let animals = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid) as! [BeefAnimaladdTbl]
            
            for data in animals {
                
                let animalData = checkAnimaldataValidateAnimalTagDataEntry(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:data.animalTag ?? ""  ,listId: Int(listID ), custmerId: custmerId , providerID: self.pvid)
                if animalData.count == 0 {
                    inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID: listID, animalDetails: data, animalID: animalID)
                }
            }
        }
    }
    
    func saveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
        saveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity,
                                      animalTag: animalDetails.animalTag ?? "",
                                      barCodetag: animalDetails.animalbarCodeTag ?? "" ,
                                      date: animalDetails.date ?? ""  ,
                                      damId: animalDetails.offDamId ?? "",
                                      sireId: animalDetails.offsireId ?? "" ,
                                      gender: animalDetails.gender ?? "",
                                      update: "true",
                                      permanentId:animalDetails.offPermanentId ?? "",
                                      tissuName: animalDetails.tissuName ?? "",
                                      breedName: animalDetails.breedName ?? "",
                                      et: animalDetails.eT ?? "",
                                      farmId: animalDetails.farmId ?? "",
                                      orderId: autoD,
                                      orderSataus:"false",
                                      breedId:animalDetails.breedId ?? "",
                                      isSync:"false",
                                      providerId: Int(animalDetails.providerId),
                                      tissuId: Int(animalDetails.tissuId),
                                      sireIDAU: animalDetails.sireIDAU ?? "",
                                      nationHerdAU: animalDetails.nationHerdAU ?? "",
                                      userId: userId,
                                      udid:animalDetails.udid ?? "",
                                      animalId: Int(animalDetails.animalId),
                                      productId:Int(animalDetails.productId),
                                      custId: Int(animalDetails.custmerId),
                                      listId: listID,
                                      serverAnimalId: "",
                                      tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
    
    func inheritSaveAnimalInDataBeefAnimalGlobalHD50K(listID:Int64, animalDetails:BeefAnimaladdTbl,animalID:Int) {
        inheritSaveAnimaldataBeefInProductId(entity: Entities.dataEntryBeefAnimalAddTblEntity,
                                             animalTag: animalDetails.animalTag ?? "",
                                             barCodetag: animalDetails.animalbarCodeTag ?? "",
                                             date: animalDetails.date ?? "" ,
                                             damId: animalDetails.offDamId ?? "",
                                             sireId: animalDetails.offsireId ?? "" ,
                                             gender: animalDetails.gender ?? "",
                                             update: "true",
                                             permanentId:animalDetails.offPermanentId ?? "",
                                             tissuName: animalDetails.tissuName ?? "",
                                             breedName: animalDetails.breedName ?? "",
                                             et: animalDetails.eT ?? "",
                                             farmId:animalDetails.farmId ?? "",
                                             orderId: autoD,
                                             orderSataus:"false",
                                             breedId:animalDetails.breedId ?? "",
                                             isSync:"false",
                                             providerId: Int(animalDetails.providerId ),
                                             tissuId: Int(animalDetails.tissuId ),
                                             sireIDAU: animalDetails.sireIDAU ?? "",
                                             nationHerdAU: animalDetails.nationHerdAU ?? "",
                                             userId: userId,
                                             udid:animalDetails.udid ?? "",
                                             animalId: Int(animalDetails.animalId ),
                                             productId:Int(animalDetails.productId ),
                                             sirYOB: animalDetails.sireYOB ?? "",
                                             damYOB: animalDetails.damYOB ?? "",
                                             sireRegAssocation: animalDetails.sireRegAssocation ?? "",
                                             custId: Int(animalDetails.custmerId ),
                                             listId: listID ,
                                             serverAnimalId: "",
                                             tertiaryGeno: animalDetails.tertiaryGeno ?? "")
    }
}
private typealias AutoImportDataListHelper = InheritBeefVC
extension AutoImportDataListHelper {
    func checkUserDataListName(){
        let orderingDataList = OrderingDataListViewModel()
        let listName = orderingDataList.makeListName(custmerId: self.custmerId , providerID: pvid)
        let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Beef.rawValue) as! [DataEntryList]
        if fetchDatEntry.count > 0{
            //  inheritCrossBtnOutlet.isHidden = true
            //  globalCrossBtnOutlet.isHidden = true
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid) as! [DataEntryBeefAnimaladdTbl]
            if fetchData11.count != 0 {
                
                for i in 0...fetchData11.count - 1 {
                    let fetchCartAnimal = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)) as! [BeefAnimaladdTbl]
                    let filterCartAnimal =  fetchCartAnimal.filter({ $0.animalTag == fetchData11[i].animalTag && $0.animalbarCodeTag == fetchData11[i].animalbarCodeTag})
                    if filterCartAnimal.count<0{
                        let dataGet = fetchData11[i]
                        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity,
                                                          animalTag: dataGet.animalTag ?? "",
                                                          barCodetag: dataGet.animalbarCodeTag ?? "" ,
                                                          date: dataGet.date ?? ""  ,
                                                          damId: dataGet.offDamId ?? "",
                                                          sireId: dataGet.offsireId ?? "" ,
                                                          gender: dataGet.gender ?? "",
                                                          update: "true",
                                                          permanentId:dataGet.offPermanentId ?? "",
                                                          tissuName: dataGet.tissuName ?? "",
                                                          breedName: dataGet.breedName ?? "",
                                                          et: dataGet.eT ?? "",
                                                          farmId: dataGet.farmId ?? "",
                                                          orderId: autoD,
                                                          orderSataus:"false",
                                                          breedId:dataGet.breedId ?? "",
                                                          isSync:"false",
                                                          providerId: pvid,
                                                          tissuId: Int(dataGet.tissuId),
                                                          sireIDAU: dataGet.sireIDAU ?? "",
                                                          nationHerdAU: dataGet.nationHerdAU ?? "",
                                                          userId: userId,
                                                          udid:dataGet.udid ?? "",
                                                          animalId: Int(dataGet.animalId),
                                                          productId:Int(dataGet.productId),
                                                          custId: Int(dataGet.custmerId),
                                                          listId: fetchDatEntry.first?.listId ?? 0,
                                                          serverAnimalId: "",
                                                          tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                            //   tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                //         breedBtnOutlet.setTitle("XX", for: .normal)
                            } else {
                                //        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                            }
                        } else {
                            inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: pvid ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: fetchDatEntry.first?.listId ?? 0 , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                            
                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                            UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                            
                            self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                self.inheritBreedBttn.setTitle("XX", for: .normal)
                            } else {
                                self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                            }
                        }
                        autoSaveProductandsubProduct(dataGet: dataGet)
                        
                    }
                }
            }
        }
        //  inheritCrossBtnOutlet.isHidden = true
        //  globalCrossBtnOutlet.isHidden = true
    }
    
    func autoSaveProductandsubProduct(dataGet:DataEntryBeefAnimaladdTbl){
        let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
        let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
        for k in 0 ..< animalData.count{
            let animalId = animalData[k] as! BeefAnimaladdTbl
            for i in 0 ..< product.count {
                let data = product[i] as! GetProductTblBeef
                
                saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                
                let addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                let subProductArr =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId,customerID: custmerId)
                
                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId,customerID: custmerId)
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    if subProductArr.count > 0 {
                        if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                    }
                    else {
                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                    statusOrder = false
                    UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                    self.animalSucInOrder = ""
                }
            }
        }
    }
}

extension InheritBeefVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            // scanBarcodeTextfield.text = qrValue
        }
        else{
            inheritBarcodeTextfield.text = qrValue
        }
    }
}

extension InheritBeefVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        inheritEIDTextfield.text = scannedResult
        isautoPopulated = false
    }
}

extension InheritBeefVC : RFID,nearByDevice{
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue  && UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.USDairyProducts.rawValue{
        }
        else {
            inheritEIDTextfield.text?.removeAll()
            if inheritEIDTextfield.isEnabled == true {
                inheritEIDTextfield.becomeFirstResponder()
                inheritEIDTextfield.text = rfid
                inheritEIDTextfield.text = inheritEIDTextfield.text!.trimmingCharacters(in: CharacterSet.whitespaces)
            }
        }
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
}

extension InheritBeefVC : offlineCustomView1 {
    func crossBtn() {
        buttonbg.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
}

extension InheritBeefVC : ImportListProtocol {
    func importList(listNameString: String, listId: Int) {
        self.listNameString = listNameString
        self.listId = listId
        
        if listId == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectListToImport, comment: "") )
            
            return
        }
        let allDataAnimalTbl1 = fetchAllDataAnimalAnimalIgnoreCase(entityName: Entities.dataEntryBeefAnimalAddTblEntity,custmerId :UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userID :self.userId,listId:Int64(self.listId))
        
        if allDataAnimalTbl1.count == 0 {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.noAnimalsAddedStr, comment: ""))
//            importListMainView.isHidden = true
//            importBackroundView.isHidden = true
            return
        }
        
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    if dataEntryVALE.count > 0 {
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                    }
                }
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
//                        self.importBackroundView.isHidden = true
//                        self.importListMainView.isHidden = true
                        
                    })
                    alert.addAction(cancel)
                    
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                    if data12333.count > 0{
                                        if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            
                                            saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                            UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                            tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                                breedBtnOutlet.setTitle("XX", for: .normal)
                                            } else {
                                                breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                            }
                                            createDataList()
                                        }
                                        else {
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.byDefaultSetting()
                                                
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.byDefaultSetting()
                                                return
                                                
                                            }
                                            
                                            alertController.addAction(cancelAction)
                                            alertController.addAction(okAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            breedBtnOutlet.setTitle("XX", for: .normal)
                                        } else {
                                            breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        for i in 0 ..< product.count {
                                            let data = product[i] as! GetProductTblBeef
                                            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                                self.animalSucInOrder = ""
                                            }
                                        }
                                    }
                                    
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                        self.cartView.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                        self.cartView.isHidden = false
                                    }
                                    self.globalCrossBtnOutlet.isHidden = false
                                    
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                    globalImportFromOutlet.isEnabled = true
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    
                                    showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                        
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            globalMergeListBtnOulet.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            globalMergeListBtnOulet.isHidden = false
                                        }
                                    }
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
//                                    self.importBackroundView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
//                    self.importBackroundView.isHidden = true
//                    self.importListMainView.isHidden = true
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                }else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                if data12333.count > 0{
                                    if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        
                                        saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                        UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                        tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            breedBtnOutlet.setTitle("XX", for: .normal)
                                        } else {
                                            breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    else {
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.byDefaultSetting()
                                            
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.byDefaultSetting()
                                            return
                                        }
                                        alertController.addAction(cancelAction)
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        breedBtnOutlet.setTitle("XX", for: .normal)
                                    } else {
                                        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    for i in 0 ..< product.count {
                                        let data = product[i] as! GetProductTblBeef
                                        saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                            self.animalSucInOrder = ""
                                        }
                                    }
                                }
                                
                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                    self.cartView.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                    self.cartView.isHidden = false
                                }
                                self.globalCrossBtnOutlet.isHidden = false
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                globalImportFromOutlet.isEnabled = true
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                    
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        globalMergeListBtnOulet.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        globalMergeListBtnOulet.isHidden = false
                                    }
                                }
                            }
                            let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                            
                            if fetchCheckListId.count == 0{
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
//                                self.importBackroundView.isHidden = true
//                                self.importListMainView.isHidden = true
                            }
                        }
                    }
                }
                
            } else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                if fetchData11.count != 0 {
                    
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                            if data12333.count > 0{
                                if tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSUText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.allflexTSTText || tissueBttnOutlet.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                    
                                    saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                    UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                    tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        breedBtnOutlet.setTitle("XX", for: .normal)
                                    } else {
                                        breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                else {
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.byDefaultSetting()
                                        
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.byDefaultSetting()
                                        return
                                    }
                                    
                                    alertController.addAction(cancelAction)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                saveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "" , date: dataGet.date ?? ""  , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId: dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId),tissuId: Int(dataGet.tissuId),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU:  dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId),productId:Int(dataGet.productId),custId: Int(dataGet.custmerId), listId: dataGet.listId, serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                UserDefaults.standard.setValue(dataGet.breedName, forKey: keyValue.beefBreed.rawValue)
                                UserDefaults.standard.setValue(dataGet.tissuName, forKey: keyValue.beefTSU.rawValue)
                                tissueBttnOutlet.setTitle(dataGet.tissuName ?? "", for: .normal)
                                if dataGet.breedName == LocalizedStrings.breedNameX{
                                    breedBtnOutlet.setTitle("XX", for: .normal)
                                } else {
                                    breedBtnOutlet.setTitle(dataGet.breedName, for: .normal)
                                }
                                createDataList()
                            }
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            for k in 0 ..< animalData.count{
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                for i in 0 ..< product.count {
                                    let data = product[i] as! GetProductTblBeef
                                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "", orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        
                                        statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                        self.animalSucInOrder = ""
                                    }
                                }
                            }
                            
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                                self.cartView.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                                self.cartView.isHidden = false
                            }
                            self.globalCrossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                            globalImportFromOutlet.isEnabled = true
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                            showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                            if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                
                            }
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                            
                            if fetchObj.count != 0 {
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    globalMergeListBtnOulet.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    globalMergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    globalMergeListBtnOulet.isHidden = false
                                }
                            }
                        }
                    }
                    
                }
            }
            
//            importListMainView.isHidden = true
//            importBackroundView.isHidden = true
            
        } else {
            let aData =  fetchAnimaldataDairyOrderIdUserId(entityName: Entities.beefAnimalAddTblEntity, orderId: autoD, userId: userId,providerId:self.pvid)
            if aData.count > 0 {
                for k in 0 ..< aData.count{
                    let data1 = aData[k] as! BeefAnimaladdTbl
                    let earTag = data1.animalTag
                    
                    let dataEntryVALE = fetchAllDataGlobalEarTAG(entityName: Entities.dataEntryBeefAnimalAddTblEntity,userId:userId,orderId:orderId,listid:Int64(listId),custmerId:Int64(custmerId ),providerId:pvid,earTag: earTag ?? "", orderStatus: "false") as! [DataEntryBeefAnimaladdTbl]
                    
                    if dataEntryVALE.count > 0 {
                        self.conflictArr.append(contentsOf: dataEntryVALE)
                        
                    }
                }
                
                if conflictArr.count > 0 {
                    let count1 = conflictArr.count
                    let alertPrint = String(count1) + " " + NSLocalizedString(LocalizedStrings.selectActionToBePerformed, comment: "")
                    
                    let alert = UIAlertController(title: listNameString, message: alertPrint, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { action in
                        
//                        self.importBackroundView.isHidden = true
//                        self.importListMainView.isHidden = true
                        
                    })
                    
                    alert.addAction(cancel)
                    let ok = UIAlertAction(title: NSLocalizedString("Ignore", comment: ""), style: .default, handler: { [self] action in
                        let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                        if fetchData11.count != 0 {
                            for i in 0...fetchData11.count - 1 {
                                let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                                let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                                if fetchCountGirlando.count == 0 {
                                    
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                    if data12333.count > 0{
                                        if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                            inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                            
                                            UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                            UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                            
                                            self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                            
                                            if dataGet.breedName == LocalizedStrings.breedNameX{
                                                self.inheritBreedBttn.setTitle("XX", for: .normal)
                                            } else {
                                                self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                            }
                                            createDataList()
                                        }
                                        else{
                                            let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                            
                                            let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                self.inheritByDefaultSetting()
                                            }
                                            let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                                UIAlertAction in
                                                
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                                deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                                let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                                self.notificationLblCount.text = String(animalCount.count)
                                                self.inheritByDefaultSetting()
                                                return
                                            }
                                            
                                            alertController.addAction(cancelAction)
                                            alertController.addAction(okAction)
                                            self.present(alertController, animated: true, completion: nil)
                                            return
                                        }
                                    }
                                    else {
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                        self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            self.inheritBreedBttn.setTitle("XX", for: .normal)
                                        } else {
                                            self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                    }
                                    
                                    let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                    let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                    
                                    for k in 0 ..< animalData.count{
                                        let animalId = animalData[k] as! BeefAnimaladdTbl
                                        for i in 0 ..< product.count {
                                            let data = product[i] as! GetProductTblBeef
                                            saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                            
                                            let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                            
                                            for j in 0 ..< addonArr.count {
                                                let addonDat = addonArr[j] as! GetAdonTbl
                                                if data12333.count > 0 {
                                                    if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                        updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                    }
                                                    else{
                                                        saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    }
                                                }
                                                else {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                                statusOrder = false
                                                UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                                self.animalSucInOrder = ""
                                            }
                                            
                                        }
                                    }
                                    let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                    notificationLblCount.text = String(animalCount.count)
                                    if animalCount.count == 0{
                                        self.notificationLblCount.isHidden = true
                                        self.countLbl.isHidden = true
                                        self.cartView.isHidden = true
                                    } else {
                                        self.notificationLblCount.isHidden = false
                                        self.countLbl.isHidden = false
                                        self.cartView.isHidden = false
                                    }
                                    self.inheritCrossBtnOutlet.isHidden = false
                                    UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                    UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                                   // inheritImportFromOutlet.isEnabled = true
//                                    self.importBackroundView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                    
                                    showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                    
                                    if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                        
                                        let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                        let listObject = fetchList.object(at: 0) as? DataEntryList
                                        let listDescr = listObject?.listDesc
                                        
                                        saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                    }
                                    
                                    let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                    if fetchObj.count != 0 {
                                        
                                        let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                        let obj = objectFetch?.listName
                                        let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                        
                                        if fetchAllMergeDta == 0 {
                                            let fetchNameDisplay = String(obj ?? "")
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                            self.mergeListView.isHidden = false
                                        } else {
                                            let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                            let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                            InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                            InheritmergeListBtnOulet.isHidden = false
                                            self.mergeListView.isHidden = false
                                        }
                                    }
                                    
                                }
                                let fetchCheckListId = fetchAllDataOrderListIDgET(entityName: Entities.beefAnimalAddTblEntity,ordestatus: "false",orderId:self.orderId,userId:self.userId,listId:0)
                                
                                if fetchCheckListId.count == 0{
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.noAnimalsAddedToOrder, comment: ""), duration: 2, position: .top)
//                                    self.importBackroundView.isHidden = true
//                                    self.importListMainView.isHidden = true
                                }
                            }
                        }
                    })
                    alert.addAction(ok)
//                    self.importBackroundView.isHidden = true
//                    self.importListMainView.isHidden = true
                    
                    DispatchQueue.main.async(execute: {
                        self.present(alert, animated: true)
                    })
                } else {
                    let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                    if fetchData11.count != 0 {
                        
                        for i in 0...fetchData11.count - 1 {
                            let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                            let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                            if fetchCountGirlando.count == 0 {
                                
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                                if data12333.count > 0{
                                    if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                        inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                        
                                        UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                        UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                        
                                        self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                        if dataGet.breedName == LocalizedStrings.breedNameX{
                                            self.inheritBreedBttn.setTitle("XX", for: .normal)
                                        } else {
                                            self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                        }
                                        createDataList()
                                        
                                    }
                                    else{
                                        let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                        
                                        let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            self.inheritByDefaultSetting()
                                        }
                                        let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                            UIAlertAction in
                                            
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                            deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                            self.notificationLblCount.text = String(animalCount.count)
                                            self.inheritByDefaultSetting()
                                            return
                                        }
                                        
                                        alertController.addAction(cancelAction)
                                        alertController.addAction(okAction)
                                        self.present(alertController, animated: true, completion: nil)
                                        return
                                    }
                                }
                                else {
                                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                    
                                    self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        self.inheritBreedBttn.setTitle("XX", for: .normal)
                                    } else {
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                
                                let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                                let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                                
                                for k in 0 ..< animalData.count{
                                    let animalId = animalData[k] as! BeefAnimaladdTbl
                                    for i in 0 ..< product.count {
                                        let data = product[i] as! GetProductTblBeef
                                        saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                        
                                        let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                        
                                        for j in 0 ..< addonArr.count {
                                            let addonDat = addonArr[j] as! GetAdonTbl
                                            if data12333.count > 0 {
                                                if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                    updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                                }
                                                else{
                                                    saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                }
                                            }
                                            else {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                            statusOrder = false
                                            UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                            self.animalSucInOrder = ""
                                        }
                                    }
                                }
                                
                                let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                notificationLblCount.text = String(animalCount.count)
                                if animalCount.count == 0{
                                    self.notificationLblCount.isHidden = true
                                    self.countLbl.isHidden = true
                                    self.cartView.isHidden = true
                                } else {
                                    self.notificationLblCount.isHidden = false
                                    self.countLbl.isHidden = false
                                    self.cartView.isHidden = false
                                }
                                self.inheritCrossBtnOutlet.isHidden = false
                                UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                                UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                            //    inheritImportFromOutlet.isEnabled = true
                            //    self.importBackroundView.isHidden = true
                           //     self.importListMainView.isHidden = true
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                                
                                showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                                
                                if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                    let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                    let listObject = fetchList.object(at: 0) as? DataEntryList
                                    let listDescr = listObject?.listDesc
                                    
                                    saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                                }
                                
                                let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                                if fetchObj.count != 0 {
                                    
                                    let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                    let obj = objectFetch?.listName
                                    let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                    
                                    if fetchAllMergeDta == 0 {
                                        let fetchNameDisplay = String(obj ?? "")
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                        self.mergeListView.isHidden = false
                                    } else {
                                        let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                        let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                        InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                        InheritmergeListBtnOulet.isHidden = false
                                        self.mergeListView.isHidden = false
                                    }
                                }
                                
                            }}}}
                
            }else {
                let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryGIR(entityName: Entities.dataEntryBeefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false",listid:Int64(self.listId), custmerId: Int64(self.custmerId ), providerId: self.pvid)
                if fetchData11.count != 0 {
                    for i in 0...fetchData11.count - 1 {
                        let dataGet = fetchData11.object(at: i) as! DataEntryBeefAnimaladdTbl
                        let fetchCountGirlando = fetchAllDataAnimalImportBeefGet(entityName: Entities.beefAnimalAddTblEntity,animalTag:dataGet.animalTag ?? "",custmerId :Int(dataGet.custmerId),userID :self.userId,orderId :self.orderId)
                        if fetchCountGirlando.count == 0 {
                            
                            let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductBeefTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:orderId, customerID: custmerId)
                            if data12333.count > 0{
                                if inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSUText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.allflexTSTText || inheritTissueBttn.titleLabel!.text! == ButtonTitles.caisleyTSUText {
                                    inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                    
                                    UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                    UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                    
                                    self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                    if dataGet.breedName == LocalizedStrings.breedNameX{
                                        self.inheritBreedBttn.setTitle("XX", for: .normal)
                                    } else {
                                        self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                    }
                                    createDataList()
                                }
                                else{
                                    let alertController = UIAlertController(title: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), message: NSLocalizedString(AlertMessagesStrings.animalCannotBeAdded, comment: ""), preferredStyle: .alert)
                                    
                                    let okAction = UIAlertAction(title: NSLocalizedString("YES", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        self.inheritByDefaultSetting()
                                    }
                                    let cancelAction = UIAlertAction(title: NSLocalizedString("NO", comment: ""), style: UIAlertAction.Style.default) {
                                        UIAlertAction in
                                        
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId),entity: Entities.productAdonAnimlBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.subProductBeefTblEntity)
                                        deleteDataWithProductwithEntity(Int(dataGet.animalId), entity: Entities.beefAnimalAddTblEntity)
                                        let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                                        self.notificationLblCount.text = String(animalCount.count)
                                        self.inheritByDefaultSetting()
                                        return
                                    }
                                    alertController.addAction(cancelAction)
                                    alertController.addAction(okAction)
                                    self.present(alertController, animated: true, completion: nil)
                                    return
                                }
                            }
                            else {
                                inheritSaveAnimaldataBeefInProductId(entity: Entities.beefAnimalAddTblEntity, animalTag: dataGet.animalTag ?? "", barCodetag: dataGet.animalbarCodeTag ?? "", date: dataGet.date ?? "" , damId: dataGet.offDamId ?? "", sireId: dataGet.offsireId ?? "" , gender: dataGet.gender ?? "",update: "true", permanentId:dataGet.offPermanentId ?? "", tissuName: dataGet.tissuName ?? "", breedName: dataGet.breedName ?? "", et: dataGet.eT ?? "", farmId:dataGet.farmId ?? "", orderId: autoD,orderSataus:"false",breedId:dataGet.breedId ?? "",isSync:"false", providerId: Int(dataGet.providerId ) ,tissuId: Int(dataGet.tissuId ),sireIDAU: dataGet.sireIDAU ?? "", nationHerdAU: dataGet.nationHerdAU ?? "", userId: userId,udid:dataGet.udid ?? "", animalId: Int(dataGet.animalId ),productId:Int(dataGet.productId ), sirYOB: dataGet.sireYOB ?? "", damYOB: dataGet.damYOB ?? "", sireRegAssocation: dataGet.sireRegAssocation ?? "",custId: Int(dataGet.custmerId ), listId: dataGet.listId , serverAnimalId: "", tertiaryGeno: dataGet.tertiaryGeno ?? "")
                                
                                UserDefaults.standard.set(dataGet.tissuName ?? "", forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                                UserDefaults.standard.set(dataGet.breedName ?? "", forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                                
                                self.inheritTissueBttn.setTitle(dataGet.tissuName?.localized, for: .normal)
                                if dataGet.breedName == LocalizedStrings.breedNameX{
                                    self.inheritBreedBttn.setTitle("XX", for: .normal)
                                } else {
                                    self.inheritBreedBttn.setTitle(dataGet.breedName, for: .normal)
                                }
                                createDataList()
                            }
                            
                            let animalData = fetchAnimaldata(entityName: Entities.beefAnimalAddTblEntity, animalTag:dataGet.animalTag ?? "",orderId:orderId,userId:userId)
                            let product  = fetchAllData(entityName: Entities.getProductBeefTblEntity)
                            
                            for k in 0 ..< animalData.count{
                                let animalId = animalData[k] as! BeefAnimaladdTbl
                                for i in 0 ..< product.count {
                                    let data = product[i] as! GetProductTblBeef
                                    saveProductAdonTbl(entity: Entities.productAdonAnimlBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: animalId.farmId ?? "", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" , pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: true)
                                    
                                    let  addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                                    
                                    for j in 0 ..< addonArr.count {
                                        let addonDat = addonArr[j] as! GetAdonTbl
                                        if data12333.count > 0 {
                                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: Int(addonDat.adonId), status: "true")
                                            }
                                            else{
                                                saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                            }
                                        }
                                        else {
                                            saveSubroductTbl(entity: Entities.subProductBeefTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: Int(dataGet.animalId),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                        }
                                        statusOrder = false
                                        UserDefaults.standard.removeObject(forKey: keyValue.review.rawValue)
                                        self.animalSucInOrder = ""
                                        
                                    }
                                }
                            }
                            let animalCount =  fetchAllDataAnimalDatarderId(entityName: Entities.beefAnimalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue))
                            notificationLblCount.text = String(animalCount.count)
                            if animalCount.count == 0{
                                self.notificationLblCount.isHidden = true
                                self.countLbl.isHidden = true
                                self.cartView.isHidden = true
                            } else {
                                self.notificationLblCount.isHidden = false
                                self.countLbl.isHidden = false
                                self.cartView.isHidden = false
                            }
                            self.inheritCrossBtnOutlet.isHidden = false
                            UserDefaults.standard.setValue(self.listNameString, forKey: keyValue.dataEntryListName.rawValue)
                            UserDefaults.standard.set(Int64(dataGet.listId), forKey: keyValue.dataEntryListId.rawValue)
                          //  inheritImportFromOutlet.isEnabled = true
//                            self.importBackroundView.isHidden = true
//                            self.importListMainView.isHidden = true
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.animalsImportedIntoOrder, comment: ""), duration: 2, position: .top)
                            
                            showAlertforwithoutBarcodeAnimal(importListAnimal: allDataAnimalTbl1 as! [DataEntryBeefAnimaladdTbl])
                            if fetchMergeDataListId(entityName: Entities.mergeDataEntryListTblEntity,listId: Int64(dataGet.listId),customerId: Int64(self.custmerId )).count == 0 {
                                
                                let fetchList = fetchMergeDataListId(entityName: Entities.dataEntryListTblEntity,listId: Int64(dataGet.listId),customerId:Int64(self.custmerId ))
                                let listObject = fetchList.object(at: 0) as? DataEntryList
                                let listDescr = listObject?.listDesc
                                
                                saveMergeDataEntryList(entity: Entities.mergeDataEntryListTblEntity, customerId: Int64(self.custmerId ), listName:listNameString , listId:  Int64(dataGet.listId), providerId: Int64(self.pvid), listDesc:listDescr ?? "")
                            }
                            
                            let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId:pvid )
                            if fetchObj.count != 0 {
                                
                                let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
                                let obj = objectFetch?.listName
                                let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
                                
                                if fetchAllMergeDta == 0 {
                                    let fetchNameDisplay = String(obj ?? "")
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                    self.mergeListView.isHidden = false
                                } else {
                                    let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                                    let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                                    InheritmergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                                    InheritmergeListBtnOulet.isHidden = false
                                    self.mergeListView.isHidden = false
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
