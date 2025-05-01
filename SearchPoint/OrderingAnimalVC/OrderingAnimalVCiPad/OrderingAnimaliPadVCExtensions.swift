//
//  OrderingAnimaliPadVCExtensions.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 18/01/25.
//

import Foundation
import UIKit
import CoreBluetooth
import Alamofire

//MARK: SAVE SAMPLE NAME AND ID
extension OrderingAnimalipadVC {
    func saveSampleNameandID (sampleNameStr: String, sampleID :Int) {
        if sampleID == 0 {
            let filterTissueArray  = tissueArr.filter{($0 as! GetSampleTbl).sampleName == sampleNameStr}
            if filterTissueArray.count > 0 {
                self.sampleID = Int((filterTissueArray[0] as! GetSampleTbl).sampleId)
                self.sampleName = (filterTissueArray[0] as! GetSampleTbl).sampleName ?? ""
            }
        } else {
            let filterTissueArray  = tissueArr.filter{($0 as! GetSampleTbl).sampleId == sampleID}
            if filterTissueArray.count > 0 {
                self.sampleID = Int((filterTissueArray[0] as! GetSampleTbl).sampleId)
                self.sampleName = (filterTissueArray[0] as! GetSampleTbl).sampleName ?? ""
            }
        }
    }
}

//MARK: SCANNED OCR PROTOCOL
extension OrderingAnimalipadVC: scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String) {
        if farmIdTextField.tag == 0 {
            farmIdTextField.text = scannedResult
            farmIdTextField.becomeFirstResponder()
            self.farmIdView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        } else {
            scanAnimalTagText.text = scannedResult
            scanAnimalTagText.becomeFirstResponder()
            self.officalTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor

        }
        textFieldBackroungWhite()
    }
}

//MARK: QR SCANNER PROTOCOL
extension OrderingAnimalipadVC: QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String) {
        let currentOfficialId = farmIdTextField.text
        if currentOfficialId == qrValue {
            barcodeView.layer.borderColor = UIColor.red.cgColor
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.sampleBarcodeNotSame, comment: ""))
        } else {
            scanBarcodeText.text = qrValue
        }
    }
}

//MARK: ANIMAL MERGED PROTOCOL
extension OrderingAnimalipadVC : AnimalMergeProtocol{
    func refreshUI() {
        let animalCount = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: self.userId,orderId:self.orderId,orderStatus:"false", providerId: self.pvid)
        self.notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0 {
            self.notificationLblCount.isHidden = true
            self.countLbl.isHidden = true
          //  self.crossedBtnOutlet.isHidden = true
            self.mergeListBtnOulet.isHidden = true
            self.cartView.isHidden = true
            self.mergeListView.isHidden = true

            
        } else {
            self.notificationLblCount.isHidden = false
            self.countLbl.isHidden = false
        //    self.crossedBtnOutlet.isHidden = false
            self.mergeListBtnOulet.isHidden = false
            self.cartView.isHidden = false
            self.mergeListView.isHidden = false

        }
        
        let fetchObj = fetchListNameToCustId(entityName: Entities.mergeDataEntryListTblEntity,customerId:custmerId ,providerId :pvid)
        if fetchObj.count != 0 {
            let objectFetch = fetchObj.object(at: 0) as? MergeDataEntryList
            let obj = objectFetch?.listName
            let fetchAllMergeDta = fetchMergeDataPvidCustomer(entityName: Entities.mergeDataEntryListTblEntity,providerId: Int64(self.pvid),customerId:Int64(self.custmerId )).count - 1
            
            if fetchAllMergeDta == 0 {
                let fetchNameDisplay = String(obj ?? "")
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
                
            } else {
                let fetchNameDisplay = String(obj ?? "") + " + " + String(fetchAllMergeDta)
                let attributeString = NSMutableAttributedString(string: fetchNameDisplay, attributes: self.attrs)
                mergeListBtnOulet.setAttributedTitle(attributeString, for: .normal)
            }
        } else {
            self.mergeListView.isHidden = true
            mergeListBtnOulet.isHidden = true
          //  crossedBtnOutlet.isHidden = true
        }
    }
}


