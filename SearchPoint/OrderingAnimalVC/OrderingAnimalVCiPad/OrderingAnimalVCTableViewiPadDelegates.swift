//
//  OrderingAnimalVCTableViewiPadDelegates.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 18/01/25.
//

import Foundation
import UIKit

//MARK: TABLEVIEW DATASOURCE AND DELEGATE
extension OrderingAnimalipadVC :UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == importTblView {
            return importListArray.count
        }
        if tableView == pairedTableView {
            return arrNearbyDevice.count
        }
        else if btnTag == 10 {
            return self.breedArr.count
        }  else  if btnTag == 20{
            return self.tissueArr.count
        } else if btnTag == 0 || btnTag == 1 {
            return self.filterAdhAnimalData.count
        }
        else if btnTag == 50 {
            return self.genderArray.count
        }
        else{
            return self.autocompleteUrls2.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
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
            if  state == .connected{
                cell.accessoryType = .checkmark
            }
            else {
                cell.accessoryType = .none
            }
            return cell
        }
        
        if btnTag == 10 {
            let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
            if breeedData.breedId == "1f263617-923b-450f-825b-1489bfb42d7f" && breeedData.alpha2?.isEmpty == true {
                cell.textLabel?.text = "BF"
            } else {
                cell.textLabel?.text = breeedData.alpha2
                
            }
            return cell
            
        } else if btnTag == 20 {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            cell.textLabel?.text = tissue.sampleName?.localized
            saveSampleNameandID(sampleNameStr: tissue.sampleName ?? "", sampleID: Int(tissue.sampleId ))
            return cell
            
        }
        else if btnTag == 50 {
            let gender = self.genderArray[indexPath.row] as! String
            cell.textLabel?.text = gender
            return cell
            
        }
        else if btnTag == 0 {
            do{
                if indexPath.row  < filterAdhAnimalData.count {
                    if scanAnimalTagText.tag == 0 {
                        if let value = filterAdhAnimalData[indexPath.row].animalTag{
                            cell.textLabel?.text = value
                            
                        }
                    } else {
                        if let value = filterAdhAnimalData[indexPath.row].animalTag{
                            cell.textLabel?.text = value
                        }
                    }
                }
            }
            return cell
        }
        else if btnTag == 1 {
            do{
                if indexPath.row  < filterAdhAnimalData.count {
                    if scanAnimalTagText.tag == 1 {
                        if let value = filterAdhAnimalData[indexPath.row].farmId{
                            cell.textLabel?.text = value
                        }
                    } else {
                        if let value = filterAdhAnimalData[indexPath.row].farmId{
                            cell.textLabel?.text = value
                        }
                    }
                    
                }
                return cell
            }
        }
        
        else if btnTag == 30 {
            
            do {
                if indexPath.row  < autocompleteUrls2.count {
                    if let value = autocompleteUrls2.object(at:indexPath.row) as? String{
                        if let value2 = autocompleteUrlsbullname.object(at:indexPath.row) as? String{
                            let helloAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: .light)]
                            let worldAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0, weight: .bold)]
                            
                            let helloString = NSAttributedString(string: "\n(\(value2))", attributes: helloAttributes)
                            let worldString = NSMutableAttributedString(string: value, attributes: worldAttributes)
                            worldString.append(helloString)
                            cell.textLabel?.attributedText = worldString
                            cell.textLabel?.numberOfLines = 2
                        }
                    }
                }
                return cell
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.setShadowForUIView(view: sampleTypeView, removeShadow: true)
        self.setShadowForUIView(view: genderView, removeShadow: true)
        self.setShadowForUIView(view: breedView, removeShadow: true)
        if tableView == importTblView {
            let listId1 = importListArray[indexPath.row].listId
            let listName = importListArray[indexPath.row].listName
            let customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
            listNameString = listName ?? ""
            listId = Int(listId1)
            return
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
        
        if btnTag == 10 {
          
          let orederStatus = fetchAllDataWithAnimalIdstatus(entityName: "AnimaladdTbl", animalId: idAnimal,orderststus:"true", customerId: self.custmerId)
          if orederStatus.count > 0 {
              barcodeEnable = true
              buttonbg2.removeFromSuperview()
              let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
              breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
              return
          }
        
          
          let breeedData = self.breedArr[indexPath.row]  as! GetBreedsTbl
          breedId = breeedData.breedId!
         
          var breedidd =  UserDefaults.standard.value(forKey: "breed") as? String
          let getbreedname = fetchbreedname(entityName: "GetBreedsTbl", breedid: breedidd ?? "")
            if getbreedname.count == 0 {
                breedidd = ""
            } else {
                let newvalue1 = getbreedname.object(at: 0) as? GetBreedsTbl
                UserDefaults.standard.set(newvalue1?.alpha2, forKey: "oldbreedname")
            }
        
           
          if breedidd != breedId {
              let animalData = fetchAnimaldataDairy(entityName: "AnimaladdTbl", animalTag:animalId1,orderId:orderId,userId:userId)
              if animalData.count > 0 {
                  
                let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString(LocalizedStrings.changeBreedClearProduct, comment: ""), preferredStyle: .alert)
                  
                  alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .default, handler: { (_) in
                     
                  }))
                  alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                     
                      
                      let animalId = animalData.object(at: 0) as! AnimaladdTbl
                      deleteDataWithProduct(Int(animalId.animalId))
                      deleteDataWithSubProduct(Int(animalId.animalId))
                      let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
                      let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: self.breedId )
                      for k in 0 ..< animalData.count  {
                          
                          let animalId = animalData[k] as! AnimaladdTbl
                          
                          for i in 0 ..< product.count{
                              
                              let data = product[i] as! GetProductTbl
                              if data.productId == Int16(UserDefaults.standard.integer(forKey: "BVDVvalidation")) {
                                let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTbl", adonId: "BVDV", status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                  if data12333.count > 0 {
                                      let adonDat =  fetchProductAdonDataWithBVDV(entityName: "GetAdonTbl", prodId: UserDefaults.standard.integer(forKey: "BVDVvalidation"),adonId : "BVDV")
                                      if adonDat.count > 0 {
                                          saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "", custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: data.isCdcbProduct)
                                          
                                          updateOrderStatusAnimal(entity: "AnimaladdTbl", status: "true", orderId: Int(animalId.orderId), userId: self.userId, animalId:  Int(animalId.animalId))
                                      }
                                  }
                                  else {
                                      saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId!, productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: data.isCdcbProduct)
                                  }
                                  
                              }
                              else {
                                  saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "",mkdId: data.marketId! ?? "", productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: self.farmIdText, orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", animalId: Int(animalId.animalId), marketName: data.marketName ?? "",orderTerrms: data.orderAcceptTerms ?? "" ,pricing: data.pricing ?? "",custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"), isCdcbProduct: data.isCdcbProduct)
                              }
                              if pvid == 3 && UserDefaults.standard.value(forKey: "isAuSelected") as? String == "NoNeedAuPopUp" {
                                  
                                  self.addonArr = fetchProductAdonData(entityName : "GetAdonTbl",prodId: Int(data.productId),isCdcbProduct:false)

                              } else {
                               
                                  self.addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                              }
                              
                              for j in 0 ..< self.addonArr.count {
                                  
                                  let addonDat = self.addonArr[j] as! GetAdonTbl
                                  if data.productId == Int16(UserDefaults.standard.integer(forKey: "BVDVvalidation")) {
                                    let data12333 =  fetchProductAdonDataStatusBVDV(entityName: "SubProductTbl", adonId: "BVDV", status: "true",ordrId:self.autoD,customerID: self.custmerId)
                                      if data12333.count > 0 {
                                          if Int(addonDat.adonId) == 1 {
                                              saveSubroductTbl(entity: "SubProductTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "true", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                              updateProductTablevaleeSingleeInBef(entity: "GetAdonTbl", productId: UserDefaults.standard.integer(forKey: "BVDVvalidation"), status: "true")
                                          }
                                          else {
                                              saveSubroductTbl(entity: "SubProductTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                          }
                                          
                                      }
                                  }
                                  else {
                                      saveSubroductTbl(entity: "SubProductTbl", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(animalId.orderId), orderStatus: "false", isSync: "false", userId: self.userId,udid:animalId.udid ?? "", farmId: self.farmIdText, animalId: Int(animalId.animalId),custId: UserDefaults.standard.integer(forKey: "currentActiveCustomerId"),textValueEnglish:addonDat.textValueEnglish ?? "",textValuePortugese:addonDat.textValuePortugese ?? "")
                                      
                                  }
                              }
                              
                              
                          }
                      }
                      let  aDat = fetchAllData(entityName: "AnimaladdTbl")
                      if aDat.count > 0{
                          UserDefaults.standard.set(true, forKey: "identifyStore")
                      }
                      
                      UserDefaults.standard.set(self.breedId, forKey: "breed")
                      self.breedBtnOutlet.setTitleColor(.black, for: .normal)
                      
                      if breeedData.breedId == "1f263617-923b-450f-825b-1489bfb42d7f" && breeedData.alpha2?.isEmpty == true {
                          self.breedBtnOutlet.setTitle("BF", for: .normal)
                          UserDefaults.standard.set("BF", forKey: "breedName")
                          
                      } else {
                          let breestr = breeedData.alpha2 ?? ""
                          print(breestr)
                          let stri = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                          print(stri.prefix(2))
                          let pvId = UserDefaults.standard.value(forKey: keyValue.providerID.rawValue) as? Int
                          if pvId == 2 {
                              if (breestr == stri.prefix(2)) || self.scanAnimalTagText.text == ""
                               {
                                  self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                              }
                               else
                               {
                               let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("You are trying to select a breed which is different from the Official ID. Do you want to proceed?", comment: ""), preferredStyle: .alert)
                               
                               alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                               }))
                               
                               
                               alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
                                   
                                   
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                   UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                                    var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                                   if animalBreedChange.count == 17 {
                                       if breeedData.alpha2! == "" {
                                           animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))

                                       } else {
                                           animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))

                                       }
                                       UserDefaults.standard.set(animalBreedChange, forKey: "selectAnimalId")
                                       self.textFieldAnimal = animalBreedChange
                                       if self.scanAnimalTagText.tag == 0 {
                                           self.scanAnimalTagText.text! = animalBreedChange
                                       }
                                       else {
                                           
                                           self.farmIdTextField.text! = animalBreedChange
                                       }
                                   }
                               }))
                               self.present(alert, animated: true, completion: nil)
                              
                           }
                          }
                          else {
                              if (breestr == stri.prefix(2)) || self.farmIdTextField.text == ""
                               {
                                  self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                              }
                               else
                               {
                               let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("You are trying to select a breed which is different from the Official ID. Do you want to proceed?", comment: ""), preferredStyle: .alert)
                               
                               alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                               }))
                               
                               
                               alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
                                   
                                   
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                   UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                                    var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                                   if animalBreedChange.count == 17 {
                                       if breeedData.alpha2! == "" {
                                           animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))

                                       } else {
                                           animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))

                                       }
                                       UserDefaults.standard.set(animalBreedChange, forKey: "selectAnimalId")
                                       self.textFieldAnimal = animalBreedChange
                                       if self.scanAnimalTagText.tag == 0 {
                                           self.scanAnimalTagText.text! = animalBreedChange
                                       }
                                       else {
                                           
                                           self.farmIdTextField.text! = animalBreedChange
                                       }
                                   }
                               }))
                               self.present(alert, animated: true, completion: nil)
                              
                           }
                          }

                      }
                      /////
                      
                      var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""

                      var codeId = fetchBreedDatabreedCode( entityName: "GetBreedsTbl",provId: pvid,breedCode:breeedData.alpha2!)
                      let naabFetch1 = codeId.value(forKey: "breedId") as? NSArray
                      if naabFetch1!.count == 0 {
                          
                      } else {
                          var breedIdGet = (naabFetch1![0] as? String)!
                          self.breedId = breedIdGet
                      }
                      if self.borderRedCheck == true{
                          
                      } else {
                          
                          if self.scanAnimalTagText.tag == 0 {
                              self.scanAnimalTagText.text! = animalBreedChange
                          }
                          else {
                              
                              self.farmIdTextField.text! = animalBreedChange
                          }
                      }
                      
                  }))
                  
                  
                  
                  self.present(alert, animated: true, completion: nil)
                  
              }
              else {
                 
                  
                  
                  if breedidd != breedId {
                      let  aDat = fetchAllData(entityName: "AnimaladdTbl")
                      if aDat.count > 0{
                          UserDefaults.standard.set(true, forKey: "identifyStore")
                      }
                  }
                  
                  UserDefaults.standard.set(self.breedId, forKey: "breed")
                  self.breedBtnOutlet.setTitleColor(.black, for: .normal)
                  if breeedData.breedId == "1f263617-923b-450f-825b-1489bfb42d7f" && breeedData.alpha2?.isEmpty == true {
                      self.breedBtnOutlet.setTitle("BF", for: .normal)
                      UserDefaults.standard.set("BF", forKey: "breedName")
                  } else {
                      
                      let breestr = breeedData.alpha2 ?? ""
                      print(breestr)
                      let stri = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                      print(stri.prefix(2))
                      
                      let screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
                      
                      if screenPerference == keyValue.officialId.rawValue {
                          if (breestr == stri.prefix(2)) || self.scanAnimalTagText.text == ""
                           {
                              self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                          }
                           else
                           {
                           let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("You are trying to select a breed which is different from the Official ID. Do you want to proceed?", comment: ""), preferredStyle: .alert)
                           
                           alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                               
                               
                               self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                               UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                                var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                               if animalBreedChange.count == 17 {
                                   if breeedData.alpha2! == "" {
                                       animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))

                                   } else {
                                       animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))

                                   }
                                   UserDefaults.standard.set(animalBreedChange, forKey: "selectAnimalId")
                                   self.textFieldAnimal = animalBreedChange
                                   if self.scanAnimalTagText.tag == 0 {
                                       self.scanAnimalTagText.text! = animalBreedChange
                                   }
                                   else {
                                       
                                       self.farmIdTextField.text! = animalBreedChange
                                   }
                               }
                           }))
                             alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                 self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
       //                               let oldbreed = UserDefaults.standard.value(forKey: "oldbreedname") as? String ?? ""
       //                                //self.breedBtnOutlet.setTitle(oldbreed, for: .normal)
       //                                     UserDefaults.standard.set(oldbreed, forKey: "breedName")
                             }))
                             
                           self.present(alert, animated: true, completion: nil)
                           //  UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                       }
                      }
                      else {
                          let screenPerference = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String
                          
                          if screenPerference == keyValue.officialId.rawValue {
                              if (breestr == stri.prefix(2)) || self.scanAnimalTagText.text == ""
                               {
                                  self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                              }
                               else
                               {
                               let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("You are trying to select a breed which is different from the Official ID. Do you want to proceed?", comment: ""), preferredStyle: .alert)
                               
                               alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                                   
                                   
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                   UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                                    var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                                   if animalBreedChange.count == 17 {
                                       if breeedData.alpha2! == "" {
                                           animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))

                                       } else {
                                           animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))

                                       }
                                       UserDefaults.standard.set(animalBreedChange, forKey: "selectAnimalId")
                                       self.textFieldAnimal = animalBreedChange
                                       if self.scanAnimalTagText.tag == 0 {
                                           self.scanAnimalTagText.text! = animalBreedChange
                                       }
                                       else {
                                           
                                           self.farmIdTextField.text! = animalBreedChange
                                       }
                                   }
                               }))
                                 alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                     self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
           //                               let oldbreed = UserDefaults.standard.value(forKey: "oldbreedname") as? String ?? ""
           //                                //self.breedBtnOutlet.setTitle(oldbreed, for: .normal)
           //                                     UserDefaults.standard.set(oldbreed, forKey: "breedName")
                                 }))
                                 
                               self.present(alert, animated: true, completion: nil)
                               //  UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                           }
                          }
                          else {
                              if (breestr == stri.prefix(2)) || self.farmIdTextField.text == ""
                               {
                                  self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                              }
                               else
                               {
                               let alert = UIAlertController(title: NSLocalizedString("", comment: ""), message: NSLocalizedString("You are trying to select a breed which is different from the Official ID. Do you want to proceed?", comment: ""), preferredStyle: .alert)
                               
                               alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                                   
                                   
                                   self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
                                   UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                                    var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
                                   if animalBreedChange.count == 17 {
                                       if breeedData.alpha2! == "" {
                                           animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))

                                       } else {
                                           animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))

                                       }
                                       UserDefaults.standard.set(animalBreedChange, forKey: "selectAnimalId")
                                       self.textFieldAnimal = animalBreedChange
                                       if self.scanAnimalTagText.tag == 0 {
                                           self.scanAnimalTagText.text! = animalBreedChange
                                       }
                                       else {
                                           
                                           self.farmIdTextField.text! = animalBreedChange
                                       }
                                   }
                               }))
                                 alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
                                     self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
           //                               let oldbreed = UserDefaults.standard.value(forKey: "oldbreedname") as? String ?? ""
           //                                //self.breedBtnOutlet.setTitle(oldbreed, for: .normal)
           //                                     UserDefaults.standard.set(oldbreed, forKey: "breedName")
                                 }))
                                 
                               self.present(alert, animated: true, completion: nil)
                               //  UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
                           }
                          }
                      }
                      
                     

                  }
                  ///
