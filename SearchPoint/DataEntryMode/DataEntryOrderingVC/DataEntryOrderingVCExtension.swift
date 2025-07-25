//
//  DataEntryOrderingVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 24/02/24.
//

import Foundation

extension DataEntryOrderingAnimalVC{
    
    func validationId17SireDam(animalId:String,tag:Int){
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        let threeCharCode = breedCodesArray.value(forKey: keyValue.threeCharCode.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        
        if genderString == ButtonTitles.maleText.localized {
            genderFirst = "M"
        } else if genderString == ButtonTitles.femaleText.localized {
            genderFirst = "F"
        } else {
            
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
                                    
                                } else {
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
                        } else {
                            if dropBreedName.isInt == false && dropBreedFirstName.isInt == false{
                                if idAnimal.count >= 5 {
                                    rinvalidBreedCodeContiuneSireDam(animalId: idAnimal, tag: tag)
                                    return
                                } else {
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
                                    }else {
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
                            }else {
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
                                        
                                    } else {
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
                                    
                                } else {
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
                                }else {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: alertAnimId, borderRed: true, tag: tag)
                                    return
                                }
                            }
                        } else {
                            // Four leterr in char
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
                                        
                                    }else {
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
                } else {
                    
                    if thirdCHAR.count == 0 {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidNaabCode, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
                    if thirdCHAR.isInt == true {
                        let ab = validateFirstLetter(firstLetter: Character(second))
                        print(ab)
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
                                    print(idAnimal)
                                    print(idAnimal.count)
                                    if naabArr.contains(idAnimal.uppercased()) {
                                        print("contain")
                                        
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
                                print(idAnimal)
                                print(idAnimal.count)
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
                                    if getCountryCode == LocalizedStrings.eightFortyCountryCode || getCountryCode == LocalizedStrings.usaCountryCode{
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
                                        print(idAnimal.count)
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                        
                                    } else {
                                        let breedC = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as? NSArray
                                        let breedTwo = (breedC![indexOfA] as? String)!
                                        idAnimal = breedTwo + getCountryCode + removeSeven
                                        print(idAnimal.count)
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
                            if countryCode == "CAN" {
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
                            if countryCode == "NZL" {
                                newzlandFlowSireDam(animalId:idAnimal,tag:tag)
                                return
                            }
                            if countryCode == "ITA" {
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
                                                print(idAnimal)
                                                print(idAnimal.count)
                                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                                
                                            } else {
                                                self.view.hideToast()
                                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimUSA, comment: ""), duration: 2, position: .top)
                                                id17displaySireDam(animalId: animalId.uppercased(), borderRed: true, tag: tag)
                                            }
                                            
                                        } else {
                                            self.view.hideToast()
                                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalD17Code, comment: ""), duration: 2, position: .top)
                                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                            
                                        }
                                    } else {
                                        self.view.hideToast()
                                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                        
                                    }
                                } else {
                                    id17FlowNumericSireDam(animalId: idAnimal,countryCode:countryCode,breedCode:firstTwo, tag: tag)
                                }
                                
                            } else {
                                if breedAr.contains(firstTwo) {
                                    let dropOne = idAnimal.dropFirst(1).uppercased()
                                    let nextThree = dropOne.prefix(3).uppercased()
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
                                                
                                            }else {
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
                                        print(dropFirstTwo)
                                        
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
        if genderString == ButtonTitles.maleText.localized {
            genderFirst = "M"
        } else if genderString == ButtonTitles.femaleText.localized {
            genderFirst = "F"
        } else {
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
            // Breed code check
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
                        if idAnimal.isInt == true {
                        } else {
                            
                            print(idAnimal)
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
                                            print(idAnimal)
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
                                                print(idAnimal)
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
                                                print(idAnimal)
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
                            print(idAnimal)
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                            
                        } else {
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
                            print(beforeRCE)
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            print(animalCountE)
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
                                        print(idAnimal)
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
                            }else {
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
                                print(beforeE)
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
                                            print(idAnimal)
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
                        }}
                    
                    if idAnimal.contains("U"){
                        if firstThreeDrop.count > 7 {
                            
                            let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                            if indexE != nil{
                                let beforeE = firstThreeDrop.substring(to: indexE!)
                                print(beforeE)
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
                                            print(idAnimal)
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
                        }}
                }
                
                if providerSelectionCountryCode == CountryCodes.argentina {
                    var firstThreeDrop = idAnimal
                    
                    if idAnimal.contains("RCE"){
                        let indexRCE = firstThreeDrop.range(of: "RCE", options: .forcedOrdering)?.upperBound
                        if indexRCE != nil{
                            let beforeRCE = firstThreeDrop.substring(to: indexRCE!)
                            print(beforeRCE)
                            let animalCountE = firstThreeDrop.count - beforeRCE.count
                            print(animalCountE)
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
                                        print(idAnimal)
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
                        //ARG00000E100203
                        if indexE != nil{
                            let beforeE = firstThreeDrop.substring(to: indexE!)
                            print(beforeE)
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
                                        print(idAnimal)
                                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                        
                                        //  id17display(animalId: idAnimal, borderRed: false)
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
                            //ARG00000E100203
                            if indexE != nil{
                                let beforeE = firstThreeDrop.substring(to: indexE!)
                                print(beforeE)
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
                                            print(idAnimal)
                                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                            
                                            //  id17display(animalId: idAnimal, borderRed: false)
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
                        }}
                }
                
                let firsttt = firstthrree.prefix(1).uppercased()
                let ab = validateFirstLetter(firstLetter: Character(firsttt))
                print(ab)
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
                            
                            if dropFirstOne == LocalizedStrings.eightFortyCountryCode || dropFirstOne == LocalizedStrings.usaCountryCode{
                                
                                let ob = rangeCheckReturnString(animalId: dropFour, countryCode: dropFirstOne)
                                if ob == LocalizedStrings.invalidRangeStr {
                                    self.view.hideToast()
                                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                                    
                                    return
                                    
                                } else {
                                    idAnimal = ab + ob +  dropFour
                                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                    return
                                }
                            } else {
                                idAnimal = ab + dropFirstOne +  dropFour
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                return
                            }
                            //  }
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
                            if countryCode == LocalizedStrings.eightFortyCountryCode || countryCode == LocalizedStrings.usaCountryCode{
                                let ob = rangeCheckReturnString(animalId: remaningValue, countryCode: countryCode)
                                idAnimal = breedBtnOutlet.titleLabel!.text! + ob +  remaningValue
                                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                                
                            } else {
                                
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
                } else {
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
                        
                    } else {
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
            } else {
                idAnimal = breedBtnOutlet.titleLabel!.text! + providerSelectionCountryCode + inputLessThenEight
                print(idAnimal.count)
                id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                return
            }
        }
        
        if get3CountryCode.count != 3 {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
            //     borderRedCheck = true
            return
        }
        
        var dropElments = idAnimal
        if firstValueThree == "3" && (003001000001) <= (Int(animalId)!) && providerSelectionCountryCode == LocalizedStrings.usaCountryCode{
            let addObject = 12 - dropElments.count
            if dropElments.count <= 12 {
                
                if addObject != 0 {
                    for _ in 0...addObject - 1{
                        dropElments = "0" + dropElments
                    }
                }
            }
            
            idAnimal = breedBtnOutlet.titleLabel!.text! + LocalizedStrings.eightFortyCountryCode + dropElments
            print(idAnimal.count)
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
                if get3CountryCode == LocalizedStrings.eightFortyCountryCode || get3CountryCode == LocalizedStrings.usaCountryCode{
                    if get3CountryCode == LocalizedStrings.eightFortyCountryCode && (003001000001) <= (Int(digitsTwelve)!) {
                        
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        print(idAnimal.count)
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                        return
                    } else if get3CountryCode == LocalizedStrings.eightFortyCountryCode && (10000...003001000001).contains(Int(digitsTwelve)!)  {
                        print(digitsTwelve.count)
                        
                        let addObject = 12 - digitsTwelve.count
                        if addObject != 0{
                            for _ in 0...addObject - 1{
                                digitsTwelve = "0" + digitsTwelve
                            }
                        }
                        if get3CountryCode == LocalizedStrings.eightFortyCountryCode{
                            get3CountryCode = "USA"
                        }
                        
                        idAnimal = breedBtnOutlet.titleLabel!.text! + get3CountryCode + digitsTwelve
                        print(idAnimal.count)
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                        return
                    } else {
                        
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                        return
                        
                    }
                } else {
                    
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
                    print(idAnimal.count)
                    id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tagGiven)
                    return
                }
                
            } else {
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tagGiven)
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnimalRFIDId, comment: ""), duration: 2, position: .top)
                return
            }
            
        } else {
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
        let idAnimal = animalId
        
        if tag == 3 {
            if borderRedChange == false{
                sireIdTextField.text! = idAnimal.uppercased()
                sireIdTextField.textColor = UIColor.black
                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
                sireIdValidationB = false
                buttonbgAutoSuggestion.removeFromSuperview()
                return
            } else {
                sireIdTextField.textColor = UIColor.red
                sireIdTextField.layer.borderColor = UIColor.red.cgColor
                sireIdValidationB = true
                return                }
            
        } else if tag == 4 {
            
            if borderRedChange == false{
                damtexfield.text! = idAnimal.uppercased()
                
                
                damtexfield.textColor = UIColor.black
                damtexfield.layer.borderColor = UIColor.gray.cgColor
                damIdValidationB = false
                return
            } else {
                damtexfield.textColor = UIColor.red
                damtexfield.layer.borderColor = UIColor.red.cgColor
                damIdValidationB = true
                return
            }
        }
    }
    
    func newzlandFlowSireDam(animalId:String,tag:Int){
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
                                print(idAnimal)
                                print(idAnimal.count)
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
    
    func naabCodeCheckSireDam(animalId:String,tag:Int){
        let naabArr = naabCodesArray.value(forKey: keyValue.naabCode.rawValue) as! NSArray
        var idAnimal = animalId
        
        if naabArr.contains(idAnimal.uppercased()) {
            let fetchNaab = fetchNaabIdToAnimalId(entityName: Entities.getNaabCodeTblEntity, naabCode: idAnimal.uppercased())
            if fetchNaab.count == 0 {
                
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
            } else {
                let naabFetch = fetchNaab.value(forKey: keyValue.animalId.rawValue) as? NSArray
                idAnimal = (naabFetch![0] as? String)!
                id17displaySireDam(animalId: idAnimal, borderRed: false,tag:tag)
            }
        }else {
            self.view.hideToast()
            self.view.makeToast(NSLocalizedString(LocalizedStrings.naabCodeNotFound, comment: ""), duration: 2, position: .top)
            id17displaySireDam(animalId: idAnimal, borderRed: true,tag:tag)
        }
    }
    
    func id17FlowNumericSireDam(animalId:String,countryCode:String,breedCode:String,tag:Int){
        
        let countryC = countryCode
        let breedC = breedCode
        var idAnimal = animalId.uppercased()
        let breedAr = breedCodesArray.value(forKey: keyValue.alpha2.rawValue) as! NSArray
        countryCodesArray = fetchAllData(entityName: Entities.getCountryCodeTblEntity)
        let countryArr = countryCodesArray.value(forKey: keyValue.alphaCode.rawValue) as! NSArray
        let counteryNumericArr = countryCodesArray.value(forKey: keyValue.numericCode.rawValue) as! NSArray
        var dropFive = idAnimal.dropFirst(5).uppercased()
        
        if countryArr.contains(countryC.uppercased()) || counteryNumericArr.contains(Int(countryC) as Any){
            if dropFive.count == 0 {
                self.view.hideToast()
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCodeStr, comment: ""), duration: 2, position: .top)
                id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                return
            }
            
            if dropFive.count <= 12 {
                let addObject = 12 - dropFive.count
                if dropFive.count <= 12 {
                    
                    if addObject != 0 {
                        for _ in 0...addObject - 1{
                            dropFive = "0" + dropFive
                        }
                    }
                    if dropFive.isInt == true {
                        let obj = rangeCheckReturnString(animalId: dropFive, countryCode: countryC)
                        
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
            
        } else {
            
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
                    
                    if countryCode == LocalizedStrings.eightFortyCountryCode || countryCode == LocalizedStrings.usaCountryCode{
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        if ob == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            
                            return
                            
                        } else {
                            idAnimal = firstTwo + ob +  dropFirstTwo
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                    } else {
                        
                        let ob = rangeCheckReturnString(animalId: dropFirstTwo, countryCode: providerSelectionCountryCode)
                        if ob == LocalizedStrings.invalidRangeStr {
                            self.view.hideToast()
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidAnim840, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                            
                        }else {
                            breedBtnOutlet.setTitle(firstTwo,for: .normal)
                            idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        }
                        idAnimal = firstTwo + providerSelectionCountryCode +  dropFirstTwo
                        id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                        return
                    }
                } else {
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
            } else {
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
                } else {
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
                        print(beforeRCE)
                        let animalCountE = firstThreeDrop.count - beforeRCE.count
                        print(animalCountE)
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
                                    print(idAnimal)
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
                        }else {
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
                        return
                    }}
                
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
                                        print(idAnimal)
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
                        return
                    }}else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }
            }
        }
    }
    
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
                            id17displaySireDam(animalId: idAnimal, borderRed: false, tag: tag)
                            return
                        } else {
                            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                            id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                            return
                        }
                    } else {
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        return
                    }}
                
            } else {
                
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
                    } else {
                        self.view.hideToast()
                        id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                        return
                    }
                    
                }else {
                    self.view.hideToast()
                    id17displaySireDam(animalId: idAnimal, borderRed: true, tag: tag)
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidChileanId, comment: ""), duration: 2, position: .top)
                    return
                }
            }
        }
    }
    
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
        farmIdTextField.endEditing(true)
    }
    
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
    
    func contiuneValidation() {
        if scanAnimalTagText.tag == 1{
            if scanAnimalTagText.text == ""  {
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                    
                } else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
            }
        } else {
            if scanAnimalTagText.text == ""  {
                if scanAnimalTagText.text!.count == 0 {
                    officalTagView.layer.borderColor = UIColor.red.cgColor
                } else {
                    officalTagView.layer.borderColor = UIColor.gray.cgColor
                    scanAnimalTagText.textColor = UIColor.black
                }
            }
        }
    }
}