//MARK: FETCH ADH ANIMAL
extension OrderingAnimalipadVC {
    func fetchADHAnimalList(userId: Int, customerID: Int) {
        adhAnimalData.removeAll()
        let specieID = SpeciesID.dairySpeciesId
        let breedID  =  UserDefaults.standard.value(forKey: "breed") as? String ?? ""
        print("CUSTOMER ID =============== \(customerID)")
        print("USER ID    =============== \(userId)")
        print("SPECIES ID =============== \(specieID)")
        print("BREED ID =============== \(breedID)")
        
        adhAnimalData = SearchPoint.fetchADHAnimalList(entityName: Entities.animalMasterTblEntity, customerId: customerID, userID: 1, specieID: specieID, breedID: breedID, gender: "A", isADHCart: false) as! [AnimalMaster]
        applySorting()
    }
    
    func applySorting() {
        let sortedArray : [AnimalMaster] = (self.adhAnimalData.sorted(by: {($0.farmId ?? "").localizedStandardCompare($1.farmId ?? "") == .orderedAscending }))
        self.adhAnimalData = sortedArray
    }
    
    func AutoPopulateSuggetion(tag : Int) {
        btnTag = tag
        buttonbgAutoSuggestion.frame = CGRect(x:0,y: 0,width: self.view.frame.width,height: self.view.frame.height)
        buttonbgAutoSuggestion.addTarget(self, action:#selector(OrderingAnimalVC.buttonPreddDroperAutosugesstion), for: .touchUpInside)
        buttonbgAutoSuggestion.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        self.view.addSubview(buttonbgAutoSuggestion)
        AutoSuggestionTableView.delegate = self
        AutoSuggestionTableView.dataSource = self
        AutoSuggestionTableView.layer.cornerRadius = 8.0
        AutoSuggestionTableView.layer.borderWidth = 0.5
        AutoSuggestionTableView.layer.borderColor =  UIColor.gray.cgColor
        buttonbgAutoSuggestion.addSubview(AutoSuggestionTableView)
        var yFrame = 0 - self.scrolView.contentOffset.y
        var width = CGFloat()
        var xValue = CGFloat()
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = 72 - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = 82 - self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = 100 - self.scrolView.contentOffset.y
                
            case 2688,2796:
                yFrame = 120 - self.scrolView.contentOffset.y
                
            case 1792:
                yFrame = 120 - self.scrolView.contentOffset.y
                
            case 2532:
                yFrame = 120 - self.scrolView.contentOffset.y
                
            case 2340:
                yFrame = 100 - self.scrolView.contentOffset.y
                
            case 2778:
                yFrame = 120 - self.scrolView.contentOffset.y
                
            default:
                yFrame = 72 - self.scrolView.contentOffset.y
            }
        } else {
            switch UIScreen.main.bounds.height {
            case 768:
                yFrame = 210 - self.scrolView.contentOffset.y
                xValue = 520
                width = 482.0
            case 810:
                yFrame = 210 - self.scrolView.contentOffset.y
                width = 512.0
                xValue = 550
            case 820:
                if UIScreen.main.nativeBounds.height == 2360 {
                    yFrame = 160 - self.scrolView.contentOffset.y
                    width = 560
                    xValue = 600
                } else {
                    yFrame = 210 - self.scrolView.contentOffset.y
                    width = 525
                    xValue = 550
                }
               
                
            case 834:
                if UIScreen.main.nativeBounds.height == 2224.0 {
                    yFrame = 210 - self.scrolView.contentOffset.y
                    width = 525
                    xValue = 565
                } else {
                    yFrame = 210 - self.scrolView.contentOffset.y
                    width = 575
                    xValue = 610
                }
              
                
            case 1024:
                yFrame = 160 - self.scrolView.contentOffset.y
                width = 655
                xValue = 690
                
            case 1032:
                yFrame = 160 - self.scrolView.contentOffset.y
                width = 655
                xValue = 700
            default:
                yFrame = 72 - self.scrolView.contentOffset.y
            }
        }
        if tag == 0 {
            if scanAnimalTagText.tag == 1{
                AutoSuggestionTableView.frame = CGRect(x: xValue,y: yFrame + 137,width: width,height: 200)
            } else {
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 142,width: width,height: 200)
            }
        } else {
            if scanAnimalTagText.tag == 0{
                AutoSuggestionTableView.frame = CGRect(x: xValue,y: yFrame + 137,width: width,height: 200)
            } else {
                AutoSuggestionTableView.frame = CGRect(x: 20,y: yFrame + 137,width: width,height: 200)
            }
        }
        
        if filterAdhAnimalData.count == 0 {
            AutoSuggestionTableView.isHidden = true
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else{
            AutoSuggestionTableView.isHidden = false
            AutoSuggestionTableView.reloadData()
        }
    }
}