//
                 let animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
//                        if animalBreedChange.count == 17 {
//                            if breeedData.alpha2! == "" {
//                                animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
//
//                            } else {
//                                animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
//
//                            }
//
//                            textFieldAnimal = animalBreedChange
//                        }
//                        if sireIdTextField.text!.count == 17 {
//                            //  SireIdSaveTemp
//                            var sireBreedChange = UserDefaults.standard.value(forKey: "SireIdSaveTemp") as! String
//
//                            sireBreedChange = (breeedData.alpha2 ?? "")  + String(sireBreedChange.dropFirst(2))
//
//                            // sireIdTextField.text = sireBreedChange
//                            if sireIdTextField.text!.count != 0 {
//                                sireIdTextField.text = sireBreedChange
//                            }
//                        }
//
//                        if damtexfield.text!.count == 17 {
//
//                            var damBreedChange = UserDefaults.standard.value(forKey: "NaabIdSaveTemp") as! String
//                            damBreedChange = (breeedData.alpha2 ?? "") + String(damBreedChange.dropFirst(2))
//
//                            if damtexfield.text!.count != 0 {
//                                damtexfield.text = damBreedChange
//
//                            }            }
                  
                  
                  var codeId = fetchBreedDatabreedCode( entityName: "GetBreedsTbl",provId: pvid,breedCode:breeedData.alpha2!)
                  let naabFetch1 = codeId.value(forKey: "breedId") as? NSArray
                  if naabFetch1!.count == 0 {
                      
                  } else {
                      var breedIdGet = (naabFetch1![0] as? String)!
                      breedId = breedIdGet
                  }
                  if borderRedCheck == true{
                      
                  } else {
                      
                      if scanAnimalTagText.tag == 0 {
                          scanAnimalTagText.text! = animalBreedChange
                      }
                      else {
                          
                          farmIdTextField.text! = animalBreedChange
                      }
                  }
                  
              }
              
          }
          else {
              if breedidd != breedId {
                  let  aDat = fetchAllData(entityName: "AnimaladdTbl")
                  if aDat.count > 0{
                      UserDefaults.standard.set(true, forKey: "identifyStore")
                  }
                  
              }
              
              // UserDefaults.standard.set(self.breedId, forKey: "breed")
              self.breedBtnOutlet.setTitleColor(.black, for: .normal)
              if breeedData.breedId == "1f263617-923b-450f-825b-1489bfb42d7f" && breeedData.alpha2?.isEmpty == true {
                  self.breedBtnOutlet.setTitle("BF", for: .normal)
                  UserDefaults.standard.set("BF", forKey: "breedName")
                  UserDefaults.standard.set( breeedData.breedId, forKey: "breed")
              } else {

//                        self.breedBtnOutlet.setTitle(breeedData.alpha2, for: .normal)
//                        UserDefaults.standard.set(breeedData.alpha2, forKey: "breedName")
//                        UserDefaults.standard.set(breedId, forKey: "breed")
              }
              
              
              
              ///
              var animalBreedChange = UserDefaults.standard.value(forKey: "selectAnimalId") as? String ?? ""
//                    if animalBreedChange.count == 17 {
//                        if breeedData.alpha2! == "" {
//                            animalBreedChange = "BF" + String(animalBreedChange.dropFirst(2))
//
//                        } else {
//                            animalBreedChange = breeedData.alpha2! + String(animalBreedChange.dropFirst(2))
//
//                        }
//
//                        textFieldAnimal = animalBreedChange
//                    }
//                    if sireIdTextField.text!.count == 17 {
//                        //  SireIdSaveTemp
//                        var sireBreedChange = UserDefaults.standard.value(forKey: "SireIdSaveTemp") as! String
//
//                        sireBreedChange = (breeedData.alpha2 ?? "")  + String(sireBreedChange.dropFirst(2))
//
//                        // sireIdTextField.text = sireBreedChange
//                        if sireIdTextField.text!.count != 0 {
//                            sireIdTextField.text = sireBreedChange
//                        }
//                    }
//
//                    if damtexfield.text!.count == 17 {
//
//                        var damBreedChange = UserDefaults.standard.value(forKey: "NaabIdSaveTemp") as! String
//                        damBreedChange = (breeedData.alpha2 ?? "") + String(damBreedChange.dropFirst(2))
//
//                        if damtexfield.text!.count != 0 {
//                            damtexfield.text = damBreedChange
//
//                        }            }
              
              
              var codeId = fetchBreedDatabreedCode( entityName: "GetBreedsTbl",provId: pvid,breedCode:breeedData.alpha2!)
              let naabFetch1 = codeId.value(forKey: "breedId") as? NSArray
              if naabFetch1!.count == 0 {
                  
              } else {
                  var breedIdGet = (naabFetch1![0] as? String)!
                  breedId = breedIdGet
              }
              if borderRedCheck == true{
                  
              } else {
                  
                  if scanAnimalTagText.tag == 0 {
                      scanAnimalTagText.text! = animalBreedChange
                  }
                  else {
                      
                      farmIdTextField.text! = animalBreedChange
                  }
              }
          }
          
          
          buttonbg2.removeFromSuperview()
          
          
      }
        else if btnTag == 20  {
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            tissuId = Int(tissue.sampleId)
            sampleID = tissuId
            sampleName = tissue.sampleName ?? ""
            tissueBtnOutlet.setTitleColor(.black, for: .normal)
            saveSampleNameandID(sampleNameStr: sampleName, sampleID: sampleID)
            tissueBtnOutlet.setTitle(tissue.sampleName?.localized, for: .normal)
            buttonbg2.removeFromSuperview()
            
        }
        
        else if btnTag == 50  {
            let gender = self.genderArray[indexPath.row]  
            genderString = gender
            male_femaleBtnOutlet.setTitleColor(.black, for: .normal)
            male_femaleBtnOutlet.setTitle(gender, for: .normal)
            if gender.contains("F") {
                UserDefaults.standard.set("F", forKey: "USDairyGender")
            } else {
                UserDefaults.standard.set("M", forKey: "USDairyGender")
            }
            buttonbg2.removeFromSuperview()
            
        }
        else if btnTag == 0 {
            if scanAnimalTagText.tag == 0 {
                scanAnimalTagText.text = filterAdhAnimalData[indexPath.row].animalTag ?? ""
                dataPopulateInFocusChange()
            } else {
                farmIdTextField.text = filterAdhAnimalData[indexPath.row].animalTag ?? ""
            }
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else if btnTag == 1 {
            if scanAnimalTagText.tag == 1 {
                scanAnimalTagText.text = filterAdhAnimalData[indexPath.row].farmId ?? ""
                dataPopulateInFocusChange()
            } else {
                farmIdTextField.text = filterAdhAnimalData[indexPath.row].farmId ?? ""
            }
            buttonbgAutoSuggestion.removeFromSuperview()
        }
        else {
            let Sirename = autocompleteUrls2.object(at:indexPath.row) as? String
            let Sirename1 = autocompleteUrlsbullname.object(at:indexPath.row) as? String
            sireIdTextField.text  = Sirename ?? ""
          //  sireIAuTextField.text  = Sirename1 ?? ""
            autoSuggestionStatus = true
            buttonbgAutoSuggestion.removeFromSuperview()
            sireIdValidationB = false
            sireIdTextField.layer.borderColor = UIColor(displayP3Red: 57/255, green: 69/255, blue: 73/255, alpha: 1).cgColor
            self.damtexfield.becomeFirstResponder()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == importTblView {
            return 100
        }
        
        if tableView == AutoSuggestionTableView {
            return 44
        }
        
        return 44
    }
}
