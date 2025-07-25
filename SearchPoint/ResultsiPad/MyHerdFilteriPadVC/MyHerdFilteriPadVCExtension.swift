//
//  MyHerdFilteriPadVCExtension.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 04/06/25.
//

import Foundation
import UIKit

// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension MyHerdFilteriPadVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell.textLabel?.text = "BF"
        return cell
    }
}

// MARK: - COLLECTIONVIEW DATASOURCE AND DELEGATES
extension MyHerdFilteriPadVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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
            return CGSize(width: collectionViewSizeWidth/4 , height: 50)
        }
        let collectionViewSizeWidth = collectionView.frame.size.width
        return CGSize(width: (collectionViewSizeWidth/3) - 10, height: 55)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .pad {
            return 15
            
        }
        else {
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
 
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
       
        if collectionView == breedCollectionvIEW {
            let cell  = breedCollectionvIEW.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.adhFilterBreedCellId, for: indexPath as IndexPath) as! ADHFilterBreedCell
            UserDefaults.standard.set(breedIndexPath, forKey: keyValue.breedIndex.rawValue)
            if breedIndexPath == 0 && !isHerditySelected{
                UserDefaults.standard.set(self.breedArray[breedIndexPath], forKey: keyValue.breedName.rawValue)
            }
            cell.breedTitle.text = self.breedArray[indexPath.row]
//            cell.breedTitle.layer.borderWidth = 0.5
//            cell.breedTitle.layer.borderColor = UIColor.gray.cgColor
//            cell.breedTitle.radiusOfCorner = 17
//            cell.radiusOfCorner = 17
            
            if let selectedBreedName = UserDefaults.standard.value(forKey: keyValue.breedName.rawValue) as? String {
                let breeds = selectedBreedName.components(separatedBy: ",")
                if breeds.contains(self.breedArray[indexPath.row]){
                    cell.breedTitle.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
                    cell.breedTitle.textColor = UIColor.white
                    cell.breedTitle.layer.borderWidth = 0
                } else {
                    cell.breedTitle.backgroundColor = UIColor.white
                    cell.breedTitle.textColor = UIColor.black
                    cell.breedTitle.layer.borderWidth = 2
                }
            }
            return cell
        }
        let cell  = providerCollectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.adhFilterBreedCellId, for: indexPath as IndexPath) as! ADHFilterBreedCell
          cell.providerTitle.text = self.productArray[indexPath.row]
          cell.providerTitle.backgroundColor = .clear
          cell.providerTitle.textColor = .black
//          cell.radiusOfCorner = 17
//          cell.layer.borderWidth = 0.5
//          cell.layer.borderColor = UIColor.gray.cgColor
        let providerID = self.providerIDArray[indexPath.row]
        if providerID == 4 || providerID == 8{
            self.breedMainViewHeight.constant = 100.0
        } else {
            self.breedMainViewHeight.constant = 145.0

        }
          return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == providerCollectionView {
            guard let cell = providerCollectionView.cellForItem(at: indexPath) as? ADHFilterBreedCell else {
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
                 //   breedCollectionViewHeight.constant = CGFloat(height)
                } else {
                    let height = ((breedArray.count / 2) * 50) + 50
                 //   breedCollectionViewHeight.constant = CGFloat(height)
                }
            } else {
               // breedCollectionViewHeight.constant = 50
            }
            
            cell.providerTitle.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
            cell.providerTitle.textColor = UIColor.white
            cell.providerTitle.layer.borderColor = UIColor.clear.cgColor
          //  cell.radiusOfCorner = 17
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
            guard let cell = breedCollectionvIEW.cellForItem(at: indexPath) as? ADHFilterBreedCell else {
                return
            }
            
            if cell.isSelected == true {
                cell.breedTitle.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
                cell.breedTitle.textColor = UIColor.white
                cell.breedTitle.layer.borderWidth = 0
//                cell.breedTitle.radiusOfCorner = 17
//                cell.radiusOfCorner = 17
                breedIndexPath = indexPath.row
                delegate?.breedInfoUpdate(index: indexPath.row)
                breedCollectionvIEW.reloadData()
            }
        }
    }
    
    func showIsHerdity(_ show: Bool) {
     //   lblHerditySeperator.isHidden = !show
     //   herdityViewHeight.constant = show ? 50 : 0
//        if let superView = lblIsHerdity.superview {
//            superView.isHidden = !show
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == providerCollectionView {
            guard let cell = providerCollectionView.cellForItem(at: indexPath as IndexPath) as? ADHFilterBreedCell else {
                return
            }
            cell.providerTitle.textColor = UIColor.black
            cell.providerTitle.backgroundColor = UIColor.white
            cell.providerTitle.layer.borderColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
        }
        
        if collectionView == breedCollectionvIEW {
            guard let cell = breedCollectionvIEW.cellForItem(at: indexPath as IndexPath) as? ADHFilterBreedCell else {
                return
            }
            cell.breedTitle.backgroundColor = UIColor.white
            cell.breedTitle.textColor = UIColor.black
        }
    }
}