//MARK: AUTO POPULATE BULL TABLE
extension OrderingAnimalipadVC {
    func AutoPopulateBullTableForAU() {
        var yFrame = 460 - self.scrolView.contentOffset.y
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                break
                
            case 1334:
                yFrame = 460 - self.scrolView.contentOffset.y
                
            case 1920, 2208:
                yFrame = 470 - self.scrolView.contentOffset.y
                
            case 2436:
                yFrame = 475 - self.scrolView.contentOffset.y
                
            case 2688,2796:
                yFrame = 490 - self.scrolView.contentOffset.y
                
            case 1792:
                yFrame = 490 - self.scrolView.contentOffset.y
                
            case 2532:
                yFrame = 490 - self.scrolView.contentOffset.y
                
            case 2340:
                yFrame = 475 - self.scrolView.contentOffset.y
                
            case 2778:
                yFrame = 500 - self.scrolView.contentOffset.y
                
            default:
                yFrame = 400 - self.scrolView.contentOffset.y
            }
        }
        for i in 0..<autocompleteUrls1.count {
            let f = autocompleteUrls1.object(at:i) as! AusNaabBull
            let farmName = f.bullID
            let sirename = f.sireName
            let sireNationlId = f.bullID
            autocompleteUrlsbullname.add(sirename!)
            sireNatonIdArray.add(sireNationlId!)
            autocompleteUrls2.add(farmName!)
        }
        
        if autocompleteUrls2.count < 3 {
            AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
        } else {
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    break
                    
                case 1334:
                    AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 1920, 2208:
                    AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 2436:
                    AutoSuggestionTableView.frame = CGRect(x: 13,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 2688,2796:
                    AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 1792:
                    AutoSuggestionTableView.frame = CGRect(x: 30,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 2532:
                    AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 2340:
                    AutoSuggestionTableView.frame = CGRect(x: 12,y: yFrame - 95 ,width: 350,height: 250)
                    
                case 2778:
                    AutoSuggestionTableView.frame = CGRect(x: 33,y: yFrame + 455 ,width: 350,height: 250)
                    
                default:
                    AutoSuggestionTableView.frame = CGRect(x: 15,y: yFrame + 455 ,width: 350,height: 250)
                }
            } else {
                switch UIScreen.main.bounds.height {
                case 768:
                    AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                case 810:
                    AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame - 95 ,width: 565,height: 250)
                case 820:
                    if UIScreen.main.nativeBounds.height == 2360 {
                        AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                    } else {
                        AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                    }
                   
                    
                case 834:
                    if UIScreen.main.nativeBounds.height == 2224.0 {
                        AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                    } else {
                        AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                    }
                  
                    
                case 1024:
                    AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 655,height: 250)
                    
                case 1032:
                    AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 655,height: 250)
                default:
                    AutoSuggestionTableView.frame = CGRect(x: 18,y: yFrame + 455 ,width: 565,height: 250)
                }
            }
        }
        
        if autocompleteUrls2.count == 0 {
            AutoSuggestionTableView.isHidden = true
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else{
            AutoSuggestionTableView.isHidden = false
            AutoSuggestionTableView.reloadData()
        }
    }
}

//MARK: CREATE DATALIST
private typealias DataListCartHelper = OrderingAnimalipadVC
extension DataListCartHelper {
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
        let listName = orderingDataListViewModel.makeListName(custmerId: custmerId ,providerID: pvid)
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
            
            if self.pvid == 1 || self.pvid == 2 || self.pvid == 3 || self.pvid == 4 || self.pvid == 8 || self.pvid == 10 || self.pvid == 11 || self.pvid == 12{
                
                let fetchDatEntry = fetchDatalistDetailbyName(listName: listName)
                
                if fetchDatEntry.count == 0 {
                    saveDataEnteryList(entity: Entities.dataEntryListTblEntity,customerId: Int64(self.custmerId ),listDesc: "cart",listId: Int64(animalID1),listName: listName ,userId: UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int ?? 0, providerId: self.pvid, productType: "", productName: marketNameType.Dairy.rawValue)
                    
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid) as! [AnimaladdTbl]
                    for animalDetail in animalData {
                        let fetchDataUpdate = checkAnimalDataAccOfficalFarmid_ListID(entityName: Entities.dataEntryAnimalAddTbl,farmId:animalDetail.farmId ?? "",anmalTag:animalDetail.animalTag ?? "",custmerId :custmerId , listId: animalID1,providerID: pvid)
                        
                        if fetchDataUpdate.count == 0 {
                            saveAnimalinDataOrderingAnimal(listID: Int64(animalID1), animalDetails: animalDetail, animalID:animalID1)
                        }
                    }
                    
                } else {
                    let listId = fetchDatEntry[0].listId
                  let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry[0].listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid)
                  if fetchData11.count != 0 {
                    for i in 0...fetchData11.count - 1 {
                      let animalVal = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                      deleteAnimalDatafromList(entityName: Entities.dataEntryAnimalAddTbl, Int(animalVal.animalId), listID: Int(animalVal.listId))
                    
                    }
                  }
                  
