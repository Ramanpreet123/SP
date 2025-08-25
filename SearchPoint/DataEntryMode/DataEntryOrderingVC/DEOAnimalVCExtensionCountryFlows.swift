//
//  DEOAnimalVCExtensionCountryFlows.swift
//  SearchPoint
//
//  Created by Mobile Programming on 25/02/24.
//

import Foundation
import UIKit

// MARK: - COUNTRY FLOWS EXTENSION
extension DataEntryOrderingAnimalVC {
    
    // MARK: - AUSTRALIA FLOW
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
    
    // MARK: - ARGENTINA FLOW
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
            
            if removeSeven.isInt {
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
                        let beforeRCE = String(firstThreeDrop[..<indexRCE!])
                        let animalCountE = firstThreeDrop.count - beforeRCE.count
                        let dropLastEl = String(firstThreeDrop.dropFirst(beforeRCE.count))
                        let dropFirstVale = String(beforeRCE.dropLast(3))
                        
                        if dropLastEl.isInt && (dropFirstVale.isInt || dropFirstVale.count == 0 ){
                            
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
                        }
                        else {
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
                            let beforeE = String(firstThreeDrop[..<indexE!])
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt || dropElast.count == 0) && (dropLastEl.isInt || dropLastEl.count == 0) {
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
                            }
                            else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                        
                    }}
                
                if idAnimal.contains("U"){
                    if firstThreeDrop.count > 7 {
                        let indexE = firstThreeDrop.range(of: "U", options: .forcedOrdering)?.upperBound
                        if indexE != nil{
                            let beforeE = String(firstThreeDrop[..<indexE!])
                            let dropElast = String(beforeE.dropLast())
                            let animalCountE = firstThreeDrop.count - beforeE.count
                            let dropLastEl = String(firstThreeDrop.dropFirst(beforeE.count))
                            
                            if (dropElast.isInt || dropElast.count == 0) && (dropLastEl.isInt || dropLastEl.count == 0) {
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
                                    }
                                    else {
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
                            }
                            else {
                                self.view.hideToast()
                                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                                id17display(animalId: idAnimal, borderRed: true)
                                return
                            }
                        }
                    }
                    else {
                        self.view.hideToast()
                        self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                        id17display(animalId: idAnimal, borderRed: true)
                    }
                }
                else {
                    self.view.hideToast()
                    self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidArgentinaId, comment: ""), duration: 2, position: .top)
                    id17display(animalId: idAnimal, borderRed: true)
                    
                }
            }
        }
    }
    
    // MARK: - CHILI FLOW
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
            
            if removeSeven.isInt {
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
                        } else {
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
                breedBtnOutlet.setTitle(breedCode.uppercased(), for: .normal)
                id17display(animalId: idAnimal, borderRed: false)
                
            } else {
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
                if removeSeven.isInt {
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
                        }
                        else {
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
            }
            else {
                id17display(animalId: idAnimal, borderRed: true)
                self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidGenderCode, comment: ""), duration: 2, position: .top)
            }
        }
        else {
            id17display(animalId: idAnimal, borderRed: true)
            self.view.makeToast(NSLocalizedString(LocalizedStrings.invalidCountryCode, comment: ""), duration: 2, position: .top)
        }
    }
    
    // MARK: - UK TAG FLOW
    func ukTagReutn(animalId:String)-> String{
        let idAnimal = animalId.uppercased()
        let stringResult = idAnimal.contains("UK")
        if stringResult {
            let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
            let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
            let dropTwelveElement = test.suffix(12).uppercased()
            borderRedCheck = false
            let totalString = dropTwelveElement
            return totalString
        }
        
        else {
            let stringResultUS = idAnimal.contains("US")
            let stringResult840 = idAnimal.contains(LocalizedStrings.eightFortyCountryCode)
            if stringResultUS && stringResult840 {
                let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
                let test = String(trimmedString.filter{!"\n\t\r.][:".contains($0)})
                if test.count < 15 {
                    return LocalizedStrings.againClick
                    
                } else {
                    guard let range: Range<String.Index> = test.range(of: LocalizedStrings.eightFortyCountryCode) else {
                        return LocalizedStrings.againClick
                        
                    }
                    let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
                    let countt = index + 14
                    if test.count < countt {
                        return LocalizedStrings.againClick
                    }
                    else {
                        let indexGet = test.subString(from: index, to: index + 14)
                        return indexGet
                    }
                }
            } else {
                return LocalizedStrings.againClick
            }
        }
    }
    
    // MARK: - US TAG FLOW
    func usTagReutn(animalId:String)-> String {
        let idAnimal = animalId.uppercased()
        let trimmedString = String(idAnimal.compactMap({ $0.isWhitespace ? nil : $0 }))
        let test = String(trimmedString.filter{!"\n\t\r(),.-[]:}{".contains($0)})
        if test.count > 15 {
            guard let range: Range<String.Index> = test.range(of: LocalizedStrings.eightFortyCountryCode) else {
                return LocalizedStrings.againClick
                
            }
            let index: Int = test.distance(from: test.startIndex, to: range.lowerBound)
            let countt = index + 14
            if test.count < countt {
                return LocalizedStrings.againClick
            }
            else {
                let indexGet = test.subString(from: index, to: index + 14)
                return indexGet
            }
        }
        return LocalizedStrings.againClick
    }
}
