//
//  OrderingAnimalVCID17Validations.swift
//  SearchPoint
//
//  Created by Mobile Programming on 22/03/24.
//

import Foundation
import UIKit

//MARK: VALIDATIONS ID17 SIRE DAM FLOW
extension OrderingAnimalVC{
    
    func validationId17SireDam(animalId:String,tag:Int){
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        let threeCharCode = breedCodesArray.value(forKey: keyValue.threeCharCode.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        
        if genderString == NSLocalizedString("Male", comment: "") {
            genderFirst = "M"
        } else if genderString == NSLocalizedString("Female", comment: "") {
            genderFirst = "F"
        }
        var idAnimal = animalId.uppercased()
        
        if idAnimal.isInt == true {
            rfidScanningSireDam(animalId: animalId, tagGiven: tag)
        }
        else {
            let firstElement = String(idAnimal.prefix(1))
            if firstElement.isInt == true {
                var idAnimal = animalId.uppercased()
                let getSec = String(idAnimal.prefix(2).uppercased())
                let second = getSec.dropFirst(1).uppercased()
                let getThi = String(idAnimal.prefix(3).uppercased())
                let thirdCHAR = getThi.dropFirst(2).uppercased()
                let getFive = String(idAnimal.prefix(5).uppercased())
                let dropBreedName = String(getFive.dropFirst(3).uppercased())
                let dropBreedFirstName = String(dropBreedName.dropFirst(1).uppercased())
                let getFour = String(dropBreedName.dropLast(1).uppercased())
                let dropFour = String(idAnimal.dropFirst(4).uppercased())
                var dropFive = String(idAnimal.dropFirst(5).uppercased())
                
                if second.isInt == true {
                    if thirdCHAR.isInt == true {
                        if breedAr.contains(dropBreedName) {
                            if dropFive.count == 0 {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                            
                            if dropFive.isInt == true || dropFive == ""{
                                let addObject = 5 - dropFive.count
                                if dropFive.count <= 5 {
                                    
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            dropFive = "0" + dropFive
                                        }
                                    }
                                    idAnimal = getFive + dropFive
                                    naabCodeCheckSireDam(animalId: idAnimal, tag: tag)
                                }
                                else {
                                    self.view.hideToast()
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                            }else {
                                self.view.hideToast()
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                        }
                        else {
                            if dropBreedName.isInt == false && dropBreedFirstName.isInt == false{
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiuneSireDam(animalId: idAnimal, tag: tag)
                                    return
                                } 
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }
                            
                            let ab = validateFirstLetter(firstLetter: Character(getFour))
                            
                            if breedAr.contains(ab)  {
                                var lastFive = dropFour
                                if lastFive.isInt == true {
                                    let addObject = 5 - lastFive.count
                                    if lastFive.count <= 5 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                lastFive = "0" + lastFive
                                            }
                                        }
                                        idAnimal =  getThi + ab + lastFive
                                        naabCodeCheckSireDam(animalId: idAnimal, tag: tag)
                                        return
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                }else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }
                            else {
                                if idAnimal.count >= 5 {
                                    let addObject = 12 - idAnimal.count
                                    if idAnimal.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idAnimal = "0" + idAnimal
                                            }
                                        }
                                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                                        
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                        
                                    }
                                    return
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }
                        }
                    } else {
                        let fo = animalId.prefix(4).uppercased()
                        let fourChar = String(fo.dropFirst(3).uppercased())
                        
                        if fourChar.count == 0 {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidInput, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                        
                        if fourChar.isInt == true {
                            let start = animalId.prefix(2).uppercased()
                            let thirddCheck = animalId.dropFirst(2)
                            let dropThird = animalId.dropFirst(3)
                            let breed = thirddCheck.prefix(1).uppercased()
                            var idFive = dropThird.uppercased()
                            let ab = validateFirstLetter(firstLetter: Character(breed))
                            
                            if breedAr.contains(ab) {
                                if idFive.isInt == true {
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + start + ab + idFive
                                        naabCodeCheckSireDam(animalId: idAnimal, tag: tag)
                                    }else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                            } else {
                                let alertAnimId = idAnimal.uppercased()
                                let addObject = 12 - idAnimal.count
                                if idAnimal.count <= 12 {
                                    
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            idAnimal = "0" + idAnimal
                                        }
                                    }
                                    idAnimal = (breedBtnOutlet.titleLabel?.text)! + providerSelectionCountryCode + idAnimal
                                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    return
                                }
                                else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: alertAnimId, borderRed: true, tag: tag)
                                    return
                                }
                            }
                        }
                        else {
                            let fetchFour = animalId.prefix(4).uppercased()
                            let dropFirsTwoBreed = fetchFour.dropFirst(2).uppercased()
                            let dropFirstFour = animalId.dropFirst(4).uppercased()
                            var idFive = dropFirstFour
                            if breedAr.contains(dropFirsTwoBreed) {
                                
                                if idFive.isInt == true {
                                    let addObject = 5 - idFive.count
                                    if idFive.count <= 5 {
                                        
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                idFive = "0" + idFive
                                            }
                                        }
                                        idAnimal = "0" + fetchFour + idFive
                                        naabCodeCheckSireDam(animalId: idAnimal, tag: tag)
                                    }
                                    else {
                                        self.view.hideToast()
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        return
                                    }
                                } else {
                                    self.view.hideToast()
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    return
                                }
                                
                            } else {
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiuneSireDam(animalId: idAnimal, tag: tag)
                                    return
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    
                                    return
                                }
                                return
                            }
                        }
                    }
                    
                }
                else {
                    if thirdCHAR.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                    
                    if thirdCHAR.isInt == true {
                        let ab = validateFirstLetter(firstLetter: Character(second))
                        if breedAr.contains(ab)  {
                            var lastFive = animalId.dropFirst(2).uppercased()
                            if lastFive.isInt == true {
                                let addObject = 5 - lastFive.count
                                if lastFive.count <= 5 {
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            lastFive = "0" + lastFive
                                        }
                                    }
                                    
                                    idAnimal = "00" + firstElement + ab + lastFive
                                    
                                    if naabArr.contains(idAnimal.uppercased()) {
                                        let fetchNaab = fetchNaabIdToAnimalId(entityName: Entities.getNaabCodeTblEntity, naabCode: idAnimal.uppercased())
                                        if fetchNaab.count == 0 {
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.noNaabCode, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        } else {
                                            let naabFetch = fetchNaab.value(forKey: keyValue.animalId.rawValue) as? NSArray
                                            idAnimal = (naabFetch![0] as? String)!
                                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                            return
                                        }
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                        
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                }
                                
                            }else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            }
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
   
                    } else {
                        let dropFirst = getThi.dropFirst(1).uppercased()
                        
                        if breedAr.contains(dropFirst)  {
                            let arr = idAnimal.components(separatedBy: dropFirst)
                            var lastFive = arr[1]
                            let addObject = 5 - lastFive.count
                            if lastFive.count <= 5 {
                                if lastFive.count == 0 {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                                
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        lastFive = "0" + lastFive
                                    }
                                }
                                idAnimal = "00" + getThi + lastFive
                                naabCodeCheckSireDam(animalId: idAnimal, tag: tag)
                            }else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        } else {
                            self.view.hideToast()
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidBreedCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                    }
                }
                
            } else {
                let firstThreeElement = String(idAnimal.prefix(3).uppercased())
                let firstTwo = String(idAnimal.prefix(2).uppercased())
                let removeFirstThree = String(idAnimal.dropFirst(3).uppercased())
                let getCountryCode = String(removeFirstThree.prefix(3).uppercased())
                let gGet = String(removeFirstThree.prefix(4).uppercased())
                let genderGet = String(gGet.dropFirst(3).uppercased())
                if firstThreeElement.isInt == true {
                    
                } else {
                    if threeCharCode.contains(firstThreeElement) {
                        let indexOfA = threeCharCode.index(of: firstThreeElement)
                        
                        if getCountryCode.uppercased() == "" || getCountryCode.count == 1 || getCountryCode.count == 2{
                            self.view.hideToast()
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                        
                        
                        if countryArr.contains(getCountryCode.uppercased()) || counteryNumericArr.contains(Int(getCountryCode) as Any){
                            if String(genderGet) == "M" || String(genderGet) == "F"{
                                var removeSeven = String(idAnimal.dropFirst(7))
                                
                                if removeSeven.count == 0 {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                    
                                }
                      
                                let addObject = 12 - removeSeven.count
                                if removeSeven.count <= 12 {
                                    
                                    if addObject != 0 {
                                        for _ in 0...addObject - 1{
                                            removeSeven = "0" + removeSeven
                                        }
                                    }
                                    
                                    idAnimal = firstThreeElement + getCountryCode + removeSeven
    
                                    if getCountryCode == "840" || getCountryCode == "USA"{
                                        let obj1 = rangeCheckReturnString(animalId: String(idAnimal.dropFirst(7)), countryCode: getCountryCode)
                                        
                                        if obj1 == LocalizedStrings.invalidRangeStr {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: firstThreeElement + removeFirstThree , borderRed: true, tag: tag)
                                            return
                                        }
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        idAnimal = breedTwo + obj1 + removeSeven
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    } else {
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        idAnimal = breedTwo + getCountryCode + removeSeven
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    }
                                    
                                } else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    
                                    return
                                }
                                
                            } else {
                                self.view.hideToast()
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                            
                        }else {
                            self.view.hideToast()
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                            return
                        }
                    } else {
                        
                        if breedAr.contains(firstTwo) {
                            let getTwoBreedCode = firstThreeElement.dropLast(1)
                            let removeThreeChar = idAnimal.dropFirst(2)
                            let countryCode = removeThreeChar.prefix(3).uppercased()
                            if countryCode.isInt == true {
                                id17FlowNumericSireDam(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo, tag: tag)
                                return
                            }
                            let cc = removeThreeChar.prefix(4).uppercased()
                            let getGender = cc.dropFirst(3).uppercased()
                            
                            if countryCode.count != 3 {
                                self.view.hideToast()
                                id17displaySireDam(animalId: animalId.uppercased(), borderRed: true, tag: tag)
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                                return
                            }
                            if countryCode == CountryCodes.canada {
                                canadaFlowSireDam(animalId: idAnimal, tag: tag)
                                return
                            }
                            if countryCode == CountryCodes.australia {
                                AUSFlowSireDam(animalId: idAnimal, tag: tag)
                                return
                            }
                            if countryCode == CountryCodes.chile {
                                
                                chiliFlowSireDam(animalId:idAnimal, tag: tag)
                                return
                            }
                            if countryCode == CountryCodes.argentina {
                                ARGFlowsSireDam(animalId: idAnimal, tag: tag)
                                return
                            }
                            if countryCode == CountryCodes.newZealand {
                                newzealandFlowSireDam(animalId:idAnimal,tag:tag)
                                return
                            }
                            if countryCode == CountryCodes.italy {
                                italyFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryCode == CountryCodes.netherland {
                                italyFlow(animalId: idAnimal)
                                return
                            }
                            
                            if countryArr.contains(countryCode.uppercased()) {
                                if String(getGender) == "M" || String(getGender) == "F"{
                                    var removeSeven = String(idAnimal.dropFirst(6))
                                    if removeSeven.isInt == true {
                                        let addObject = 12 - removeSeven.count
                                        if removeSeven.count <= 12 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    removeSeven = "0" + removeSeven
                                                }
                                            }
                                            
                                            idAnimal = getTwoBreedCode + countryCode + removeSeven
                                            let obj = rangeCheck(animalId:  removeSeven, countryCode: countryCode.uppercased())
                                            
                                            if obj == true{
                                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                                
                                            } 
                                            else {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                                                id17displaySireDam(animalId: animalId.uppercased(), borderRed: true, tag: tag)
                                            }
                                        }
                                        else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        }
                                    }
                                    else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        
                                    }
                                } else {
                                    let dropFive = String(idAnimal.dropFirst(5))
                                    id17FlowNumericSireDam(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo, tag: tag)
                                }
                                
                            } else {
                                if breedAr.contains(firstTwo) {
                                    var dropOne = idAnimal.dropFirst(1).uppercased()
                                    var nextThree = dropOne.prefix(3).uppercased()
                                    var dropThree = dropOne.dropFirst(3).uppercased()
                                    
                                    if countryArr.contains(nextThree.uppercased()) {
                                        let addObject = 12 - dropThree.count
                                        
                                        if dropThree.count <= 12 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    dropThree = "0" + dropThree
                                                }
                                            }
                                            
                                            let ob = rangeCheckReturnString(animalId: dropThree, countryCode: nextThree)
                                            if ob == LocalizedStrings.invalidRangeStr {
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                                return
                                            }
                                            else {
                                                idAnimal = firstTwo + ob +  dropThree
                                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                                return
                                            }
                                            
                                        }else {
                                            self.view.hideToast()
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            return
                                        }
                                    }
                                    var dropFirstTwo = idAnimal.dropFirst(2).uppercased()
                                    let addObject = 12 - dropFirstTwo.count
                                    
                                    if dropFirstTwo.count <= 12 {
                                        if addObject != 0 {
                                            for _ in 0...addObject - 1{
                                                dropFirstTwo = "0" + dropFirstTwo
                                            }
                                        }
                                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  dropFirstTwo
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    } else {
                                        self.view.hideToast()
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                        return
                                    }
                                }
                                else {
                                    self.view.hideToast()
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                                }
                            }
                        } else {
                            idseventiyfiftySireDam(animalId: idAnimal, tag: tag)
                        }
                    }
                }
            }
        }
    }
    
    func idseventiyfiftySireDam(animalId:String,tag:Int){
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        
        if genderString == "Male".localized {
            genderFirst = "M"
        } else if genderString == "Female".localized {
            genderFirst = "F"
        }
        var idAnimal = animalId.uppercased()
        let firstTwoBreedCode = String(idAnimal.prefix(2).uppercased())
        let cCheck = String(idAnimal.prefix(5).uppercased())
        let countryCode = String(cCheck.dropFirst(2).uppercased())
        let gender = String(idAnimal.prefix(6).uppercased())
        let getGender = String(gender.dropFirst(5).uppercased())
        var removeFirstSix = String(idAnimal.dropFirst(6).uppercased())
        var removeFive = String(idAnimal.dropFirst(5).uppercased())
        let firstthrree = String(idAnimal.prefix(3).uppercased())
        
        if firstTwoBreedCode.isInt == true {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
            return
        }
        else {
            if breedAr.contains(firstTwoBreedCode) {
                if countryCode.isInt == true{
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if removeFive.isInt == true {
                            let addObject = 12 - removeFive.count
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    removeFive = "0" + removeFive
                                }
                            }
                            
                            idAnimal =  firstTwoBreedCode  + countryCode + removeFive
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                            
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        }
                    } else {
                        self.view.hideToast()
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                    }
                } else {
                    if countryArr.contains(countryCode.uppercased()) || counteryNumericArr.contains(Int(countryCode) as Any){
                        if String(getGender) == "M" || String(getGender) == "F"{
                            if removeFirstSix.isInt == true {
                                let addObject = 12 - removeFirstSix.count
                                
                                if addObject != 0 {
                                    for _ in 0...addObject - 1{
                                        removeFirstSix = "0" + removeFirstSix
                                    }
                                }
                                
                                idAnimal =  firstTwoBreedCode  + countryCode + removeFirstSix
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                return
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
                
            } else {
                if countryArr.contains(firstthrree.uppercased()) {
                    if firstthrree == CountryCodes.chile || firstthrree == "chl" {
                        if idAnimal.isInt != true {
                            let firstSixLetter = idAnimal.prefix(6).uppercased()
                            let firstThreeLetter = firstSixLetter.prefix(3).uppercased()
                            let nextThree = firstSixLetter.dropFirst(3).uppercased()
                            var dropFirstSix = idAnimal.dropFirst(6).uppercased()
                            if firstThreeLetter == CountryCodes.chile {
                                if nextThree == "SAG" {
                                    if dropFirstSix.count >= 6 && dropFirstSix.count <= 9 {
                                        
                                        let addObject = 9 - dropFirstSix.count
                                        if dropFirstSix.count <= 9 {
                                            if addObject != 0 {
                                                for _ in 0...addObject - 1{
                                                    dropFirstSix = "0" + dropFirstSix
                                                }
                                            }
                                            
                                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + firstSixLetter + dropFirstSix
                                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                            return
                                        } else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        }
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                } else {
                                    var idanimmal = idAnimal.dropFirst(3).uppercased()
                                    let dropFive = idanimmal.prefix(5).uppercased()
                                    if dropFive == "00000" {
                                        
                                        if idanimmal.count >= 6 && idanimmal.count <= 9 {
                                            let addObject = 12 - idanimmal.count
                                            if idanimmal.count <= 12 {
                                                if addObject != 0 {
                                                    for _ in 0...addObject - 1{
                                                        idanimmal = "0" + idanimmal
                                                    }
                                                }
                                                idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + CountryCodes.chile + idanimmal
                                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                                return
                                            } else  {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                                return
                                            }
                                        }else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        }
                                    } else {
                                        if idanimmal.count >= 6 && idanimmal.count <= 9 {
                                            let addObject = 9 - idanimmal.count
                                            if idanimmal.count <= 9 {
                                                if addObject != 0 {
                                                    for _ in 0...addObject - 1{
                                                        idanimmal = "0" + idanimmal
                                                    }
                                                }
                                                idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + idanimmal
                                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                                return
                                            } else {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                                return
                                            }
                                        }
                                        else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        }
                                    }
                                }
                                
                            } else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                    }
                }
                
                if firstthrree == "SAG" {
                    let firstThreeDrop = idAnimal.dropFirst(3).uppercased()
                    if firstThreeDrop.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                        
                    }
                    
                    if firstThreeDrop.isInt == true {
                        if firstThreeDrop.count >= 6 &&  firstThreeDrop.count <= 9 {
                            var idanimmal = idAnimal.dropFirst(3).uppercased()
                            let addObject = 9 - idanimmal.count
                            
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    idanimmal = "0" + idanimmal
                                }
                            }
                            idAnimal =  (breedBtnOutlet.titleLabel?.text)!  + "CHLSAG" + idanimmal
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                            
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                }
                
                if firstthrree == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal.dropFirst(3).uppercased()
                    if firstThreeDrop.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                    
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
                            else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                    }
                    
                    if idAnimal.contains("E"){
                        if firstThreeDrop.count > 7 {
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
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        }
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        }
                    }
                }
  
                if providerSelectionCountryCode == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal
                    
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
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
                        }
                    }
                    
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
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                                
                            } else {
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                return
                            }
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
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            return
                                        }
                                        
                                    } else {
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        return
                                    }
                                    
                                } else {
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                }
                            }
                            
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    }
                }
                let firsttt = firstthrree.prefix(1).uppercased()
                let ab = validateFirstLetter(firstLetter: Character(firsttt))
                
                if ab.count != 0 {
                    let dropFirstFour = idAnimal.prefix(4).uppercased()
                    let dropFirstOne = dropFirstFour.dropFirst(1).uppercased()
                    var dropFour = idAnimal.dropFirst(4).uppercased()
                    
                    if dropFirstOne == "" {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                    
                    if countryArr.contains(dropFirstOne.uppercased()) {
                        let addObject = 12 - dropFour.count
                        if dropFour.count <= 12 {
                            if addObject != 0 {
                                for _ in 0...addObject - 1{
                                    dropFour = "0" + dropFour
                                }
                            }
                            if dropFirstOne == "840" || dropFirstOne == "USA"{
                                let ob = rangeCheckReturnString(animalId: dropFour, countryCode: dropFirstOne)
                                if ob == LocalizedStrings.invalidRangeStr {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    return
                                } 
                                else {
                                    idAnimal = ab + ob +  dropFour
                                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    return
                                }
                            } else {
                                idAnimal = ab + dropFirstOne +  dropFour
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                return
                            }
                        } else {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    }
                }
                let countryCode = idAnimal.prefix(3).uppercased()
                var remaningValue = idAnimal.dropFirst(3).uppercased()
  
                if idAnimal.isAlphanumeric == true {
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    return
                }
                
                if countryArr.contains(countryCode.uppercased()) {
                    let addObject = 12 - remaningValue.count
                    if remaningValue.count <= 12 {
                        
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                remaningValue = "0" + remaningValue
                            }
                        }
                        
                        if remaningValue.isInt == true {
                            if countryCode == "840" || countryCode == "USA"{
                                let ob = rangeCheckReturnString(animalId: remaningValue, countryCode: countryCode)
                                idAnimal = breedBtnOutlet.titleLabel!.text! + ob +  remaningValue
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            }
                            else {
                                idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                return
                            }
                            
                        } else {
                            idAnimal = breedBtnOutlet.titleLabel!.text! + countryCode +  remaningValue
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                    }
                } 
                else {
                    let addObject = 12 - idAnimal.count
                    if idAnimal.count <= 12 {
                        
                        if addObject != 0 {
                            for _ in 0...addObject - 1{
                                idAnimal = "0" + idAnimal
                            }
                        }
                        idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                        return
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                }
            }
        }
    }
    
    func rfidScanningSireDam(animalId:String,tagGiven:Int){
        let numberAsInt = Int(animalId)
        let backToString = "\(numberAsInt!)"
        var idAnimal = backToString
        let firstValueThree = idAnimal.prefix(1)
        var get3CountryCode = idAnimal.prefix(3)
        let drop3 = idAnimal.dropFirst(3).uppercased()
        var inputLessThenEight = animalId
        
        if inputLessThenEight.count < 8 {
            let addObject = 12 - inputLessThenEight.count
            if inputLessThenEight.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        inputLessThenEight = "0" + inputLessThenEight
                    }
                }
            }
            
            let obj1 = rangeCheckReturnString(animalId: String(inputLessThenEight), countryCode: providerSelectionCountryCode)
            
            if obj1 == LocalizedStrings.invalidRangeStr {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: animalId, borderRed: true, tag: tagGiven)
                return
            } 
            else {
                idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode + inputLessThenEight
                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                return
            }
        }
 
        if get3CountryCode.count != 3 {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
            return
        }
        
        var dropElments = idAnimal
        if firstValueThree == "3" && (003001000001) <= (Int(animalId)!) && providerSelectionCountryCode == "USA"{
            let addObject = 12 - dropElments.count
            if dropElments.count <= 12 {
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        dropElments = "0" + dropElments
                    }
                }
            }
            
            idAnimal = breedBtnOutlet.titleLabel!.text! + "840" + dropElments
            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
            return
        }
        
        if counteryNumericArr.contains(Int(get3CountryCode) as Any){
            var digitsTwelve = dropElments.dropFirst(3)
            if digitsTwelve.count == 0  {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                return
            }
            if digitsTwelve.count <= 12 {
                if get3CountryCode == "840" || get3CountryCode == "USA"{
                    if get3CountryCode == "840" && (003001000001) <= (Int(digitsTwelve)!) {
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                        return
                    } 
                    else if get3CountryCode == "840" && (10000...003001000001).contains(Int(digitsTwelve)!)  {
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        if get3CountryCode == "840"{
                            get3CountryCode = "USA"
                        }
                        
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                        return
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                        return
                    }
                } 
                else {
                    let addObject = 12 - digitsTwelve.count
                    if addObject != 0{
                        for _ in 0...addObject - 1{
                            digitsTwelve = "0" + digitsTwelve
                        }
                    }
                    if get3CountryCode == "000"{
                        get3CountryCode = "USA"
                    }
                    
                    idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                    
                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                    return
                }
            } 
            else {
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalRFIDId, comment: ""), duration: 2, position: .top)
                return
            }
        }
        else {
            if drop3.count == 0 {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                return
            }
            if idAnimal.count >= 5 {
                let addObject = 12 - idAnimal.count
                if idAnimal.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            idAnimal = "0" + idAnimal
                        }
                    }
                    idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                    return
                } else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                    return
                }
                return
                
            } else {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                return
            }
        }
    }
    
    func id17displaySireDam(animalId:String,borderRed :Bool,tag:Int){
        self.borderRedChange = borderRed
        var idAnimal = animalId
        
        if tag == 3 {
            if borderRedChange == false{
                sireIdTextField.text! = idAnimal.uppercased()
                sireIdTextField.textColor = UIColor.black
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                sireIdValidationB = false
                buttonbgAutoSuggestion.removeFromSuperview()
                return
            } 
            else {
                sireIdTextField.textColor = UIColor.red
                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                sireIdValidationB = true
                return
            }
        }
        else if tag == 4 {
            if borderRedChange == false{
                damtexfield.text! = idAnimal.uppercased()
                damtexfield.textColor = UIColor.black
                damtexfield.layer.borderColor = UIColor.gray.cgColor
                damIdValidationB = false
                return
            } 
            else {
                damtexfield.textColor = UIColor.red
                damtexfield.layer.borderColor = UIColor.red.cgColor
                damIdValidationB = true
                return
            }
        }
    }
    
    func naabCodeCheckSireDam(animalId:String,tag:Int){
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        var borderRedChange = true
        var idAnimal = animalId
        
        if naabArr.contains(idAnimal.uppercased()) {
            let fetchNaab = fetchNaabIdToAnimalId(entityName: Entities.getNaabCodeTblEntity, naabCode: idAnimal.uppercased())
            if fetchNaab.count == 0 {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
            } 
            else {
                let naabFetch = fetchNaab.value(forKey: keyValue.animalId.rawValue) as? NSArray
                idAnimal = (naabFetch![0] as? String)!
                id17displaySireDam(animalId: idAnimal, borderRed: false,tag:tag)
            }
        }
        else {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
        }
    }
    
    func id17FlowNumericSireDam(animalId:String,countryCode:String,breedCode:String,tag:Int){
        var countryC = countryCode
        var breedC = breedCode
        var idAnimal = animalId.uppercased()
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        var dropFive = idAnimal.dropFirst(5).uppercased()
  
        if countryArr.contains(countryC.uppercased()) || counteryNumericArr.contains(Int(countryC) as Any){
            if dropFive.count == 0 {//|| dropFive.isInt == false{
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                return
            }
            
            if dropFive.count <= 12 {
                
                var addObject = 12 - dropFive.count
                if dropFive.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            dropFive = "0" + dropFive
                        }
                    }
                    
                    if dropFive.isInt == true {
                        var obj = rangeCheckReturnString(animalId: dropFive, countryCode: countryC)
                        
                        if obj == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                        
                        idAnimal = breedC + obj + dropFive
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                    } else {
                        idAnimal = breedC + countryC + dropFive
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                    }
                } else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    
                }
            } else {
                self.view.hideToast()
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
            }
            
        } 
        else {
            let firstTwo = idAnimal.prefix(2).uppercased()
            
            if breedAr.contains(firstTwo) {
                var dropFirstTwo = idAnimal.dropFirst(2).uppercased()
                let addObject = 12 - dropFirstTwo.count
                
                if dropFirstTwo.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            dropFirstTwo = "0" + dropFirstTwo
                        }
                    }
                    
                    if countryCode == "840" || countryCode == "USA"{
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        if ob == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                            
                        }
                        else {
                            idAnimal = firstTwo + ob +  dropFirstTwo
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                    } 
                    else {
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        
                        if ob == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                        else {
                            breedBtnOutlet.setTitle(firstTwo,for: .normal)
                            idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                        
                        idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                        return
                    }
                }
                else {
                    self.view.hideToast()
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                    return
                }
            }
        }
    }
    
    func rinvalidBreedCodeContiuneSireDam(animalId:String,tag:Int){
        var idAnimal = animalId
        
        if idAnimal.count >= 5 {
            let addObject = 12 - idAnimal.count
            if idAnimal.count <= 12 {
                
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        idAnimal = "0" + idAnimal
                    }
                }
                
                idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode +  idAnimal
                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                return
            }
            else {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                return
                
            }
            return
            
        } 
        else {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidRFIDId, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
            return
        }
    }
    
    func contiuneValidation() {
        if scanAnimalTagText.tag == 1{
            if scanAnimalTagText.text == "" || scanBarcodeText.text == "" {
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                }
                else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
                
                if scanBarcodeText.text!.count == 0 {
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    scanBarcodeText.textColor = UIColor.red
                }
                else {
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    scanBarcodeText.textColor = UIColor.black
                }
                
            }
        }
        else {
            if scanAnimalTagText.text == "" || scanBarcodeText.text == "" {//}  || dateBtnOutlet.titleLabel?.text == ""{
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                }
                else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
                
                if scanBarcodeText.text!.count == 0 {
                    barcodeView.layer.borderColor = UIColor.red.cgColor
                    scanBarcodeText.textColor = UIColor.red
                }
                else {
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    scanBarcodeText.textColor = UIColor.black
                }
            }
        }
    }
    
    func validation() {
        if damIdValidationB == true {
            damtexfield.layer.borderColor = UIColor.red.cgColor
        }
        else {
            damtexfield.layer.borderColor = UIColor.gray.cgColor
        }
        
        if sireIdValidationB == true {
            sireIdTextField.layer.borderColor = UIColor.red.cgColor
        } else {
            sireIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if scanAnimalTagText.text == ""{
            officalTagView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            officalTagView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if !isCheckCountryUK() {
            if farmIdTextField.text == ""{
                farmIdView.layer.borderColor = UIColor.gray.cgColor
            }
            
        } else  {
            if farmIdTextField.text == "" {
                farmIdView.layer.borderColor = UIColor.red.cgColor
            }
            else {
                farmIdView.layer.borderColor = UIColor.gray.cgColor
            }
        }
        
        if scanBarcodeText.text == ""{
            barcodeView.layer.borderColor = UIColor.red.cgColor
        }
        else {
            barcodeView.layer.borderColor = UIColor.gray.cgColor
        }
        
        if breedBtnOutlet.titleLabel!.text == ButtonTitles.breedText{
            breedBtnOutlet.layer.borderColor = UIColor.red.cgColor
        }
        else {
            breedBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        }
        
        if sireIAuTextField.text == ""{
            sireIAuTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
        }
        if nationalHerdIdTextField.text == ""{
            nationalHerdIdTextField.layer.borderColor = UIColor.red.cgColor
        }
        else {
            nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
        }
        
        if etBtn == "" {
            etBttn.layer.borderColor = UIColor.red.cgColor
            multipleBirthBttn.layer.borderColor = UIColor.red.cgColor
            singleBttn.layer.borderColor = UIColor.red.cgColor
            cloneOutlet.layer.borderColor = UIColor.red.cgColor
            SplitEmbryoOutlet.layer.borderColor = UIColor.red.cgColor
            internalBtnOulet.layer.borderColor = UIColor.red.cgColor
            etBttn.layer.borderWidth = 0.5
            singleBttn.layer.borderWidth = 0.5
            multipleBirthBttn.layer.borderWidth = 0.5
            cloneOutlet.layer.borderWidth = 0.5
            SplitEmbryoOutlet.layer.borderWidth = 0.5
            internalBtnOulet.layer.borderWidth = 0.5
        }
        else {
            if etBtn == LocalizedStrings.multipleBirthStr {
                etBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderWidth = 2
                multipleBirthBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                selectedBornTypeId = 2
                
            } else if etBtn == "Et"{
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                selectedBornTypeId = 3
                
            } else if etBtn == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "") {
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderWidth = 2
                SplitEmbryoOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                selectedBornTypeId = 4
                
            }
            else if etBtn == LocalizedStrings.cloneText {
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor.gray.cgColor
                cloneOutlet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                selectedBornTypeId = 5
            }
            
            else if etBtn == LocalizedStrings.internalStr {
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
                singleBttn.layer.borderColor = UIColor.gray.cgColor
                etBttn.layer.borderColor = UIColor.gray.cgColor
                SplitEmbryoOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderWidth = 2
                cloneOutlet.layer.borderColor = UIColor.gray.cgColor
                internalBtnOulet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                selectedBornTypeId = 6
            }
            else {
                etBttn.layer.borderColor = UIColor.gray.cgColor
                multipleBirthBttn.layer.borderColor = UIColor.gray.cgColor
            }
        }
    }
}