                    let animalData  = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)  as! [AnimaladdTbl]
                  
                    for animalDetail in animalData {
                      
                       // let fetchDataUpdate = checkAnimalDataAccOfficalFarmid_ListID(entityName: Entities.dataEntryAnimalAddTbl,farmId:animalDetail.farmId ?? "",anmalTag:animalDetail.animalTag ?? "",custmerId :custmerId , listId: Int(listId),providerID: pvid)
                       // if fetchDataUpdate.count == 0 {
                      
                            saveAnimalinDataOrderingAnimal(listID: Int64(listId), animalDetails: animalDetail, animalID:animalID1)
                        //}
                    }
                }
            }
        }
    }
    
    func saveAnimalinDataOrderingAnimal(listID:Int64, animalDetails:AnimaladdTbl,animalID:Int) {
      //check farmid, officialid, barcode exist the
        saveAnimaldata(entity: Entities.dataEntryAnimalAddTbl,
                       animalTag: animalDetails.animalTag ?? "",
                       barCodetag: animalDetails.animalbarCodeTag ?? "",
                       date: animalDetails.date ?? "" ,
                       damId: animalDetails.offDamId ?? "",
                       sireId: animalDetails.offsireId ?? "" ,
                       gender: animalDetails.gender ?? "Female".localized,
                       update: "false",
                       permanentId:animalDetails.offPermanentId ?? "",
                       tissuName: animalDetails.tissuName ?? "",
                       breedName: animalDetails.breedName ?? "",
                       et: animalDetails.eT ?? "",
                       farmId:animalDetails.farmId ?? "",
                       orderId: Int(self.orderId),
                       orderSataus:"false",
                       breedId:animalDetails.breedId ?? "",
                       isSync:"false",
                       providerId: pvid,
                       tissuId: Int(animalDetails.tissuId ),
                       sireIDAU:animalDetails.sireIDAU ?? "",
                       nationHerdAU:animalDetails.nationHerdAU ?? "",
                       userId: userId,
                       udid:timeStampString,
                       animalId: Int(animalDetails.animalId),
                       selectedBornTypeId: selectedBornTypeId,
                       custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),
                       specisId: SpeciesID.dairySpeciesId,
                       earTag: "",
                       isSyncServer:false,
                       adhDataServer: false,
                       listId:listID,
                       editFlagSave: false,
                       serverAnimalId: "")
    }
}

//MARK: AUTO IMORT DATA LIST
private typealias AutoImportDataListHelper = OrderingAnimalipadVC
extension AutoImportDataListHelper {
    
