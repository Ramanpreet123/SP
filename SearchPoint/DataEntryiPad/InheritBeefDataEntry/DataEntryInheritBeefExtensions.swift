//
//  DataEntryInheritBeefExtensions.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 25/03/25.
//

import Foundation
import UIKit
import CoreBluetooth

// MARK: - OFFLINE CUSTOM VIEW
extension DataEntryInheritBeefVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

// MARK: - TABLEVIEW DELEGATES AND DATASOURCES
extension DataEntryInheritBeefVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        if btnTag == 20{
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName
            return cell
            
        }
        
        if btnTag == 10{
            let breed = breedArr[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        
        if btnTag == 30 {
            let tissue = self.sireRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
            return cell
        }
        
        if btnTag == 110 {
            let gender = self.genderArray[indexPath.row] 
            cell.textLabel?.text = gender
            return cell
            
        }
        
        if btnTag == 40{
            let tissue = self.damRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        
        if btnTag == 80{
            let tissue = self.breedRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text = tissue.association
        }
        
        if btnTag == 50{
            let tissue = self.inheritTissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName?.localized
            return cell
        }
        
        if btnTag == 60{
            let breed = inheritBreedArr[indexPath.row] as! GetBreedsTbl
            cell.textLabel?.text = breed.threeCharCode
            return cell
        }
        
        if btnTag == 70{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        
        if btnTag == 90{
            let tissue = self.inheritRegArr[indexPath.row]  as! GetBreedSocieties
            cell.textLabel?.text =  tissue.association
        }
        
        if tableView == pairedTableView {
            let cell = pairedTableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.pairedDeviceCellId, for: indexPath) as! PairedDeviceCell
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
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setShadowForUIView(view: inheritGenderView, removeShadow: true)
        self.setShadowForUIView(view: sampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: breedTypeView, removeShadow: true)
        self.setShadowForUIView(view: breedAssociationView, removeShadow: true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        if btnTag == 110  {
            let gender = self.genderArray[indexPath.row]
            inheritGenderString = gender
            inheritMaleFemaleBttn.setTitleColor(.black, for: .normal)
            inheritMaleFemaleBttn.setTitle(gender, for: .normal)
            buttonbg2.removeFromSuperview()
            self.inheritGenderView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            if gender.contains("F") {
                UserDefaults.standard.set("F", forKey: "DEInheritBeef")
            } else {
                UserDefaults.standard.set("M", forKey: "DEInheritBeef")
            }
            
        }
        
        if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            tissueBttnOutlet.setTitleColor(.black, for: .normal)
            tissueBttnOutlet.setTitle(tissue.sampleName, for: .normal)
            buttonbg2.removeFromSuperview()
            self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if btnTag == 10  {
            let breed = self.breedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            breedBtnOutlet.setTitleColor(.black, for: .normal)
            breedBtnOutlet.setTitle(breed.threeCharCode, for: .normal)
            buttonbg2.removeFromSuperview()
            self.breedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if btnTag == 30{
            let sireReg = sireRegArr[indexPath.row] as! GetBreedSocieties
            sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
            sireRegDropdownOutlet.setTitle(sireReg.association, for: .normal)
            UserDefaults.standard.set(sireReg.association, forKey: keyValue.beefSireReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 40{
            let damReg = damRegArr[indexPath.row] as! GetBreedSocieties
            damRegDropdownOutlet.setTitleColor(.black, for: .normal)
            damRegDropdownOutlet.setTitle(damReg.association, for: .normal)
            UserDefaults.standard.set(damReg.association, forKey: keyValue.beefDamReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 80{
            let breedReg = breedRegArr[indexPath.row] as! GetBreedSocieties
            breedRegBttn.setTitleColor(.black, for: .normal)
            breedRegBttn.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefBreedReg.rawValue)
            buttonbg2.removeFromSuperview()
        }
        if btnTag == 50{
            let tissue = self.inheritTissueArr[indexPath.row] as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            inheritTissueBttn.setTitleColor(.black, for: .normal)
            inheritTissueBttn.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            self.sampleTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if btnTag == 60{
            let breed = self.inheritBreedArr[indexPath.row] as! GetBreedsTbl
            breedId = breed.breedId!
            inheritBreedBttn.setTitleColor(.black, for: .normal)
            inheritBreedBttn.setTitle(breed.threeCharCode, for: .normal)
            buttonbg2.removeFromSuperview()
            self.breedTypeView.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if btnTag == 70{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            inheritRegAssociationBttn.setTitleColor(.black, for: .normal)
            inheritRegAssociationBttn.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
        }
        
        if btnTag == 90{
            let breedReg = inheritRegArr[indexPath.row] as! GetBreedSocieties
            inheriSireRedOutlet.setTitleColor(.black, for: .normal)
            inheriSireRedOutlet.setTitle(breedReg.association, for: .normal)
            UserDefaults.standard.set(breedReg.association, forKey: keyValue.beefRegAssociation.rawValue)
            buttonbg2.removeFromSuperview()
            self.sireRegAssociationView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
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

// MARK: - TEXTFIELD DELEGATES
extension DataEntryInheritBeefVC : UITextFieldDelegate{
    func setShadowForUIView(view : UIView, removeShadow : Bool) {
        if removeShadow {
            view.layer.shadowOpacity = 0
            view.layer.shadowOffset = CGSize(width: 0, height: 0)
            view.layer.shadowRadius = 0
            view.layer.masksToBounds = false
        } else {
            view.layer.shadowColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).withAlphaComponent(1.0).cgColor
            view.layer.shadowOpacity = 0.7
            view.layer.shadowOffset = CGSize(width: 0, height: 1)
            view.layer.shadowRadius = 3
            view.layer.masksToBounds = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if scanEarTagTextField == textField || inheritEarTagTextfield == textField {
            inheritEarTagTextfield.returnKeyType = .next
        }
        
        if textField == inheritEarTagTextfield {
            viewsArray = [inheritBarcodeView, secondaryIDView, inheritEIDView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            self.inheritEarTagView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.setShadowForUIView(view: inheritEarTagView, removeShadow: false)
            self.setShadowForUIView(view: inheritBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: inheritEIDView, removeShadow: true)
            self.setShadowForUIView(view: secondaryIDView, removeShadow: true)
            self.setShadowForUIView(view: breedRegNumberView, removeShadow: true)
            
        }
        
        if textField == inheritBarcodeTextfield {
            viewsArray = [inheritEarTagView, secondaryIDView, inheritEIDView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.inheritBarcodeView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: inheritEarTagView, removeShadow: true)
            self.setShadowForUIView(view: inheritBarcodeView, removeShadow: false)
            self.setShadowForUIView(view: inheritEIDView, removeShadow: true)
            self.setShadowForUIView(view: secondaryIDView, removeShadow: true)
            self.setShadowForUIView(view: breedRegNumberView, removeShadow: true)
        }
        
        if textField == inheritEIDTextfield {
            viewsArray = [inheritEarTagView, secondaryIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.inheritEIDView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: inheritEarTagView, removeShadow: true)
            self.setShadowForUIView(view: inheritBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: inheritEIDView, removeShadow: false)
            self.setShadowForUIView(view: secondaryIDView, removeShadow: true)
            self.setShadowForUIView(view: breedRegNumberView, removeShadow: true)
        }
        
        if textField == inheritSecondaryIdTextfield {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, breedRegNumberView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.secondaryIDView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: inheritEarTagView, removeShadow: true)
            self.setShadowForUIView(view: inheritBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: inheritEIDView, removeShadow: true)
            self.setShadowForUIView(view: secondaryIDView, removeShadow: false)
            self.setShadowForUIView(view: breedRegNumberView, removeShadow: true)
        }
        
        if textField == inheritBreedRegTextfield {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, sireRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.breedRegNumberView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.setShadowForUIView(view: inheritEarTagView, removeShadow: true)
            self.setShadowForUIView(view: inheritBarcodeView, removeShadow: true)
            self.setShadowForUIView(view: inheritEIDView, removeShadow: true)
            self.setShadowForUIView(view: secondaryIDView, removeShadow: true)
            self.setShadowForUIView(view: breedRegNumberView, removeShadow: false)
        }
        
        if textField == inheritSireRegTextfield {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireYOBView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.sireRegNumberView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if textField == inheritSireYobBttn {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, damIDView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.sireYOBView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if textField == inheritDamIdTextfield {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, sireYOBView, damYOBView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.damIDView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
        
        if textField == inheritDamYobBttn {
            viewsArray = [inheritEarTagView, inheritEIDView, inheritBarcodeView, sampleTypeView, inheritGenderView, breedTypeView, inheritDObView, breedAssociationView, secondaryIDView, breedRegNumberView, sireRegAssociationView, sireRegNumberView, sireYOBView, damIDView]
            
            self.changeViewColorToBlack(view: viewsArray, color: UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor)
            self.damYOBView.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !barAutoPopu {
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
                if isBarcodeEndingWithNumberAndGetIncremented(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxGlobal.image = UIImage(named: "incrementalCheckIpad")
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
                if isBarcodeEndingWithNumberAndGetIncremented(newString as String).isBarCodeEndsWithNumber  {
                    incrementalBarcodeCheckBoxInherit.image = UIImage(named: "incrementalCheckIpad")
                    UserDefaults.standard.set(true, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = false
                }
                else {
                    UserDefaults.standard.set(false, forKey: keyValue.isBarCodeIncremental.rawValue)
                    checkBarcode = true
                }
            }
        }
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgUpatedd = true
                }
                if textField == scanEarTagTextField{
                  
                    isautoPopulated = false
                }
                
                if textField == inheritEarTagTextfield{
                    if inheritEarTagTextfield.text!.count == 1 {
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
            }
            else {
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgUpatedd = true
                }
                if textField == inheritDamYobBttn || textField == inheritSireYobBttn {
                    let textstring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                    let length = textstring.count
                    let acceptableCharacters = "0123456789"
                    let check  = acceptableCharacters.contains(string)
                    if !check {
                        return false
                    }
                    if length > 4 {
                        return false
                    }
                }
                
                if textField == inheritBarcodeTextfield || textField == scanBarcodeTextfield  {
                    let acceptableCharacters = LocalizedStrings.abcdNumberFormat
                    let check  = acceptableCharacters.contains(string)
                    if !check {
                        return false
                    }
                }
                
                if  textField == inheritEarTagTextfield || textField == scanEarTagTextField {
                    let acceptableCharacters = LocalizedStrings.earTagRegex
                    let check  = acceptableCharacters.contains(string)
                    if !check {
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
            if editIngText {
                editIngText = false
                
            }
            
            else if isUpdate  {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder {
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: Entities.beefAnimalMasterTblEntity, animalId: idAnimal, customerID: custmerId)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            if isautoPopulated  {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
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
                      
                        validateDateFlag = true
                    }
                    else {
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
                     
                        validateDateFlag = true
                    }
                    else {
                        dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                        validateDateFlag = false
                    }
                }
                else {
                    dateBttnOutlet.layer.borderColor = UIColor.red.cgColor
                    validateDateFlag = false
                }
            }
        }
        
        if textField == scanEarTagTextField {
            if scanEarTagTextField.text != "" {
                dataPopulateInFocusChange()
            }
        } else if textField == inheritEarTagTextfield {
            if inheritEarTagTextfield.text != "" {
                dataPopulateInFocusChange()
            }
        }
        
        self.setShadowForUIView(view: inheritEarTagView, removeShadow: true)
        self.setShadowForUIView(view: inheritBarcodeView, removeShadow: true)
        self.setShadowForUIView(view: inheritEIDView, removeShadow: true)
        self.setShadowForUIView(view: secondaryIDView, removeShadow: true)
        self.setShadowForUIView(view: breedRegNumberView, removeShadow: true)
    }
    
    func dataPopulateInFocusChange(){
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
                
        if inheritEarTagTextfield.text != "" {
            let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
            
            
            if inheritAnimalData.count > 0 {
                isautoPopulated = true
                barAutoPopu = true
                inherittextFieldBackroungWhite()
                updateOrder = true
                let data =  inheritAnimalData.lastObject as! DataEntryBeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                inheritAnimalId1 = Int(data.animalId)
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                if animalDataMaster.count > 0 {
                    msgUpatedd = true
                }
                barcodeflag = false
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
                inheritBarcodeView.layer.borderColor = UIColor.gray.cgColor
                let dateStr = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String
                let formatter = DateFormatter()
                inheritDobBttn.titleLabel?.text = ""
                
                if data.date != ""{
                    inheritDobLbl.text = ""
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
                    
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                    }
                }
                inheritBarcodeTextfield.text = data.animalbarCodeTag
                inheritBreedRegTextfield.text = data.offPermanentId
                inheritSireRegTextfield.text = data.offsireId
                inheritDamIdTextfield.text = data.offDamId
                inheriSireRedOutlet.setTitle(data.sireRegAssocation, for: .normal)
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    incrementalBarcodeButtonInherit.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? DataEntryBeefAnimaladdTbl
                    if orStatus?.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    }
                    else {
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
                inheritBreedBttn.setTitle(data.breedName, for: .normal)
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritBreedBttn.setTitleColor(.black, for: .normal)
                inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                
                if data.sireYOB == "0" {
                    inheritSireYobBttn.text = ""
                }
                else {
                    inheritSireYobBttn.text = data.sireYOB
                }
                
                if data.damYOB == "0" {
                    inheritDamYobBttn.text = ""
                }
                else {
                    inheritDamYobBttn.text = data.damYOB
                }
                
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                
                if data.eT == "" || data.eT == nil {
                    inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                }
                
                if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                    inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                }
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    UserDefaults.standard.set("M", forKey: "DEInheritBeef")
                }
                else {
                    inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                    inheritGenderToggleFlag = 0
                    inheritGenderString = ButtonTitles.femaleText.localized
                    UserDefaults.standard.set("F", forKey: "DEInheritBeef")
                    
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
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        let orderId = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        
        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:"", farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: "", offsireId: "",orderId:orderId,userId:userId,custmerId:custmerId )
        
        let inheritAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: Entities.beefAnimalMasterTblEntity, animalTag:inheritEarTagTextfield.text!, farmId: "", animalbarCodeTag: inheritBarcodeTextfield.text!, offPermanentId: inheritBreedRegTextfield.text!, offDamId: inheritDamIdTextfield.text!, offsireId: inheritSireRegTextfield.text!,orderId:orderId,userId:userId,custmerId:custmerId )
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        if !isautoPopulated{
            if animalData.count > 0 {
                isautoPopulated = true
                
                barAutoPopu = true
                updateOrder = true
                let data =  animalData.lastObject as! BeefAnimalMaster
                let userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
                animalId1 = Int(data.animalId)
                scanBarcodeTextfield.text = data.animalbarCodeTag
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelGlobal.textColor = .black
                    incrementalBarcodeTitleLabelGlobal.alpha = 1
                    incrementalBarcodeCheckBoxGlobal.alpha = 1
                    incrementalBarcodeButtonGlobal.isEnabled = true
                }
                else {
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
                        }
                        else {
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
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
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
                breedBtnOutlet.setTitle(data.breedName, for: .normal)
                tissueBttnOutlet.setTitleColor(.black, for: .normal)
                breedBtnOutlet.setTitleColor(.black, for: .normal)
                tissueBttnOutlet.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: keyValue.dataEntryBeeftsu.rawValue)
                
                if data.farmId != ""{
                    breedRegBttn.setTitle(data.farmId, for: .normal)
                    breedRegBttn.setTitleColor(.black, for: .normal)
                }
                
                if data.sireIDAU != ""{
                    sireRegDropdownOutlet.setTitle(data.sireIDAU, for: .normal)
                    sireRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                
                else {
                    sireRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
                }
                
                if data.nationHerdAU != ""{
                    damRegDropdownOutlet.setTitle(data.nationHerdAU, for: .normal)
                    damRegDropdownOutlet.setTitleColor(.black, for: .normal)
                }
                
                else {
                    damRegDropdownOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectDamReg, comment: ""), for: .normal)
                    
                }
                breedRegBttn.backgroundColor = .white
                sireRegDropdownOutlet.backgroundColor = .white
                damRegDropdownOutlet.backgroundColor = .white
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryBeefbreed.rawValue)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangMale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 1
                    genderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                
                else {
                    self.male_femaleBttnOutlet.setImage(UIImage(named: NSLocalizedString("LangFemale\(langCode)", comment: "")), for: .normal)
                    genderToggleFlag = 0
                    genderString = ButtonTitles.femaleText.localized
                    
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
                    inheritDobLbl.text = ""
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
                        }
                        else {
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
                        }
                        else {
                            inheritDobBttn.setTitle(dateVale, for: .normal)
                        }
                        formatter.dateFormat = DateFormatters.ddMMyyyyFormat
                    }
                    if UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String != keyValue.defaultEntry.rawValue {
                        if inheritDobBttn.titleLabel!.text == nil {
                            self.InheritSelectedDate = Date()
                        }
                        else{
                            self.InheritSelectedDate = formatter.date(from: inheritDobBttn.titleLabel!.text!)!
                        }
                    }
                }
                
                inheritBarcodeTextfield.text = data.animalbarCodeTag
                let dataFetch = fetchAllDataWithAnimalId(entityName: Entities.dataEntryBeefAnimalAddTblEntity,orderId:Int(data.orderId),userId:Int(data.userId),animalId:Int(data.animalId))
                if dataFetch.count == 0 {
                    incrementalBarcodeTitleLabelInherit.textColor = .black
                    incrementalBarcodeTitleLabelInherit.alpha = 1
                    incrementalBarcodeCheckBoxInherit.alpha = 1
                    incrementalBarcodeButtonInherit.isEnabled = true
                }
                else {
                    let orStatus = dataFetch[0] as? DataEntryBeefAnimaladdTbl
                    if orStatus?.orderstatus == "true"{
                        checkBarcode = false
                        incrementalBarcodeTitleLabelInherit.textColor = .black
                        incrementalBarcodeButtonInherit.isEnabled = true
                        incrementalBarcodeTitleLabelInherit.alpha = 1
                        incrementalBarcodeCheckBoxInherit.alpha = 1
                    }
                    else {
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
                inheritBreedBttn.setTitle(data.breedName, for: .normal)
                inheritTissueBttn.setTitleColor(.black, for: .normal)
                inheritBreedBttn.setTitleColor(.black, for: .normal)
                inheritTissueBttn.setTitle(data.tissuName?.localized, for: .normal)
                UserDefaults.standard.set(data.tissuName?.localized, forKey: keyValue.dataEntryBeefInheritTsu.rawValue)
                
                if data.sireYOB == "0" {
                    inheritSireYobBttn.text = ""
                }
                else {
                    inheritSireYobBttn.text = data.sireYOB
                }
                
                if data.damYOB == "0" {
                    inheritDamYobBttn.text = ""
                }
                
                else {
                    inheritDamYobBttn.text = data.damYOB
                }
                
                breedId = data.breedId!
                UserDefaults.standard.set(data.breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                inheritEIDTextfield.text = data.sireIDAU
                inheritSecondaryIdTextfield.text = data.nationHerdAU
                inheritRegAssociationBttn.setTitle(data.eT, for: .normal)
                
                if data.gender == ButtonTitles.maleText.localized || data.gender == "M"{
                    inheritMaleFemaleBttn.setTitle("Male", for: .normal)
                    inheritGenderToggleFlag = 1
                    inheritGenderString = NSLocalizedString(ButtonTitles.maleText, comment: "")
                    UserDefaults.standard.set("M", forKey: "DEInheritBeef")
                }
                else {
                    inheritMaleFemaleBttn.setTitle("Female", for: .normal)
                    inheritGenderToggleFlag = 0
                    inheritGenderString = ButtonTitles.femaleText.localized
                    UserDefaults.standard.set("F", forKey: "DEInheritBeef")
                }
                
                if data.eT == "" || data.eT == nil {
                    inheritRegAssociationBttn.setTitle(NSLocalizedString(LocalizedStrings.selectBreedAssc, comment: ""), for: .normal)
                }
                
                if data.sireRegAssocation == nil || data.sireRegAssocation == "" {
                    inheriSireRedOutlet.setTitle(NSLocalizedString(LocalizedStrings.selectSireReg, comment: ""), for: .normal)
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
     
        if textField == scanEarTagTextField {
            if scanEarTagTextField.text == ""{
                earTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                earTagView.layer.borderColor = UIColor.gray.cgColor
            }
            scanBarcodeTextfield.becomeFirstResponder()
        }
        
        if textField == breedRegTextfield {
            animalNameTextfield.becomeFirstResponder()
        }
        if textField == animalNameTextfield {
            sireRegTextfield.becomeFirstResponder()
        }
        if textField == sireRegTextfield {
            damRegTextfield.becomeFirstResponder()
        }
        if textField == damRegTextfield {
            textField.resignFirstResponder()
        }
        if textField == inheritEarTagTextfield {
            if inheritEarTagTextfield.text == ""{
                inheritEarTagView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                inheritEarTagView.layer.borderColor = UIColor.gray.cgColor
            }
            inheritBarcodeTextfield.becomeFirstResponder()
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
        let storyboard = UIStoryboard(name: "DataEntryBeefiPad", bundle: Bundle.main)
        if UserDefaults.standard.value(forKey: keyValue.page.rawValue)  == nil {
            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
            
        }
        else {
            if  UserDefaults.standard.value(forKey: keyValue.onKey.rawValue) as? String  == "off" {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
            }
            else {
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "BeefDataEntryReviewDataIpad")), animated: true)
            }
        }
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

// MARK: - SIDE MENU UI AND OBJECT PICK CART SCREEN
extension DataEntryInheritBeefVC : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
        isAnimalComingFromCart = true
        let animalID = temp
        let existAnimalData = fetchAllDataWithAnimalIdstatus(entityName: Entities.dataEntryBeefAnimalAddTblEntity, animalId:animalID,orderststus:"false", customerId: self.custmerId) as! [DataEntryBeefAnimaladdTbl]
        if existAnimalData.count > 0{
            autoPopulateAnimalData = existAnimalData[0]
        }
    }
    
    func anOptionalMethod(check :Bool){
        if check {
            isUpdate = false
            editIngText = false
            statusOrder = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            inheritByDefaultSetting()
            inheritTextFieldBackroungGrey()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

// MARK: - INHERIT QUESTIONNAIRE CONTROLLER DELEGATE
extension DataEntryInheritBeefVC: InheritQuestionaireControllerDelegate {
    
    func inheritQuestionaireControllerDismissed() {
        let pvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        UserDefaults.standard.set(false, forKey: keyValue.showbeefInheritTable.rawValue)
        print(InheritQuestionaireManager.shared.inheritQuestionaireModel?.getSelectedBreedType() ?? "")
        if !changeColorToRed {
            inheritEarTagTextfield.becomeFirstResponder()
            inheritEarTagTextfield.backgroundColor = .white
        }
        
        UserDefaults.standard.set(InheritQuestionaireManager.shared.inheritQuestionaireModel?.selectedPrimaryBreedId, forKey: keyValue.selectedPrimaryBreed.rawValue)
        let arr = fetchproviderProductData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        for i in arr  {
            if (i as! GetBreedsTbl).breedName == InheritQuestionaireManager.shared.inheritQuestionaireModel?.getSelectedBreedType() {
                self.breedId = (i as! GetBreedsTbl).breedId ?? ""
                if (i as! GetBreedsTbl).breedId == "87c30632-8da0-4f86-8d94-46da17c520dd" {
                    inheritBreedBttn.setTitle((i as! GetBreedsTbl).breedName, for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).breedName, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                } else {
                    inheritBreedBttn.setTitle((i as! GetBreedsTbl).threeCharCode, for: .normal)
                    UserDefaults.standard.string(forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                    UserDefaults.standard.set((i as! GetBreedsTbl).threeCharCode, forKey: keyValue.dataEntryInheritBeefbreed.rawValue)
                }
            }
        }
    }
}

// MARK: - QR SCANNER PROTOCOL
extension DataEntryInheritBeefVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        if UserDefaults.standard.string(forKey: keyValue.beefProduct.rawValue) == keyValue.globalHD50K.rawValue {
            scanBarcodeTextfield.text = qrValue
        }else{
            inheritBarcodeTextfield.text = qrValue
        }
    }
}

// MARK: - SCANNED OCR PROTOCOL
extension DataEntryInheritBeefVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        inheritEIDTextfield.text = scannedResult
        isautoPopulated = false
    }
}

// MARK: - RFID AND NEARBY DEVICE
extension DataEntryInheritBeefVC : RFID,nearByDevice{
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String == keyValue.ocrKey.rawValue && UserDefaults.standard.string(forKey: keyValue.providerName.rawValue) == keyValue.USDairyProducts.rawValue {
        }
        else {
            inheritEIDTextfield.text?.removeAll()
            if inheritEIDTextfield.isEnabled {
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
