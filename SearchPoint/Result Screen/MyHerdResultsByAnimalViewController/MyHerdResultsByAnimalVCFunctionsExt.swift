//
//  MyHerdResultsByAnimalVCFunctions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 28/02/24.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import IQKeyboardToolbar

//MARK: GESTURE RECOGNIZER, NAVIGATION AND OBJC SELECTOR METHODS
extension MyHerdResultsByAnimalViewController {
    
    //MARK: GESTURE RECOGNIZER
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    //MARK: NAVIGATION METHODS
    func navigatetoProviderSelection(showCDCB:Bool,showDatagene:Bool,showHerdity:Bool, showViewCount : Int){
        let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.chooseProviderVC) as! ChooseProviderVC
        vc.modalPresentationStyle = .overFullScreen
        vc.isCDCBFound = showCDCB
        vc.isDategeneFound = showDatagene
        vc.isHerdityFound = showHerdity
        vc.selectedValue = showViewCount
        vc.delegate = self
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    func navigateToIndivisualController(productNameStr:String){
        if !tableCellSelected {
            let dataArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
            if searchByEarTag {
                searchHerdArray = dataArray.filter{$0.onFarmID == searchTextField.text}
            } else {
                searchHerdArray = dataArray.filter{$0.officialID == searchTextField.text}
            }
            
            if searchHerdArray.count != 0{
                UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
                let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.individualAnimalResultControllerVC) as? IndividualAnimalResultController
                vc?.checkCOntroller = LocalizedStrings.resultController
                vc?.backScreenClickIndex = 0
                vc?.productName = productNameStr
                vc?.searchbyAnimal = true
                vc?.getMyHerdArray = searchHerdArray
                let offlicalidmyherd = searchHerdArray[0].officialID
                let onfarmid = searchHerdArray[0].onFarmID
                UserDefaults.standard.set(offlicalidmyherd, forKey: keyValue.myHerdOfficalid.rawValue)
                UserDefaults.standard.set(onfarmid, forKey: keyValue.myHerdOnfarmId.rawValue)
                UserDefaults.standard.set(searchHerdArray[0].breedID, forKey: keyValue.selectedAnimalBreedID.rawValue)
                let fetchObject = fetchAnimalAssignExistIntable(entityName: Entities.resultGroupAnimalsTblEntity,customerId: customerId ?? 0,animalId: searchHerdArray[0].animalID ?? "") as! [ResultGroupsAnimals]
                var filterGroup = [ResultGroupsAnimals]()
                if fetchObject.count != 0 {
                    let animalGroup = searchHerdArray[0].status
                    if animalGroup == LocalizedStrings.dollerStatus
                    {
                        filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.dollarGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
                    } else {
                        filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.barnGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
                    }
                    if filterGroup.count > 0{
                        let resultGrpObject = filterGroup[0]
                        let groupStatusId = resultGrpObject.groupStatusId
                        let groupTypeId = resultGrpObject.groupTypeId
                        let groupname = resultGrpObject.groupName
                        
                        UserDefaults.standard.setValue(groupname, forKey: keyValue.groupName.rawValue)
                        
                        if groupStatusId == 1 && groupTypeId == 1 {
                            UserDefaults.standard.setValue(ImageNames.barnActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                            
                        } else if groupStatusId == 1 && groupTypeId == 0 {
                            UserDefaults.standard.setValue(ImageNames.dollarActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                            
                        } else {
                            UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                        }
                    }
                    else{
                        UserDefaults.standard.setValue("NA", forKey: keyValue.groupName.rawValue)
                        UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                    }
                }
                self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        else {
            UserDefaults.standard.removeObject(forKey: keyValue.scrollIncrement.rawValue)
            let vc = UIStoryboard.init(name: StoryboardType.MainStoryboard, bundle: Bundle.main).instantiateViewController(withIdentifier: ClassIdentifiers.individualAnimalResultControllerVC) as? IndividualAnimalResultController
            vc?.checkCOntroller = LocalizedStrings.resultController
            vc?.backScreenClickIndex = selectedIndex
            vc?.getMyHerdArray = myHerdArray
            vc?.productName = productNameStr
            vc?.searchbyAnimal = true
            let offlicalidmyherd = selectedMyHerdArray.officialID
            let onfarmid = selectedMyHerdArray.onFarmID
            UserDefaults.standard.set(selectedMyHerdArray.breedID, forKey: keyValue.selectedAnimalBreedID.rawValue)
            UserDefaults.standard.set(offlicalidmyherd, forKey: keyValue.myHerdOfficalid.rawValue)
            UserDefaults.standard.set(onfarmid, forKey: keyValue.myHerdOnfarmId.rawValue)
            
            let fetchObject = fetchAnimalAssignExistIntable(entityName: Entities.resultGroupAnimalsTblEntity,customerId: customerId ?? 0,animalId: selectedMyHerdArray.animalID ?? "") as! [ResultGroupsAnimals]
            var filterGroup = [ResultGroupsAnimals]()
            if fetchObject.count != 0 {
                
                let animalGroup = selectedMyHerdArray.status
                if animalGroup == LocalizedStrings.dollerStatus
                {
                    filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.dollarGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
                } else {
                    filterGroup =  fetchObject.filter{$0.groupTypeName == LocalizedStrings.barnGroupType && $0.groupStatus == LocalizedStrings.activeGroupType}
                }
                if filterGroup.count > 0{
                    let resultGrpObject = filterGroup[0]
                    let groupStatusId = resultGrpObject.groupStatusId
                    let groupTypeId = resultGrpObject.groupTypeId
                    let groupname = resultGrpObject.groupName
                    
                    UserDefaults.standard.setValue(groupname, forKey: keyValue.groupName.rawValue)
                    
                    if groupStatusId == 1 && groupTypeId == 1 {
                        UserDefaults.standard.setValue(ImageNames.barnActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                    }
                    else if groupStatusId == 1 && groupTypeId == 0 {
                        UserDefaults.standard.setValue(ImageNames.dollarActiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                    }
                    else {
                        UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
                    }
                }
            }
            else{
                UserDefaults.standard.setValue("NA", forKey: keyValue.groupName.rawValue)
                UserDefaults.standard.setValue(ImageNames.threeDotsInactiveImg, forKey: keyValue.radioButtonCheck.rawValue)
            }
            tableCellSelected = false
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func navigateToAnotherVc143(){
        group.leave()
        hideIndicator()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.global(qos: .background).sync {
            self.showIndicator(self.view, withTitle: NSLocalizedString(AlertMessagesStrings.syncResultsData, comment: ""), and: "")
            self.saveAnimalGroupUpdatedViewModel = AnimalGroupsForCustomerUpdateVM( callBack: self.navigateTosaveanimal)
            self.saveAnimalGroupUpdatedViewModel?.callAnimalGroupsForCustomerUpdateApi()
        }
    }
    
    func navigateTosaveanimal(){
        datasource.removeAll()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        
        if myHerdArray.count != 0 {
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
                
            }
        }
        DispatchQueue.main.async { [self] in
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            self.hideIndicator()
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
            self.view.isUserInteractionEnabled = true
            self.tblView.reloadData()
        }
    }
    
    func navigateToMyherfFilterControler(){
        if Connectivity.isConnectedToInternet(){
            let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdFilterControllerVC) as! MyHerdFilterController
            vc.delegate = self
            if UserDefaults.standard.value(forKey: keyValue.checkFilter.rawValue) == nil
            {
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
            else{
                let fetchFilterData = fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0))
                for items in fetchFilterData
                {
                    let newfetch = items as? ResultFIlterDataSave
                    let headerstring = newfetch?.header ?? ""
                    let traidstting = newfetch?.trait ?? ""
                    UserDefaults.standard.set(headerstring, forKey: keyValue.headerValue.rawValue)
                    UserDefaults.standard.set(traidstting, forKey: keyValue.traitValue.rawValue)
                    UserDefaults.standard.synchronize()
                }
                self.navigationController?.present(vc, animated: false, completion: nil)
            }
        }
        else
        {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("", comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.connectToInternetStr, comment: ""))
            return
        }
    }
    
    //MARK: OBJC SELECTOR METHODS
    @objc func methodOfReceivedNotification(notification: Notification){
        if value == 0{
            UserDefaults.standard.set("false", forKey: keyValue.firstLogin.rawValue)
            let storyBoard: UIStoryboard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: ClassIdentifiers.loginViewController) as! LoginViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
            self.hideIndicator()
            value = value + 1
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.getNotesandPhotos(tag: sender?.view?.tag ?? 0)
    }
    
    @objc func searchButtonAction(_ sender: IQBarButtonItem){
        if searchTextField.text == ""{
            CommonClass.showAlertMessage(self, titleStr: "", messageStr: error_blankfield)
        }
        else if !searchByEarTag && searchTextField.text?.count ?? 0 < 17{
            CommonClass.showAlertMessage(self, titleStr: "", messageStr: error_officialID_countCheck)
        }
        else {
          autoSuggestTableView.isHidden = true
        //  searchForAutoAnimal(seachText: searchTextField.text ?? "")
            callResultbyAnimalApi()
        }
    }
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func checkForReachability(notification:Notification){
        let del =  UIApplication.shared.delegate as? AppDelegate
        self.statusText?.text = NSLocalizedString((del?.status)!, comment: "")
        if statusText?.text == ButtonTitles.connectedText.localized {
            self.connectedBtnOutlet.isHidden = true
            self.connectionImg.image = UIImage(named: ImageNames.statusOnlineSign)
        }
        else {
            self.connectedBtnOutlet.isHidden = false
            self.connectionImg.image = UIImage(named: ImageNames.statusOfflineImg)
        }
    }
}

//MARK: FILTER INFO UPDATE DELEGATE
extension MyHerdResultsByAnimalViewController :filterInfoUpdate{
    func CancelPressed() {
        let resultFIlterDataSave : [ResultFIlterDataSave] =  fetchResultFilterData(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(customerId ?? 0)) as! [ResultFIlterDataSave]
        if resultFIlterDataSave.count > 0{
            UserDefaults.standard.set(resultFIlterDataSave.last?.productName,forKey: keyValue.resultproviderID.rawValue)
            productName = resultFIlterDataSave.last?.productName ?? ""
            providerID = Int(resultFIlterDataSave.last?.productID ?? 0)
            
            if  resultFIlterDataSave.last?.sex == "F" {
                sexFilterBtnOutlet .setTitle(ButtonTitles.femaleText.localized, for: .normal)
            }
            else if resultFIlterDataSave.last?.sex == "M"{
                sexFilterBtnOutlet .setTitle(ButtonTitles.maleText.localized, for: .normal)
            }
            else if resultFIlterDataSave.last?.sex == "A"{
                sexFilterBtnOutlet .setTitle(ButtonTitles.allText.localized, for: .normal)
            }
            
            UserDefaults.standard.set(resultFIlterDataSave.last?.isHeriditySelected ?? false, forKey: keyValue.isHerditySelected.rawValue)
            UserDefaults.standard.set(resultFIlterDataSave.last?.idselection, forKey: keyValue.idSelect.rawValue)
            UserDefaults.standard.set(resultFIlterDataSave.last?.sortorder, forKey: keyValue.sortOrder.rawValue)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatters.yyyyMMddTHHmmssFormat
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.locale = Locale.current
            
            if resultFIlterDataSave.last?.datefrom != ""{
                fromDaten = dateFormatter.date(from: resultFIlterDataSave.last?.datefrom ?? "")!
            }
            
            if resultFIlterDataSave.last?.dateto != ""{
                ToDaten = dateFormatter.date(from: resultFIlterDataSave.last?.dateto ?? "")!

            }
            
            let calendar = Calendar.current
            let fmt = DateFormatter()
            if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                fmt.dateFormat = DateFormatters.MMddyyyyFormat
            } else {
                fmt.dateFormat = DateFormatters.ddMMyyyyFormat
            }
            
            fromdatecheck = fmt.string(from: fromDaten)
            todatecheck = fmt.string(from: ToDaten)
            
            var alldates = [String]()
            while fromDaten <= ToDaten {
                
                alldates.append(fmt.string(from: fromDaten))
                fromDaten = calendar.date(byAdding: .day, value: 1, to: fromDaten)!
            }
            if (resultFIlterDataSave.last?.breedName?.components(separatedBy: ",").count ?? 0) > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.recentlySearchedText.localized, for: .normal)
            }else{
                breedFilterBtnOutlet.setTitle(resultFIlterDataSave.last?.breedName, for: .normal)
            }
        }
    }
    