    func checkUserDataListName(){
        let listName = orderingDataListViewModel.makeListName(custmerId: self.custmerId , providerID: pvid)
        let fetchDatEntry : [DataEntryList] = fetchAllDataEnteryList(entityName: Entities.dataEntryListTblEntity,customerId:Int64(self.custmerId ),listName:listName ,productName:marketNameType.Dairy.rawValue) as! [DataEntryList]
        if fetchDatEntry.count > 0{
          //  crossedBtnOutlet.isHidden = true
            var screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
            let fetchData11 = fetchAllDataAnimalDatarderIdDateEntryWithoutOrderId(entityName: Entities.dataEntryAnimalAddTbl, userId: userId,orderId:orderId,orderStatus:"false",listid:Int64(fetchDatEntry.first?.listId ?? 0), custmerId: Int64(custmerId ), providerId: pvid)
            if fetchData11.count != 0 {
                for i in 0...fetchData11.count - 1 {
                    let dataGet = fetchData11.object(at: i) as! DataEntryAnimaladdTbl
                    
                    saveAnimaldata(entity: Entities.animalAddTblEntity,animalTag: dataGet.animalTag ?? "" ,barCodetag: dataGet.animalbarCodeTag ?? "",date: dataGet.date ?? "",damId: dataGet.offDamId ?? "",sireId: dataGet.offsireId ?? "",gender: dataGet.gender ?? "",update: "false",permanentId: dataGet.offPermanentId ?? "",tissuName: dataGet.tissuName ?? "",breedName: dataGet.breedName ?? "",et: dataGet.eT ?? "",farmId: dataGet.farmId ?? "",orderId: Int(self.orderId ) ,orderSataus:dataGet.orderstatus ?? "",breedId: dataGet.breedId ?? "",isSync:dataGet.isSync  ?? "",providerId:pvid,tissuId: Int(dataGet.tissuId ),sireIDAU:(dataGet.sireIDAU ?? ""),nationHerdAU:dataGet.nationHerdAU ?? "",userId:Int(userId),udid: dataGet.udid ?? "",animalId:Int(dataGet.animalId ), selectedBornTypeId: Int(dataGet.selectedBornTypeId),custId: Int(dataGet.custmerId),specisId:dataGet.specisType!,earTag:"",isSyncServer:dataGet.isSyncServer , adhDataServer: dataGet.adhDataServer,listId:Int64(dataGet.listId), editFlagSave: false, serverAnimalId: dataGet.serverAnimalId ?? "")
                    
                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.tsuKeyType.rawValue)
                    UserDefaults.standard.setValue(dataGet.breedId ?? "", forKey: keyValue.breedId.rawValue)
                    UserDefaults.standard.setValue(dataGet.tissuName ?? "", forKey: keyValue.capsTSUClear.rawValue)
                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.breedNameClear.rawValue)
                    UserDefaults.standard.setValue(dataGet.breedName ?? "", forKey: keyValue.capsBreedName.rawValue)
                    self.breedBtnOutlet.setTitle(dataGet.breedName ?? "", for: .normal)
                    self.tissueBtnOutlet.setTitle(dataGet.tissuName?.localized ?? "", for: .normal)
                    saveSampleNameandID(sampleNameStr: dataGet.tissuName ?? "", sampleID: Int(dataGet.tissuId))
                    autoSaveProduct(dataGet: dataGet)
                }
            }
        }
    }
    
    func autoSaveProduct(dataGet: DataEntryAnimaladdTbl) {
        let animalData = fetchAllDataAnimalDatarderId(entityName: Entities.animalAddTblEntity, userId: userId,orderId:orderId,orderStatus:"false", providerId: self.pvid)
        
        let product = fetchproviderProductDataBreedId(entityName: Entities.getProductTblEntity, provId: Int(dataGet.providerId), breedId: dataGet.breedId ?? "" )
        for k in 0 ..< animalData.count{
            
            let animalId = animalData[k] as! AnimaladdTbl
            for i in 0 ..< product.count{
                let data = product[i] as! GetProductTbl
                if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                    if data12333.count > 0 {
                        let adonDat =  fetchProductAdonDataWithBVDV(entityName: Entities.getAdonTblEntity, prodId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue),adonId : LocalizedStrings.bvdvAddOnId)
                        if adonDat.count > 0 {
                            addedd = true
                            saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                            updateOrderStatusAnimal(entity: Entities.dataEntryAnimalAddTbl, status: "true", orderId: Int(self.orderId), userId: userId, animalId: Int(dataGet.animalId ))
                        }
                    }
                    else {
                        saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                    }
                }
                else {
                    
                    
                    saveProductAdonTbl(entity: Entities.productAdonAnimalTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false",  farmId:animalId.farmId ?? "", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: Int(dataGet.animalId ), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "", pricing: data.pricing ?? "",custId:UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue), isCdcbProduct: data.isCdcbProduct)
                    
                }
                
                if pvid == 3 && UserDefaults.standard.value(forKey: keyValue.isAuSelected.rawValue) as? String == keyValue.noNeedAuPopUp.rawValue {
                    addonArr = fetchProductAdonData(entityName : Entities.getAdonTblEntity,prodId: Int(data.productId),isCdcbProduct:false)
                    
                } else {
                    addonArr = fetchProductAdonData(entityName: Entities.getAdonTblEntity, prodId: Int(data.productId))
                }
                
                for j in 0 ..< addonArr.count {
                    
                    let addonDat = addonArr[j] as! GetAdonTbl
                    if data.productId == Int16(UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue)) {
                        let data12333 =  fetchProductAdonDataStatusBVDV(entityName: Entities.subProductTblEntity, adonId: LocalizedStrings.bvdvAddOnId, status: "true",ordrId:autoD, customerID: custmerId)
                        if data12333.count > 0 {
                            if addonDat.adonName == LocalizedStrings.bvdvAddOnId {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ), custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                updateProductTablevaleeSingleeInBef(entity: Entities.getAdonTblEntity, productId: UserDefaults.standard.integer(forKey: keyValue.bvdvValidation.rawValue), status: "true")
                                
                            }
                            else {
                                saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                            }
                        }
                        else {
                            saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                        }
                    }
                    
                    else {
                        saveSubroductTbl(entity: Entities.subProductTblEntity, animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(self.orderId ), orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString,  farmId:animalId.farmId ?? "", animalId: Int(dataGet.animalId ),custId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                    }
                }
            }
        }
        //crossedBtnOutlet.isHidden = true
    }
}

