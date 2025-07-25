//
//  MyHerdFilteriPadVCActionMethods.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 04/06/25.
//

import Foundation
import UIKit

// MARK: - IB ACTION METHODS
extension MyHerdFilteriPadVC {
    
    @IBAction func Ascendingaction(_ sender: UIButton) {
        UserDefaults.standard.setValue(true, forKey: keyValue.sortOrder.rawValue)
        ascending.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        descending.layer.backgroundColor = UIColor.white.cgColor
        ascending.setTitleColor(.white, for: .normal)
        descending.setTitleColor(.black, for: .normal)
        ascending.layer.borderWidth = 0.0
        descending.layer.borderWidth = 2.0
    }
    
    @IBAction func Descendingaction(_ sender: UIButton) {
        UserDefaults.standard.setValue(false, forKey: keyValue.sortOrder.rawValue)
        descending.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        ascending.layer.backgroundColor = UIColor.white.cgColor
        descending.setTitleColor(.white, for: .normal)
        ascending.setTitleColor(.black, for: .normal)
        ascending.layer.borderWidth = 2.0
        descending.layer.borderWidth = 0.0
    }
    
    @IBAction func Offlicalidaction(_ sender: UIButton) {
        UserDefaults.standard.setValue(LocalizedStrings.officialCheckId, forKey: keyValue.idSelect.rawValue)
        OfflicalIDbuttonoutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        OfflicalIDbuttonoutlet.layer.borderColor = UIColor.clear.cgColor
        OnfarmIDbuttonoutlet.layer.backgroundColor = UIColor.white.cgColor
        OfflicalIDbuttonoutlet.setTitleColor(.white, for: .normal)
        OnfarmIDbuttonoutlet.setTitleColor(.black, for: .normal)
        OnfarmIDbuttonoutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
    }
    
    @IBAction func onfarmidaction(_ sender: UIButton) {
        UserDefaults.standard.setValue("", forKey: keyValue.idSelect.rawValue)
        OnfarmIDbuttonoutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        OnfarmIDbuttonoutlet.layer.borderColor = UIColor.clear.cgColor
        OfflicalIDbuttonoutlet.layer.backgroundColor = UIColor.white.cgColor
        OnfarmIDbuttonoutlet.setTitleColor(.white, for: .normal)
        OfflicalIDbuttonoutlet.setTitleColor(.black, for: .normal)
        OfflicalIDbuttonoutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
    }
    