    func Reloaddata() {
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        self.hideIndicator()
        myHerdArray   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        tblView.isHidden = false
        if myHerdArray.count > 20 {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: 20)
        }
        else {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        }
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
            
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
        checkSelectedCell()
    }
    
    func dateInfoUpdate(date: String) {
        dateFilterBtnOutlet.setTitle(date, for: .normal)
    }
    
    func breedInfoUpdate(index: Int) {
        customerId = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        let fetchBreeds = fetchResultFilterDataWithProductid(entityName: Entities.resultFilterDataTblEntity, customerId: Int(customerId ?? 0), providerid: Int64(providerID))
        
        if fetchBreeds.count != 0 {
            breedArray.removeAll()
            breedIDArray.removeAll()
            for i in 0 ..< fetchBreeds.count{
                
                let obj = fetchBreeds[i] as! ResultFilterData
                let getProductName = obj.breedName ?? ""
                let getbreedid = obj.breedId ?? ""
                breedArray.append(getProductName)
                breedIDArray.append(getbreedid)
            }
            breedArray = breedArray.removeDuplicates()
            breedIDArray = breedIDArray.removeDuplicates()
            breedName = breedArray[index]
            breedID = breedIDArray[index]
            
            let isHerditySelected = UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue)
            if isHerditySelected  && providerID == 1{
                if let selectedBreedIds = UserDefaults.standard.value(forKey: keyValue.resultBreedID.rawValue) as? String {
                    var breeds = selectedBreedIds.components(separatedBy: ",")
                    let selectedBreedId = breedIDArray[index]
                    if let index = breeds.firstIndex(of: selectedBreedId) {
                        breeds.remove(at: index)
                    } else {
                        breeds.append(selectedBreedId)
                    }
                    breedID = breeds.joined(separator: ",")
                }
                
                if let selectedBreedNames = UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String {
                    var breeds = selectedBreedNames.components(separatedBy: ",")
                    let output = breedArray.filter{ breeds.contains($0) }
                    breeds = output
                    
                    let selectedBreedName = breedArray[index]
                    if let index = breeds.firstIndex(of: selectedBreedName) {
                        breeds.remove(at: index)
                    } else {
                        breeds.append(selectedBreedName)
                    }
                    breedName = breeds.joined(separator: ",")
                }
            }
            
            UserDefaults.standard.set(breedID, forKey: keyValue.resultBreedID.rawValue)
            UserDefaults.standard.set(breedName, forKey: keyValue.breedName.rawValue)
            let resultbreedID = UserDefaults.standard.value(forKey: keyValue.resultBreedID.rawValue) as? String ?? ""
            let arrayBreedID = resultbreedID.components(separatedBy: ",")
            if arrayBreedID.count > 1{
                breedFilterBtnOutlet.setTitle(ButtonTitles.recentlySearchedText, for: .normal)
            }else{
                breedFilterBtnOutlet.setTitle(breedName, for: .normal)
            }
        }
        
        if breedFilterBtnOutlet.titleLabel?.text == nil || breedFilterBtnOutlet.titleLabel?.text == nil {
            tblView.reloadData()
        }
        else {
            let sex = sexname
            UserDefaults.standard.set(sex, forKey: keyValue.sexvalue.rawValue)
            
        }
    }
    
    func providerInfoUpdate(index: Int) {
        let fetchObj = fetchResultFilterData(entityName: Entities.resultFilterDataTblEntity,customerId: Int(customerId ?? 0))
        if fetchObj.count != 0 {
            for i in 0 ..< fetchObj.count{
                let obj = fetchObj[i] as! ResultFilterData
                let getProductName = obj.providerName ?? ""
                let providerID = obj.providerID
                productArray.append(getProductName)
                providerarray.append(Int(providerID))
            }
            productArray = productArray.removeDuplicates()
            providerarray = providerarray.removeDuplicates()
            productName = productArray[index]
            providerID = providerarray[index]
        }
    }
    
    func genderInfoUpdate(sex:String, providerIndexPath: Int, breedIndexPath: Int, fromdatevalue : String , todatevalue : String,header: String ,trait: String){
        
        providerInfoUpdate(index: providerIndexPath)
        UserDefaults.standard.set(providerarray[providerIndexPath],forKey: keyValue.resultproviderID.rawValue)
        if  sex == "F" {
            sexFilterBtnOutlet .setTitle(ButtonTitles.femaleText.localized, for: .normal)
        }
        else if sex == "M"{
            sexFilterBtnOutlet .setTitle(ButtonTitles.maleText.localized, for: .normal)
        }
        else if sex == "A"{
            sexFilterBtnOutlet .setTitle(ButtonTitles.allText.localized, for: .normal)
        }
        
        let dateFormatter = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            dateFormatter.dateFormat = DateFormatters.MMddyyyy0000Format
        } else {
            dateFormatter.dateFormat = DateFormatters.ddMMyyyy0000Format
        }
        if fromdatevalue != ""{
            fromDaten = dateFormatter.date(from: fromdatevalue)!
        }
        
        if todatevalue != ""{
            ToDaten = dateFormatter.date(from: todatevalue)!
        }
        
        let calendar = Calendar.current
        
        let fmt = DateFormatter()
        if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
            fmt.dateFormat = DateFormatters.MMddyyyyFormat
        } else {
            fmt.dateFormat = DateFormatters.ddMMyyyyFormat
        }
        
        fromdatecheck = fmt.string(from: fromDaten)
        todatecheck = fmt.string(from: ToDaten)
        var alldates = [String]()
        
        while fromDaten <= ToDaten {
            alldates.append(fmt.string(from: fromDaten))
            fromDaten = calendar.date(byAdding: .day, value: 1, to: fromDaten)!
        }
        UserDefaults.standard.setValue(todatecheck, forKey: keyValue.todate.rawValue)
        UserDefaults.standard.setValue(fromdatecheck, forKey: keyValue.fromdate.rawValue)
        UserDefaults.standard.setValue(sex, forKey: keyValue.savesex.rawValue)
        
        if myHerdArray.count > 20 {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: 20)
        } else {
            totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        }
        
        if myHerdArray.count == 0{
            message.isHidden = false
            tblView.isHidden = true
            headerview.isHidden = true
        }
        if myHerdArray.count != 0 {
            message.isHidden = true
            tblView.isHidden = false
            headerview.isHidden = false
            datasource.removeAll()
            for i in 0...myHerdArray.count - 1{
                let ab = callSwipeStruct(name: [myHerdArray[i]], color: .white, image: UIImage(named:ImageNames.threeDotsInactiveImg)!, backgroundGroup: UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0))
                datasource.append(ab)
            }
        }
        UserDefaults.standard.removeObject(forKey: keyValue.fromManagement.rawValue)
        tblView.reloadData()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func loadMoreData() {
        myHerdArray.append(contentsOf: myHerdArray)
        self.myHerdArray = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:customerId ?? 0,searchFound: true) as! [ResultMyHerdData]
        totalAnimalCount.text = ButtonTitles.totalAnimalsText.localized(with: myHerdArray.count)
        self.tblView.reloadData()
    }
}

