//
//  MyHerdFilterControllerExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 01/03/24.
//

import Foundation
import UIKit

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension MyHerdFilterController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.text = "BF"
        return cell
    }
}

// MARK: - COLLECTIONVIEW DATASOURCE AND DELEGATES
extension MyHerdFilterController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == providerCollectionView {
            return productArray.count
        }
        if collectionView == breedCollectionvIEW {
            return breedArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == breedCollectionvIEW {
            let collectionViewSizeWidth = collectionView.frame.size.width
            return CGSize(width: (collectionViewSizeWidth / 2) - 10 , height: 40)
        }else {
            return CGSize(width: (collectionView.frame.size.width  / 2) -  10, height: 40)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        
        
        if collectionView == breedCollectionvIEW {
            let cell : MyHerdCollectionCell = breedCollectionvIEW.dequeueReusableCell(withReuseIdentifier: "breedCell", for: indexPath as IndexPath) as! MyHerdCollectionCell
            UserDefaults.standard.set(breedIndexPath, forKey: keyValue.breedIndex.rawValue)
            if breedIndexPath == 0 && !isHerditySelected{
                UserDefaults.standard.set(self.breedArray[breedIndexPath], forKey: keyValue.breedName.rawValue)
            }
            cell.breedTitle.text = self.breedArray[indexPath.row]
            cell.breedTitle.layer.borderWidth = 0.5
            cell.breedTitle.layer.borderColor = UIColor.gray.cgColor
            cell.breedTitle.radiusOfCorner = 17
            cell.radiusOfCorner = 17
            
            if let selectedBreedName = UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String {
                let breeds = selectedBreedName.components(separatedBy: ",")
                if breeds.contains(self.breedArray[indexPath.row]){
                    cell.breedTitle.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                    cell.breedTitle.textColor = UIColor.white
                } else {
                    cell.breedTitle.backgroundColor = UIColor.white
                    cell.breedTitle.textColor = UIColor.black
                }
            }
            return cell
        }
      let cell : MyHerdCollectionCell = providerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! MyHerdCollectionCell
          cell.providerTitle.text = self.productArray[indexPath.row]
          cell.providerTitle.backgroundColor = .clear
          cell.providerTitle.textColor = .black
          cell.radiusOfCorner = 17
          cell.layer.borderWidth = 0.5
          cell.layer.borderColor = UIColor.gray.cgColor
          return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == providerCollectionView {
            guard let cell = providerCollectionView.cellForItem(at: indexPath) as? MyHerdCollectionCell else {
                return
            }
            let productName = self.productArray[indexPath.row]
            let providerID = self.providerIDArray[indexPath.row]
            if providerID == 1 || providerID == 11 || providerID == 12 || providerID == 8 || providerID == 2 || providerID == 6 || providerID == 4  || providerID == 10 {
                selectedProductName = LocalizedStrings.clarifideCDCB
            } else if providerID == 3 {
                selectedProductName = LocalizedStrings.clarifideDataGene
            }
            selectedProviderName = productName
            selectedProviderID = Int(providerID)
            providerIndexPath = indexPath.row
            delegate?.providerInfoUpdate(index: indexPath.row)
            
            let fetchBreedsOnproviderID = fetchResultFilterDataWithProductid(entityName: Entities.resultFilterDataTblEntity, customerId: Int(custmerID), providerid: providerID)
            if fetchBreedsOnproviderID.count != 0 {
                breedArray.removeAll()
                breedIdArray.removeAll()
                for i in 0 ..< fetchBreedsOnproviderID.count{
                    let obj = fetchBreedsOnproviderID[i] as! ResultFilterData
                    let getProductName = obj.breedName ?? ""
                    let getProductId = obj.breedId ?? ""
                    breedIdArray.append(getProductId)
                    breedArray.append(getProductName)
                }
                
                breedArray = breedArray.removeDuplicates()
                breedIdArray = breedIdArray.removeDuplicates()
                breedCollectionvIEW.reloadData()
            }
            
            if breedArray.count > 2 {
                if breedArray.count % 2 == 0{
                    let height = ((breedArray.count / 2) * 50)
                    breedCollectionViewHeight.constant = CGFloat(height)
                } else {
                    let height = ((breedArray.count / 2) * 50) + 50
                    breedCollectionViewHeight.constant = CGFloat(height)
                }
            } else {
                breedCollectionViewHeight.constant = 50
            }
            
            cell.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            cell.providerTitle.textColor = UIColor.white
            cell.radiusOfCorner = 17
            let resultFIlterDataSave =  fetchResultFilterData1(entityName: Entities.resultFIlterDataSaveTblEntity,customerId: Int(custmerID),isheridity: isHerditySelected, productID: selectedProviderID)
            
            if productName == keyValue.USDairyProducts.rawValue {
                showIsHerdity(true)
                UserDefaults.standard.set("", forKey: keyValue.traitValue.rawValue)
                UserDefaults.standard.set("", forKey: keyValue.traitName.rawValue)
                if resultFIlterDataSave.count != 0 {
                    let resultObject = resultFIlterDataSave.object(at: 0) as! ResultFIlterDataSave
                    isHerditySelected = resultObject.isHeriditySelected
                }
            } else {
                UserDefaults.standard.set("", forKey: keyValue.traitValue.rawValue)
                UserDefaults.standard.set("", forKey: keyValue.traitName.rawValue)
                showIsHerdity(false)
                
                isProviderSelected = true
            }
            if resultFIlterDataSave.count > 0 {
                let resultObject = resultFIlterDataSave.object(at: 0) as! ResultFIlterDataSave
                if let breedName = resultObject.breedName {
                    let breeds = breedName.components(separatedBy: ",")
                    if breeds.count > 1 && !isHerditySelected{
                        UserDefaults.standard.set(breedArray[0], forKey: keyValue.breedName.rawValue)
                        UserDefaults.standard.set(breedIdArray[0], forKey: keyValue.resultBreedID.rawValue)
                        delegate?.breedInfoUpdate(index: 0)
                        breedIndexPath = 0
                        fetchTrailData(trailName: resultObject.traidsave ?? "", trailValue: resultObject.trait ?? "")
                    }
                }
            }
            updateProviderSelection()
        }
        
        if collectionView == breedCollectionvIEW {
            guard let cell = breedCollectionvIEW.cellForItem(at: indexPath) as? MyHerdCollectionCell else {
                return
            }
            
            if cell.isSelected == true {
                cell.breedTitle.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
                cell.breedTitle.textColor = UIColor.white
                cell.breedTitle.radiusOfCorner = 17
                cell.radiusOfCorner = 17
                breedIndexPath = indexPath.row
                delegate?.breedInfoUpdate(index: indexPath.row)
                breedCollectionvIEW.reloadData()
            }
        }
    }
    
    func showIsHerdity(_ show: Bool) {
        lblHerditySeperator.isHidden = !show
        herdityViewHeight.constant = show ? 50 : 0
        if let superView = lblIsHerdity.superview {
            superView.isHidden = !show
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == providerCollectionView {
            guard let cell = providerCollectionView.cellForItem(at: indexPath as IndexPath) as? MyHerdCollectionCell else {
                return
            }
            cell.backgroundColor = UIColor.white
            cell.providerTitle.textColor = UIColor.black
        }
        
        if collectionView == breedCollectionvIEW {
            guard let cell = breedCollectionvIEW.cellForItem(at: indexPath as IndexPath) as? MyHerdCollectionCell else {
                return
            }
            cell.breedTitle.backgroundColor = UIColor.white
            cell.breedTitle.textColor = UIColor.black
        }
    }
}