    @IBAction func trailIndexaction(_ sender: UIButton) {
        var displayNamesArray = [String]()
        var attributesarray = [String]()
        var fetchTraitObj = [ResultTraitHeader]()
        
        displayModelArray.removeAll()
        if (selectedProductName == LocalizedStrings.clarifideCDCB) && isHerditySelected {
            fetchTraitObj = fetchResultTraitIndex(entityName: Entities.resultTraitHeaderTblEntity, species: marketNameType.Dairy.rawValue, productName: LocalizedStrings.herdity) as! [ResultTraitHeader]
        } else {
            fetchTraitObj = fetchResultTraitIndex(entityName: Entities.resultTraitHeaderTblEntity, species: marketNameType.Dairy.rawValue, productName: selectedProductName) as! [ResultTraitHeader]
        }
        
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i]
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: selectedtabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                if isHerditySelected {
                    if let displayname = objFetch.attributeName {
                        displayModelArray.append(DisplayModel(displayName: objFetch.displayName ?? "", attrubuteName: displayname))
                    }
                } else {
                    if let displayname = objFetch.attributeName, objFetch.productName != LocalizedStrings.herdity {
                        displayModelArray.append(DisplayModel(displayName: objFetch.displayName ?? "", attrubuteName: displayname))
                    }
                }
                self.resultMasterGet.append(objFetch)
            }
        }
        
        dropDown1.direction = .bottom
        dropDown1.anchorView = trailsindexbutton
        dropDown1.bottomOffset = CGPoint(x: 0, y: trailsindexbutton.bounds.height)
        let fliterarray = removeDup1(arr: displayModelArray)
        for i in fliterarray{
            attributesarray.append(i?.attrubuteName ?? "")
            displayNamesArray.append(i?.displayName ?? "")
        }
        dropDown1.dataSource = displayNamesArray
        dropDown1.width = trailsindexbutton.frame.width
        dropDown1.show()
        dropDown1.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal)
            UserDefaults.standard.set(item, forKey: keyValue.traitName.rawValue)
            UserDefaults.standard.set(attributesarray[index], forKey: keyValue.traitValue.rawValue)
            UserDefaults.standard.synchronize()
            self?.traitisselected = true
        }
    }
    
    @IBAction func clearFilterBtnAction(_ sender: Any) {
        isHerditySelected = false
        genderRetain = "F"
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.layer.borderColor = UIColor.clear.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        allBtnOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        maleBtnOutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        providerCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .right)
        self.collectionView(self.providerCollectionView, didSelectItemAt: IndexPath(item: 0, section: 0))
        self.collectionView(self.providerCollectionView, didDeselectItemAt: IndexPath(item: 1, section: 0))
        providerCollectionView.allowsMultipleSelection = false
        let selectIndexBreedCollection = IndexPath(row: 0, section: 0)
        breedCollectionvIEW.selectItem(at: selectIndexBreedCollection, animated: true, scrollPosition: .right)
        self.collectionView(self.breedCollectionvIEW, didSelectItemAt: IndexPath(item: 0, section: 0))
        self.collectionView(self.breedCollectionvIEW, didDeselectItemAt: IndexPath(item: 1, section: 0))
        breedCollectionvIEW.allowsMultipleSelection = false
        providerIndexPath = 0
        breedIndexPath = 0
        UserDefaults.standard.setValue("", forKey: keyValue.todate.rawValue)
        UserDefaults.standard.setValue("", forKey: keyValue.fromdate.rawValue)
        var dateFormatter = DateFormatter()
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        dateToBttn.setTitle(dateFormatter.string(from: Date()), for: .normal)
        let previousMonth = Calendar.current.date(byAdding: .month, value: -15, to: Date())
        dateFromBttn.setTitle(dateFormatter.string(from: previousMonth!), for: .normal)
        dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
        
        let dates = dateFormatter.string(from: previousMonth!)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        fromDate = dateFormatter.date(from: dates)!
        let currentDates = dateFormatter.string(from: Date())
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        ToDate = dateFormatter.date(from: currentDates)!
        UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
        UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: "n")
        trailsindexbutton.setTitle(ButtonTitles.selectIndexText, for: .normal)
        traitisselected = false
        UserDefaults.standard.setValue(true, forKey: keyValue.sortOrder.rawValue)
        ascending.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        descending.layer.backgroundColor = UIColor.white.cgColor
        ascending.setTitleColor(.white, for: .normal)
        descending.setTitleColor(.black, for: .normal)
        OnfarmIDbuttonoutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        OfflicalIDbuttonoutlet.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        OnfarmIDbuttonoutlet.setTitleColor(.white, for: .normal)
        OfflicalIDbuttonoutlet.setTitleColor(.black, for: .normal)
        traitisselected = false
        allBtnOutlet.backgroundColor = UIColor.white
        OfflicalIDbuttonoutlet.backgroundColor = UIColor.white
        maleBtnOutlet.backgroundColor = UIColor.white
    }
    
    @IBAction func CancleBtnFilterScreenAction(_ sender: Any){
        let fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID))
        if fetchFilterData.count == 0{
            self.dismiss(animated: false){
                UserDefaults.standard.removeObject(forKey: keyValue.isHerditySelected.rawValue)
                self.delegate?.dissmissbackcall()
            }
        }
        else{
            self.delegate?.CancelPressed()
            self.dismiss(animated: false)
        }
    }
    
    @IBAction func doneBtnFilterScreenAction(_ sender: Any) {
        DispatchQueue.main.async {
            self.dismiss(animated: true)
        }
        deleteRecordFromDatabase(entityName: Entities.resultMasterPageNumberTblEntity)
        deleteDataWithMyHerdResult(customerId: custmerID, searchFound: false)
        let animalArray = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity, customerId: custmerID, searchFound:  true) as! [ResultMyHerdData]
        if animalArray.count == 0 {
            deleteDataWithmyPagetrait(customerId: custmerID)
            deleteDataWithCustomerId(entityName:Entities.resultGroupAnimalsTblEntity, customerId: custmerID )
        } else {
            let animalGroupArray =  fetchGroupAnimalbyCustomerID(entityName: Entities.resultGroupAnimalsTblEntity, customerId: custmerID) as! [ResultGroupsAnimals]
            if animalGroupArray.count>0 {
                for group in animalGroupArray {
                    let filterAnimal = animalArray.filter{$0.onFarmID == group.onFarmId && $0.officialID == group.officalId}
                    if filterAnimal.count == 0{
                        let animalData = group
                        let farmId = animalData.onFarmId ?? ""
                        let officialId = animalData.officalId ?? ""
                        deleteDataMyGroupAnimalwith(customerId: custmerID, farmID: farmId, officialId: officialId)
                    }
                }
            }
        }
        
        delegate?.tablereload()
        myHerdArray1   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:Int64(Int(custmerID))) as! [ResultMyHerdData]
        
        if let breedName = UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String {
            let breeds = breedName.components(separatedBy: ",")
            let containsAll = breeds.allSatisfy(breedArray.contains)
            if !containsAll {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectOneBreed, comment: ""))
                return
            }
        }
        
        if !(traitisselected ?? false){
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectIndex, comment: ""))
        } else if (UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String) == "" {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectOneBreed, comment: ""))
        }
        else{
          UserDefaults.standard.setValue("old", forKey: "checkdate")
            let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
            let dateToNw = dateToBttn.titleLabel?.text ?? ""
            let dateFrom = dateFromBttn.titleLabel?.text ?? ""
            let dateTo = dateToBttn.titleLabel?.text ?? ""
            let dateCombine = dateFrom + " - " + dateTo
            delegate?.dateInfoUpdate(date: dateCombine)
            let dateFormatter = DateFormatter()
            dateFormatter.locale =  NSLocale(localeIdentifier: "nl_NL" ) as Locale
            
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            fromDaten = dateFormatter.date(from: dateFromNw)!
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            let resultStringfrom = dateFormatter.string(from: fromDaten)
            UserDefaults.standard.setValue(resultStringfrom, forKey: keyValue.fromdatefromate.rawValue)
            
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                dateFormatter.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                dateFormatter.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            ToDaten = dateFormatter.date(from: dateToNw)!
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            dateFormatter.locale = Locale.current
            let resultStringto = dateFormatter.string(from: ToDaten)
            UserDefaults.standard.setValue(resultStringto, forKey: keyValue.todatefromate.rawValue)
            let isLessThan = fromDaten.isSmallerThan(ToDaten)
            
            if isLessThan == true {
                let todate = UserDefaults.standard.value(forKey: keyValue.todatefromate.rawValue) as? String ?? ""
                let fromdate = UserDefaults.standard.value(forKey: keyValue.fromdatefromate.rawValue) as? String ?? ""
                var resultbreedID = ""
                if  let breedID = UserDefaults.standard.value(forKey: keyValue.resultBreedID.rawValue) as? String {
                    resultbreedID = breedID
                }
               
                genderRetain = UserDefaults.standard.value(forKey: keyValue.savesex.rawValue) as? String ?? ""
                let breedindex = UserDefaults.standard.integer(forKey: keyValue.breedIndex.rawValue)
                let headerstring = UserDefaults.standard.value(forKey: keyValue.headerValue.rawValue) as? String ?? ""
                let traitstring = UserDefaults.standard.value(forKey: keyValue.traitValue.rawValue) as? String ?? ""
                let traidsave = UserDefaults.standard.value(forKey: keyValue.traitName.rawValue) as? String ?? ""
                delegate?.genderInfoUpdate(sex: genderRetain, providerIndexPath: providerIndexPath, breedIndexPath: breedindex, fromdatevalue: dateFromNw ,todatevalue: dateToNw,header: headerstring ,trait: traitstring )
                let fetchFilterData = fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: isHerditySelected,productID: selectedProviderID)
                let checkid = UserDefaults.standard.value(forKey: keyValue.sortOrder.rawValue) as? Bool ?? false
                let idselection = UserDefaults.standard.value(forKey: keyValue.idSelect.rawValue) as? String ?? ""
                
                if fetchFilterData.count > 0 {
                    updatefilterSettingData(entity: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID), breedIndex : breedIndexPath, productIndex : providerIndexPath ,sex: genderRetain,dateto: todate, datefrom: fromdate, breedName:UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String ?? breedArray[0],trait:traitstring,header:headerstring,productname:selectedProviderName,breedId: resultbreedID,traidsave: traidsave,sortorder: checkid,idselection: idselection, isHerditySelected: isHerditySelected,productId: selectedProviderID)
                }
                else {
                    savefilterSettingData(entity: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID), breedIndex : breedIndexPath, productIndex : providerIndexPath ,sex: genderRetain,dateto: todate,datefrom: fromdate, breedName:UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String ?? breedArray[0],trait:traitstring,header:headerstring,productname:selectedProviderName,breedId: resultbreedID,traidsave: traidsave,sortorder: checkid,idselection: idselection, isHerditySelected: isHerditySelected, productID: selectedProviderID)
                }
                if selectedProviderName != keyValue.USDairyProducts.rawValue{
                    isHerditySelected = false
                }
                delegate?.breedInfoUpdate(index: breedindex)
                self.delegate?.breednameset()