//MARK: TEXTFIELD DELEGATE
extension MyHerdResultsByAnimalViewController : UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
    let currentString: NSString = searchTextField.text! as NSString
    currentString.replacingCharacters(in: range, with: string)
    if !searchByEarTag {
      if let char = string.cString(using: String.Encoding.utf8) {
        let isBackSpace1 = strcmp(char, "\\b")
        if (isBackSpace1 == -92) {
          return true
        }
      }
      
      let check  = ACCEPTABLE_CHARACTERS.contains(string)
      if check == false {
        return false
      }
      let maxLength = 17
      let currentString = (textField.text ?? "") as NSString
      let newString = currentString.replacingCharacters(in: range, with: string)
      return newString.count <= maxLength
    }
    
    guard !string.isEmpty else {
      return true
    }
    let newString: String =
    (currentString.replacingCharacters(in: range, with: string) as NSString) as String
    self.searchForAutoAnimal(seachText: newString)
   
    
    return true
  }
    
    func textFieldDidEndEditing(textField: UITextField){
        if searchTextField.tag == 1{
            self.callResultbyAnimalApi()
        } else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(error_blankfield, comment: ""))
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            CommonClass.showAlertMessage(self, titleStr: "", messageStr: error_blankfield)
            return false
        }
        
        else if !searchByEarTag && searchTextField.text?.count ?? 0 < 17{
            CommonClass.showAlertMessage(self, titleStr: "", messageStr: error_officialID_countCheck)
            return false
        }
        self.autoSuggestTableView.isHidden = true
        self.callResultbyAnimalApi()
        return true
    }
    
    func shouldEnableReturnKey(textCount:Int) -> Bool {
        if let text = searchTextField.text, text.count >= textCount {
            searchTextField.enablesReturnKeyAutomatically = true
            return true
        } else {
            searchTextField.enablesReturnKeyAutomatically = false
            return false
        }
    }
}