//MARK: DELETE LIST HELPER OR ordering ANIMAL CONTROLLER
private typealias DeleteListHelper = OrderingAnimalipadVC
extension DeleteListHelper {
  func getListName()  {
    let listName = orderingDataListViewModel.makeListName(custmerId: self.custmerId , providerID: pvid)
    createListNameAndCheckifExist(fetchDataEntry: fetchDatalistDetailbyName(listName: listName), listName: listName)
    
  }
  
  func createListNameAndCheckifExist(fetchDataEntry: [DataEntryList], listName: String){
    if fetchDataEntry.count > 0 {
      self.showIndicator(self.view, withTitle: NSLocalizedString("", comment: ""), and: "")
      self.view.isUserInteractionEnabled = false
      deleteList(listName: listName, customerId: Int64(custmerId ?? 0),listID: Int(fetchDataEntry[0].listId))
    }
  }
  
  func deleteList(listName: String, customerId: Int64, listID: Int) {
    let accessToken = UserDefaults.standard.value(forKey: keyValue.accessToken.rawValue) as? String
    let headerDict = [LocalizedStrings.authorizationHeader: accessToken!,LocalizedStrings.contentType : LocalizedStrings.formURLEncoded]
    let urlString = Configuration.Dev(packet: ApiKeys.deleteList.rawValue).getUrl()
    let parameters : [String: Any] = [keyValue.customerId.rawValue: customerId,keyValue.listName.rawValue:listName]
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
        self.hideIndicator()
        self.view.isUserInteractionEnabled = true
        deleteDataWithListIdDatEntry(entityString: Entities.dataEntryAnimalAddTbl, listId: Int(listID), customerId: UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue),userId:self.userId)
        deleteDataWithListId(entityString: Entities.dataEntryListTblEntity, listId: Int64(listID), customerId: Int(customerId ),userId:self.userId)
      }
    }
  }
}

//MARK: OFFLINE CUSTOM VIEW
extension OrderingAnimalipadVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
}

//MARK: OFFLINE CUSTOM VIEW
extension OrderingAnimalipadVC : SideMenuUI,RFID,nearByDevice{
    
    func rfidCode(rfid: String) {
        if UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String != keyValue.ocrKey.rawValue {
            farmIdTextField.text?.removeAll()
            if defaltscreen == keyValue.farmId.rawValue{
                if farmIdTextField.isEnabled == true {
                    farmIdTextField.text = breedBtnOutlet.titleLabel!.text! + rfid
                    farmIdTextField.text = farmIdTextField.text!.trimmingCharacters(in: CharacterSet.whitespaces)
                }
            } else {
                
                if scanAnimalTagText.isEnabled == true {
                    scanAnimalTagText.becomeFirstResponder()
                    self.officalTagView.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
                    scanAnimalTagText.text = breedBtnOutlet.titleLabel!.text! + rfid
                    scanAnimalTagText.text = scanAnimalTagText.text!.trimmingCharacters(in: CharacterSet.whitespaces)
                }
            }
        }
    }
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
    
    func deviceNear(deviceName : [CBPeripheral]){
        arrNearbyDevice = deviceName
    }
}