//                showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncDataLabel, comment: ""), and: "")
//                group.enter()
//                saveResulyByPageViewModel = ResulyByPageViewModeliPad(callBack: resultcallbackaction)
//                saveResulyByPageViewModel?.myfliter = self
//                saveResulyByPageViewModel?.callResultByPageAnimalApi()
            }
            else{
                UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
            }
        }
    }
    
    @IBAction func fromDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  0
        doFromDatePicker()
    }
    
    @IBAction func toDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calendarViewBkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        BttnTag =  1
        doFromDatePicker()
    }
    
    @IBAction func maleBtnAction(_ sender: Any){
        genderRetain = "M"
        UserDefaults.standard.setValue("M", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.white, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.borderWidth = 2.0
        maleBtnOutlet.layer.borderWidth = 0.0
    }
    
    @IBAction func femaleBtnAction(_ sender: Any) {
        genderRetain = "F"
        UserDefaults.standard.setValue("F", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        allBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.white, for: .normal)
        allBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.layer.borderWidth = 0.0
        allBtnOutlet.layer.borderWidth = 2.0
        maleBtnOutlet.layer.borderWidth = 2.0
    }
    
    @IBAction func allBtnACTION(_ sender: Any) {
        genderRetain = ButtonTitles.allText
        UserDefaults.standard.setValue("A", forKey: keyValue.savesex.rawValue)
        maleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        femaleBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        allBtnOutlet.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
        maleBtnOutlet.setTitleColor(.black, for: .normal)
        femaleBtnOutlet.setTitleColor(.black, for: .normal)
        allBtnOutlet.setTitleColor(.white, for: .normal)
        femaleBtnOutlet.layer.borderWidth = 2.0
        allBtnOutlet.layer.borderWidth = 0.0
        maleBtnOutlet.layer.borderWidth = 2.0
    }
    
    @IBAction func btnIsHerdityClicked(_ sender: Any) {
        isHerditySelected = !isHerditySelected
        updateProviderSelection()
    }
    
    @IBAction func herdityNoAction(_ sender: Any) {
        isHerditySelected = false
        updateProviderSelection()
    }
    
    @IBAction func herdityYesAction(_ sender: Any) {
        isHerditySelected = true
        updateProviderSelection()
    }
}
