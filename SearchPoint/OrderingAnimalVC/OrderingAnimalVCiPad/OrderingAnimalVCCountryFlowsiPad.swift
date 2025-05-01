//
//  OrderingAnimalVCCountryFlowsiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 18/01/25.
//

import Foundation
import UIKit

//MARK: COUNTRY FLOWS
extension OrderingAnimalipadVC {
    
    //MARK: NEWZEALAND FLOW
    func newzealandFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let remaningString = removeThreeChar.dropFirst(3).uppercased()
        let afterFive = remaningString.prefix(3).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            let removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                return
            }
            
            if afterFive.count < 3 {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                return
            }
            
            if afterFive.isInt == true  {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                return
            }
            else {
                let afterFiveFirstElements  = afterFive.prefix(1).uppercased()
                let afterFiveElements  = afterFive.prefix(2).uppercased()
                let afterFiveSecondElements  = afterFiveElements.dropFirst(1).uppercased()
                let afterFiveThirdElements  = afterFive.dropFirst(2).uppercased()
                
                if afterFiveFirstElements.isInt == true || afterFiveSecondElements.isInt == true || afterFiveThirdElements.isInt == true {
                    self.view.hideToast()
                    id17display(animalId: idAnimal, borderRed: true)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                    return
                }
                else {
                    let afterFirstEightElements  = idAnimal.dropFirst(8).uppercased()
                    let afterEightFirst  = afterFirstEightElements.prefix(1).uppercased()
                    var afterDropNineElements  = idAnimal.dropFirst(9).uppercased()
                    
                    if afterFirstEightElements.count == 0 {
                        self.view.hideToast()
                        id17display(animalId: idAnimal, borderRed: true)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                        return
                    }
                    else {
                        if afterDropNineElements.count == 0 {
                            self.view.hideToast()
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                            return
                        }
                        
                        if afterDropNineElements.isInt == true  {
                            let addObject = 8 - afterDropNineElements.count
                            if afterDropNineElements.count <= 8 {
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        afterDropNineElements = "0" + afterDropNineElements
                                    }
                                }
                                
                                idAnimal = breedCode + countryCode + afterFive + afterEightFirst + afterDropNineElements
                                breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                                id17display(animalId: idAnimal, borderRed: false)
                            } else {
                                self.view.hideToast()
                                id17display(animalId: idAnimal, borderRed: true)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                                return
                            }
                        } else {
                            self.view.hideToast()
                            id17display(animalId: idAnimal, borderRed: true)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                            return
                        }
                    }
                }
            }
        }
    }
    
    //MARK: ARGENTINA FLOW
    func ARGFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                return
            }
            if removeSeven.isInt == true {
                let addObject = 12 - removeSeven.count
                
                if removeSeven.count <= 12 {
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            removeSeven = "0" + removeSeven
                        }
                    }
                    
                    idAnimal = breedCode + countryCode + removeSeven
                    breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                    id17display(animalId: idAnimal, borderRed: false)
                } else {
                    self.view.hideToast()
                    id17display(animalId: idAnimal, borderRed: true)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                }
            }
            else {
                var firstThreeDrop = idAnimal.dropFirst(5).uppercased()
                if idAnimal.contains("RCE"){
                    let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                    if indexRCE != nil{
                        let beforeRCE = firstThreeDrop.substring(to: indexRCE!)
                        let animalCountE = firstThreeDrop.count - beforeRCE.count
                        let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                        let dropFirstVale = String(beforeRCE.dropLast(3))
                        
                        if dropLastEl.isInt == true && (dropFirstVale.isInt == true || dropFirstVale.count == 0 ){
                            if animalCountE == 6 {
                                let addObject = 12 - firstThreeDrop.count
                                if firstThreeDrop.count <= 12 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            firstThreeDrop = "0" + firstThreeDrop
                                        }
                                    }
                                    idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                    id17display(animalId: idAnimal, borderRed: false)
                                    return
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                            }
                            else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                    }
                }
                
                if idAnimal.contains("E"){
                    if firstThreeDrop.count >= 7 {
                        let indexE = firstThreeDrop.range(of: "E", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if(dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
                                
                                if animalCountE == 6 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        id17display(animalId: idAnimal, borderRed: false)
                                        return
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                        
                    } else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                    }
                }
                
                if idAnimal.contains("U"){
                    if firstThreeDrop.count > 7 {
                        let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
                                if animalCountE == 8 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        id17display(animalId: idAnimal, borderRed: false)
                                        return
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17display(animalId: idAnimal, borderRed: true)
                                        return
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17display(animalId: idAnimal, borderRed: true)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                        
                    } else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                    }
                    
                }else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                }
            }
        }
        
    }
    
    //MARK: CHILI FLOW
    func chiliFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let s = removeThreeChar.dropFirst(3).uppercased()
        let sag = s.prefix(3).uppercased()
        var Dropsag = s.dropFirst(3).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            let removefiveZero = String(removeSeven.prefix(5))
            
            if removeSeven.count == 0 {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                return
            }
            
            if removeSeven.isInt == true {
                if removefiveZero == "00000" {
                    if removeSeven.count >= 6 && removeSeven.count <= 9 {
                        let addObject = 12 - removeSeven.count
                        
                        if removeSeven.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.chile + removeSeven
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                    
                } else {
                    if removeSeven.count >= 6 && removeSeven.count <= 9 {
                        let addObject = 9 - removeSeven.count
                        
                        if removeSeven.count <= 9 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + removeSeven
                            id17display(animalId: idAnimal, borderRed: false)
                            return
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                            return
                        }
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
            }
            else {
                if sag == "SAG" {
                    if Dropsag.count >= 6 && Dropsag.count <= 9 {
                        let addObject = 9 - Dropsag.count
                        
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                Dropsag = "0" + Dropsag
                            }
                        }
                        idAnimal = breedCode + countryCode + sag + Dropsag
                        breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                        id17display(animalId: idAnimal, borderRed: false)
                    }
                    else {
                        id17display(animalId: idAnimal, borderRed: true)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        return
                    }
                }
                else {
                    id17display(animalId: idAnimal, borderRed: true)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                    return
                }
            }
        }
    }
    
    //MARK: AUSTRALIA FLOW
    func AUSFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAusId, comment: ""), duration: 2, position: .top)
                return
                
            }
            let addObject = 12 - removeSeven.count
            
            if removeSeven.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        removeSeven = "0" + removeSeven
                    }
                }
                
                idAnimal = breedCode + countryCode + removeSeven
                breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                id17display(animalId: idAnimal, borderRed: false)
            } else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAusId, comment: ""), duration: 2, position: .top)
            }
        }
    }
    
    // MARK: - ITALY FLOW
    func italyFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidItalyId, comment: ""), duration: 2, position: .top)
                return
                
            }
            
            let addObject = 12 - removeSeven.count
            if removeSeven.count <= 12 {
                
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        removeSeven = "0" + removeSeven
                    }
                }
                
                idAnimal = breedCode + countryCode + removeSeven
                if breedCode == "XD" {
                    breedBtnOutlet.setTitle("XX", for: .normal)
                } else  {
                    breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                }
                
                id17display(animalId: idAnimal, borderRed: false)
                
            } else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidItalyId, comment: ""), duration: 2, position: .top)
            }
        }
    }
    
    // MARK: - NETHERLAND FLOW
    func neitherlandFarmID(animalId:String){
        var inputLessThenNine = animalId
        
        if inputLessThenNine.count < 9 {
            let addObject = 9 - inputLessThenNine.count
            if inputLessThenNine.count <= 9 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        inputLessThenNine = "0" + inputLessThenNine
                    }
                }
            }
        }
        scanAnimalTagText.text = providerCountryCodeAlpha2 + inputLessThenNine
        farmIdTextField.text = animalId
        farmIdTextField.becomeFirstResponder()
        self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
        farmIdTextField.endEditing(true)
    }
    
    // MARK: - BELGIUM FLOW
    func BelgiumFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidItalyId, comment: ""), duration: 2, position: .top)
                return
            }
            let addObject = 12 - removeSeven.count
            
            if removeSeven.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        removeSeven = "0" + removeSeven
                    }
                }
                
                idAnimal = breedCode + countryCode + removeSeven
                breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                id17display(animalId: idAnimal, borderRed: false)
            }
            else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidItalyId, comment: ""), duration: 2, position: .top)
            }
        }
    }
    
    // MARK: - CANADA FLOW
    func canadaFlow(animalId:String){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        let cc = removeThreeChar.prefix(4).uppercased()
        let getGender = cc.dropFirst(3).uppercased()
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        
        if countryArr.contains(countryCode.uppercased()) {
            if String(getGender) == "M" || String(getGender) == "F"{
                var removeSeven = String(idAnimal.dropFirst(6))
                if removeSeven.isInt == true {
                    if (removeSeven.count == 8) || (removeSeven.count == 9){
                        let addObject = 12 - removeSeven.count
                        if removeSeven.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal = breedCode + countryCode + removeSeven
                            breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                            genderBtnChange(genderFlag: getGender)
                            id17display(animalId: idAnimal, borderRed: false)
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                            id17display(animalId: idAnimal, borderRed: true)
                        }
                    }
                    else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        return
                    }
                }
                else {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                    
                }
            } else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
            }
            
        } else {
            id17display(animalId: idAnimal, borderRed: true)
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
        }
    }
    
    // MARK: - ARGENTINA SIRE DAM FLOW
    func ARGFlowsSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                return
                
            }
            if removeSeven.isInt == true {
                let addObject = 12 - removeSeven.count
                
                if removeSeven.count <= 12 {
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            removeSeven = "0" + removeSeven
                        }
                    }
                    idAnimal = breedCode + countryCode + removeSeven
                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                    return
                }
                else {
                    self.view.hideToast()
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                }
                
            } else {
                var firstThreeDrop = idAnimal.dropFirst(5).uppercased()
                
                if idAnimal.contains("RCE"){
                    let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                    if indexRCE != nil{
                        let beforeRCE = firstThreeDrop.substring(to: indexRCE!)
                        let animalCountE = firstThreeDrop.count - beforeRCE.count
                        let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                        let dropFirstVale = String(beforeRCE.dropLast(3))
                        
                        if dropLastEl.isInt == true && (dropFirstVale.isInt == true || dropFirstVale.count == 0 ){
                            if animalCountE == 6 {
                                let addObject = 12 - firstThreeDrop.count
                                if firstThreeDrop.count <= 12 {
                                    
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            firstThreeDrop = "0" + firstThreeDrop
                                        }
                                    }
                                    idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    return
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                        else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    }
                }
                
                if idAnimal.contains("E"){
                    if firstThreeDrop.count >= 7 {
                        let indexE = firstThreeDrop.range(of: "E", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
                                
                                if animalCountE == 6 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                        return
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        
                        return
                    }
                }
                
                if idAnimal.contains("U"){
                    if firstThreeDrop.count > 7 {
                        let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt == true || dropElast.count == 0) && (dropLastEl.isInt == true || dropLastEl.count == 0) {
                                
                                if animalCountE == 8 {
                                    let addObject = 12 - firstThreeDrop.count
                                    if firstThreeDrop.count <= 12 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                firstThreeDrop = "0" + firstThreeDrop
                                            }
                                        }
                                        idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.argentina + firstThreeDrop
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                        return
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                    } else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                }
                else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    return
                }
            }
        }
    }
    
    // MARK: - CHILI SIRE DAM FLOW
    func chiliFlowSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let s = removeThreeChar.dropFirst(3).uppercased()
        let sag = s.prefix(3).uppercased()
        var Dropsag = s.dropFirst(3).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            let removefiveZero = String(removeSeven.prefix(5))
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                return
            }
            
            if removeSeven.isInt == true {
                if removefiveZero == "00000" {
                    if removeSeven.count >= 6 && removeSeven.count <= 9 {
                        let addObject = 12 - removeSeven.count
                        if removeSeven.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.chile + removeSeven
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                    } else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                }
                else {
                    if removeSeven.count >= 6 && removeSeven.count <= 9 {
                        let addObject = 9 - removeSeven.count
                        if removeSeven.count <= 9 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + removeSeven
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                        else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    }
                    else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                }
                
            }
            else {
                if sag == "SAG" {
                    if Dropsag.count >= 6 && Dropsag.count <= 9 {
                        let addObject = 9 - Dropsag.count
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                Dropsag = "0" + Dropsag
                            }
                        }
                        
                        idAnimal = breedCode + countryCode + sag + Dropsag
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                    }
                    else {
                        self.view.hideToast()
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        return
                    }
                }
                else {
                    self.view.hideToast()
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                    return
                }
            }
        }
    }
    
    // MARK: - AUSTRALIA SIRE DAM FLOW
    func AUSFlowSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        
        if countryArr.contains(countryCode.uppercased()) {
            var removeSeven = String(idAnimal.dropFirst(5))
            
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAusId, comment: ""), duration: 2, position: .top)
                return
                
            }
            
            let addObject = 12 - removeSeven.count
            if removeSeven.count <= 12 {
                
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        removeSeven = "0" + removeSeven
                    }
                }
                
                idAnimal = breedCode + countryCode + removeSeven
                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                
            } else {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAusId, comment: ""), duration: 2, position: .top)
            }
        }
    }
    
    // MARK: - CANADA SIRE DAM FLOW
    func canadaFlowSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        let cc = removeThreeChar.prefix(4).uppercased()
        let getGender = cc.dropFirst(3).uppercased()
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        
        if countryArr.contains(countryCode.uppercased()) {
            if String(getGender) == "M" || String(getGender) == "F"{
                var removeSeven = String(idAnimal.dropFirst(6))
                if removeSeven.isInt == true {
                    if (removeSeven.count == 8) || (removeSeven.count == 9){
                        
                        let addObject = 12 - removeSeven.count
                        if removeSeven.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeSeven = "0" + removeSeven
                                }
                            }
                            
                            idAnimal = breedCode + countryCode + removeSeven
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                        }
                    } else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                } else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    
                }
            } else {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
            }
            
        } else {
            self.view.hideToast()
            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
        }
    }
    
    // MARK: - NEWZEALAND SIRE DAM FLOW
    func newzealandFlowSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        let breedCode = idAnimal.prefix(2).uppercased()
        let removeThreeChar = idAnimal.dropFirst(2).uppercased()
        let remaningString = removeThreeChar.dropFirst(3).uppercased()
        let afterFive = remaningString.prefix(3).uppercased()
        let countryCode = removeThreeChar.prefix(3).uppercased()
        if countryArr.contains(countryCode.uppercased()) {
            let removeSeven = String(idAnimal.dropFirst(5))
            if removeSeven.count == 0 {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                return
                
            }
            if afterFive.count < 3 {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                return
                
            }
            
            if afterFive.isInt == true  {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                return
                
            } else {
                let afterFiveFirstElements  = afterFive.prefix(1).uppercased()
                let afterFiveElements  = afterFive.prefix(2).uppercased()
                let afterFiveSecondElements  = afterFiveElements.dropFirst(1).uppercased()
                let afterFiveThirdElements  = afterFive.dropFirst(2).uppercased()
                
                
                if afterFiveFirstElements.isInt == true || afterFiveSecondElements.isInt == true || afterFiveThirdElements.isInt == true {
                    self.view.hideToast()
                    id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                    return
                    
                } else {
                    let afterFirstEightElements  = idAnimal.dropFirst(8).uppercased()
                    let afterEightFirst  = afterFirstEightElements.prefix(1).uppercased()
                    var afterDropNineElements  = idAnimal.dropFirst(9).uppercased()
                    
                    if afterFirstEightElements.count == 0 {
                        self.view.hideToast()
                        id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                        return
                        
                    } else {
                        
                        if afterDropNineElements.count == 0 {
                            self.view.hideToast()
                            id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                            return
                            
                        }
                        if afterDropNineElements.isInt == true  {
                            
                            let addObject = 8 - afterDropNineElements.count
                            if afterDropNineElements.count <= 8 {
                                
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        afterDropNineElements = "0" + afterDropNineElements
                                    }
                                }
                                
                                idAnimal = breedCode + countryCode + afterFive + afterEightFirst + afterDropNineElements
                                breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                                id17displaySireDam(animalId: idAnimal, borderRed: false,tag:tag)
                                
                            } else {
                                self.view.hideToast()
                                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                                return
                            }
                            
                        } else {
                            self.view.hideToast()
                            id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNZId, comment: ""), duration: 2, position: .top)
                            return
                        }
                    }
                }
            }
        }
    }
}