//MARK: COLLECTION VIEW DATASOURCE AND DELEGATE
extension OrderingAnimalipadVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUPCollectionView() {
        self.getBornTypes = fetchBornTypesWithProviderId(entityName: Entities.getBornTypeTblEntity, providerId: pvid)
        self.etBtn = LocalizedStrings.singlesText
        self.selectedBornTypeId = 1
        self.singleBtnAction(UIButton())
        
        self.bornTypeCollection.delegate = self
        self.bornTypeCollection.dataSource = self
        bornTypeCollection.register(UINib(nibName: ClassIdentifiers.bornTypeCellIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: ClassIdentifiers.bornTypeCellIdentifier)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getBornTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.bornTypeCellIdentifier, for: indexPath) as? BorntTypeCell
        let borntype = self.getBornTypes[indexPath.row]
        cell?.bornTypeLabel.lineBreakMode = .byWordWrapping
        cell?.bornTypeLabel.textAlignment = .center
        cell?.bornTypeLabel.text = borntype.bornTypeName?.localized
        cell?.bornTypeLabel.numberOfLines = 1
        
        if borntype.bornTypeName == "Single"{
            cell?.bornTypeLabel.text = NSLocalizedString("Single", comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.multipleBirthStr{
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.multipleBirthStr, comment: "")
        }
        else if borntype.bornTypeName == "ET"{
            cell?.bornTypeLabel.text = NSLocalizedString("ET", comment: "")
        }
        else if borntype.bornTypeName == NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: ""){
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.splitEmbryoStr, comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.cloneText{
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.cloneText, comment: "")
        }
        else if borntype.bornTypeName == LocalizedStrings.internalStr{
            cell?.bornTypeLabel.text = NSLocalizedString(LocalizedStrings.internalStr, comment: "")
        }
        cell?.bornTypeLabel.font = UIFont(name: "System", size: 17.0)
        cell?.bornTypeLabel.textColor = UIColor.black
        
        if self.selectedBornTypeId == borntype.bornTypeID && !isGrayField {
//            cell?.titleButton.layer.borderWidth = 2
//            cell?.titleButton.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            self.setButtonState(button: cell?.titleButton, isOn: true)
            cell?.bornTypeLabel.textColor = UIColor.white
        } else {
            self.setButtonState(button: cell?.titleButton, isOn: false)
            cell?.bornTypeLabel.textColor = UIColor.black
        }
        
//        if isGrayField {
//            cell?.titleButton.backgroundColor =  UIColor.clear
//            cell?.titleButton.layer.borderColor = UIColor(displayP3Red: 10/255, green: 137/255, blue: 137/255, alpha: 1).cgColor
//        } else {
//            cell?.titleButton.backgroundColor = UIColor(red: 255/255, green: 92/255, blue: 2/255, alpha: 1.0)
//            cell?.titleButton.layer.borderColor = UIColor.clear.cgColor
//        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
        let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: Entities.animalMasterTblEntity, animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
        if orederStatus.count > 0 {
            barcodeEnable = true
        }
        
        let borntype = self.getBornTypes[indexPath.row]
        
        self.selectedBornTypeId = Int(borntype.bornTypeID)
        
        if let bornTypes = BornTypes(rawValue: indexPath.item) {
            switch bornTypes {
            case .Single:
                self.singleBtnAction(UIButton())
                break
            case .Multiple_Birth:
                self.multiBirthBtnAction(UIButton())
                break
            case .ET:
                self.EtBtnAction(UIButton())
                break
            case .Split_Embryo:
                self.splitEmbryoAction(UIButton())
                break
            case .Clone:
                self.cloneBtnClick(UIButton())
                break
            case .Internal:
                self.internalBtnAction(UIButton())
                break
            }
        }
        UIView.performWithoutAnimation {
            self.bornTypeCollection.reloadData()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/6.0
        return CGSize(width: yourWidth-15, height: 62)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

//MARK: IMAGE PICKER CONTROLLER DELEGATE
extension OrderingAnimalipadVC : UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        if self.scanAnimalTagText.tag == 0 {
            self.scanAnimalTagText.text = ""
            
        } else  {
            self.farmIdTextField.text = ""
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.imageView.image = image
        setVisionTextRecognizeImage(image: image)
        
    }
}

//MARK: OBJECT PICK CART SCREEN DELEGATE
extension OrderingAnimalipadVC : objectPickCartScreen {
    func objectGetOnSelection(temp: Int) {}
    
}

//MARK: OFFLINE CUSTOM VIEW 1 DELEGATE
extension OrderingAnimalipadVC : offlineCustomView1 {
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
}
