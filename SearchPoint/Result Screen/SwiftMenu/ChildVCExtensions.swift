//
//  ChildVCExtensions.swift
//  SearchPoint
//
//  Created by Mobile Programming on 26/02/24.
//

import Foundation
import UIKit

// MARK: - TABLEVIEW DATASOURCE AND DELEGATE
extension ChildViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.resultMasterGet.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if scrollIndexGet == 1{
            if resultMasterGet.count + 1  == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customSecondCellIdentifier) as! CustomSecondCell
                cell.layer.backgroundColor = UIColor.red.cgColor
                cell.showAllButton.tag = indexPath.row
                cell.showAllButton.addTarget(self, action: #selector(showAllButton(_:)), for: .touchUpInside)
                
                let showAll = fetchResultTraitIdHideTitles(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles, userId: userId ?? 0, customerId: custmerID)
                if showAll.count == 0 {
                    cell.showAllButton.isHidden = true
                } else {
                    cell.showAllButton.isHidden = false
                }
                return cell
                
            }
            else if resultMasterGet.count == indexPath.row  && scrollIndexGet == 1{
                if UserDefaults.standard.value(forKey: keyValue.checkGroupIcon.rawValue) == nil {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                    cell.nameLbl.text = ButtonTitles.groupText
                    cell.buttonHide.isHidden = true
                    cell.barnBtn.isHidden = false
                    cell.dollarBtn.isHidden = false
                    cell.barnImage.isHidden = false
                    cell.dollarImage.isHidden = false
                    cell.threeDot.isHidden = true
                    cell.notAssignedBtn.isHidden = false
                    cell.notAssignedLbl.isHidden = false
                    cell.nameValueLbl.text = ""
                    checkCOntroller = UserDefaults.standard.value(forKey: keyValue.checkGroup.rawValue) as? String ?? ""
                    if checkCOntroller == keyValue.groupKey.rawValue{
                        let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
                        officalfetch = UserDefaults.standard.object(forKey: keyValue.myHerdOfficalid.rawValue) as! String
                        let getchekc = fetchGroupchildstatuscheck(entityName: Entities.resultMyherdDataTblEntity, customerId: custmerID, Onfarmid: onformid ?? "") as! [ResultMyHerdData]
                        let hardchekc = getchekc.filter{$0.officialID == officalfetch}
                        
                        if hardchekc.count != 0
                        {
                            let checkgroupstatus = hardchekc[0]
                            
                            let status = checkgroupstatus.status
                            if status == LocalizedStrings.banStatus{
                                cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            }else if status == LocalizedStrings.dollerStatus{
                                cell.dollarBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            }else {
                                cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                            }
                        }
                    }
                    else
                    {
                        if fetchMyHerdData.count > 0 {
                            let filterMyherdAnimal =  fetchMyHerdData.filter{$0.onFarmID == onformid}
                            if filterMyherdAnimal.count > 0 {
                                let animal = filterMyherdAnimal[0]
                                let status = animal.status
                                if status == LocalizedStrings.banStatus{
                                    cell.barnBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                                }else if status == LocalizedStrings.dollerStatus{
                                    cell.dollarBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                                }else {
                                    cell.notAssignedBtn.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
                                }
                            }
                        }
                    }
                    cell.barnBtn.tag = indexPath.row
                    cell.barnBtn.addTarget(self, action: #selector(barnBtnCellClick(_:)), for: .touchUpInside)
                    cell.dollarBtn.tag = indexPath.row
                    cell.dollarBtn.addTarget(self, action: #selector(dollarBtnBtnCellClick(_:)), for: .touchUpInside)
                    cell.notAssignedBtn.tag = indexPath.row
                    cell.notAssignedBtn.addTarget(self, action: #selector(notAssignedBtnClick(_:)), for: .touchUpInside)
                    return cell
                }
                else
                {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                    cell.barnBtn.isHidden = true
                    cell.dollarBtn.isHidden = true
                    cell.barnImage.isHidden = true
                    cell.dollarImage.isHidden = true
                    cell.threeDot.isHidden = false
                    cell.notAssignedBtn.isHidden = true
                    cell.notAssignedLbl.isHidden = true
                    return cell
                }
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                let fetchZeroObj = resultMasterGet[indexPath.row]
                cell.nameLbl.text = fetchZeroObj.displayName
                if fetchZeroObj.displayName == ButtonTitles.redBreedText {
                    cell.nameLbl.text = ButtonTitles.ayrShireText
                }
                
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
                    let onffid = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onformid ?? "",officalId: onffid ?? "" )
                    
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onformid ?? "",officalId: onffid ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                            } else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            } else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            } else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                            
                        } else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        } else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        } else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        } else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                else{
                    let officalidmy = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue)as? String
                    let onfarmid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue)as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                            } else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            } else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            } else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        }
                        else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                
                cell.buttonHide.isHidden = false
                let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: fetchZeroObj.traitId ?? "" )
                if resultHideIndex.count != 0 {
                    showAllBool = true
                }
                cell.barnBtn.isHidden = true
                cell.dollarBtn.isHidden = true
                cell.barnImage.isHidden = true
                cell.dollarImage.isHidden = true
                cell.threeDot.isHidden = false
                cell.notAssignedBtn.isHidden = true
                cell.notAssignedLbl.isHidden = true
                cell.buttonHide.tag = indexPath.row
                cell.buttonHide.addTarget(self, action: #selector(hideBtnCellClick(_:)), for: .touchUpInside)
                return cell
            }
        }
        else if UserDefaults.standard.value(forKey: keyValue.checkIndex.rawValue) as! Int == 9
        {
            if resultMasterGet.count + 1  == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                cell.nameLbl.text = ""
                cell.buttonHide.isHidden = true
                cell.barnBtn.isHidden = true
                cell.dollarBtn.isHidden = true
                cell.barnImage.isHidden = true
                cell.dollarImage.isHidden = true
                cell.threeDot.isHidden = true
                cell.notAssignedBtn.isHidden = true
                cell.notAssignedLbl.isHidden = true
                cell.nameValueLbl.text = ""
                return cell
            }
            else if resultMasterGet.count == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customSecondCellIdentifier) as! CustomSecondCell
                cell.layer.backgroundColor = UIColor.red.cgColor
                cell.showAllButton.tag = indexPath.row
                cell.showAllButton.addTarget(self, action: #selector(showAllButton(_:)), for: .touchUpInside)
                let showAll = fetchResultTraitIdHideTitles(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles, userId: userId ?? 0, customerId: custmerID)
                if showAll.count == 0 {
                    cell.showAllButton.isHidden = true
                } else {
                    cell.showAllButton.isHidden = false
                }
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                let fetchZeroObj = resultMasterGet[indexPath.row]
                cell.nameLbl.text = fetchZeroObj.displayName ?? ""
                if fetchZeroObj.displayName == ButtonTitles.redBreedText {
                    cell.nameLbl.text = ButtonTitles.ayrShireText
                }
  
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
                    let onffid = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onformid ?? "",officalId: onffid ?? "")
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onformid ?? "",officalId: onffid ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                                
                            } else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            } else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            } else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        }
                        else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                else
                {
                    let officalidmy = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue)as? String
                    let onfarmid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue)as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                    
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            }
                            else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                            
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        }
                        else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                cell.buttonHide.isHidden = false
                let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: fetchZeroObj.traitId ?? "" )
                if resultHideIndex.count != 0 {
                    showAllBool = true
                }
                cell.barnBtn.isHidden = true
                cell.dollarBtn.isHidden = true
                cell.barnImage.isHidden = true
                cell.dollarImage.isHidden = true
                cell.threeDot.isHidden = false
                cell.notAssignedBtn.isHidden = true
                cell.notAssignedLbl.isHidden = true
                cell.buttonHide.tag = indexPath.row
                cell.buttonHide.addTarget(self, action: #selector(hideBtnCellClick(_:)), for: .touchUpInside)
                return cell
            }
        }
        else
        {
            if resultMasterGet.count + 1  == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                cell.nameLbl.text = ""
                cell.buttonHide.isHidden = true
                cell.barnBtn.isHidden = true
                cell.dollarBtn.isHidden = true
                cell.barnImage.isHidden = true
                cell.dollarImage.isHidden = true
                cell.threeDot.isHidden = true
                cell.notAssignedBtn.isHidden = true
                cell.notAssignedLbl.isHidden = true
                cell.nameValueLbl.text = ""
                return cell
            }
            else if resultMasterGet.count == indexPath.row {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customSecondCellIdentifier) as! CustomSecondCell
                cell.layer.backgroundColor = UIColor.red.cgColor
                cell.showAllButton.tag = indexPath.row
                cell.showAllButton.addTarget(self, action: #selector(showAllButton(_:)), for: .touchUpInside)
                let showAll = fetchResultTraitIdHideTitles(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles, userId: userId ?? 0, customerId: custmerID)
                if showAll.count == 0 {
                    cell.showAllButton.isHidden = true
                } else {
                    cell.showAllButton.isHidden = false
                }
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.customCellIdentifier, for: indexPath) as! CustomCell
                let fetchZeroObj = resultMasterGet[indexPath.row]
                cell.nameLbl.text = fetchZeroObj.displayName ?? ""
                if fetchZeroObj.displayName == ButtonTitles.redBreedText {
                    cell.nameLbl.text = ButtonTitles.ayrShireText
                }
                
                if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
                    let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
                    let onffid = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onformid ?? "",officalId: onffid ?? "")
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onformid ?? "",officalId: onffid ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            }
                            else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        }
                        else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                else
                {
                    let officalidmy = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue)as? String
                    let onfarmid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue)as? String
                    let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                    
                    if fetchTempObj1.count == 0 {
                        let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
                        if fetchnewvalue.count == 0
                        {
                            cell.nameValueLbl.text = ""
                        }
                        else
                        {
                            let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                            if newvalue1?.trait == ButtonTitles.genomicSireText
                            {
                                cell.nameLbl.text = ButtonTitles.sireText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicDamText{
                                cell.nameLbl.text = ButtonTitles.damText
                            }
                            else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                                cell.nameLbl.text = ButtonTitles.mgsText
                            }
                            else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                                cell.nameLbl.text = ButtonTitles.mgsNaabText
                            }
                            else {
                                cell.nameLbl.text = newvalue1?.display
                            }
                            let existvalue = newvalue1?.numericFormat
                            if existvalue == ""
                            {
                                cell.nameValueLbl.text = newvalue1?.stringValue
                            }
                            else
                            {
                                cell.nameValueLbl.text = existvalue
                            }
                        }
                    }
                    else {
                        let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
                        let checkvalue = fetchTraitValue?.numericFormat
                        if fetchTraitValue?.trait == ButtonTitles.genomicSireText
                        {
                            cell.nameLbl.text = ButtonTitles.sireText
                            
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                            cell.nameLbl.text = ButtonTitles.damText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                            cell.nameLbl.text = ButtonTitles.mgsText
                        }
                        else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                            cell.nameLbl.text = ButtonTitles.mgsNaabText
                        }
                        else {
                            cell.nameLbl.text = fetchTraitValue?.display
                        }
                        
                        if checkvalue == ""
                        {
                            cell.nameValueLbl.text = fetchTraitValue?.stringValue
                        }
                        else
                        {
                            cell.nameValueLbl.text = checkvalue
                        }
                    }
                }
                cell.buttonHide.isHidden = false
                let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: fetchZeroObj.traitId ?? "" )
                
                if resultHideIndex.count != 0 {
                    showAllBool = true
                    
                }
                cell.barnBtn.isHidden = true
                cell.dollarBtn.isHidden = true
                cell.barnImage.isHidden = true
                cell.dollarImage.isHidden = true
                cell.threeDot.isHidden = false
                cell.notAssignedBtn.isHidden = true
                cell.notAssignedLbl.isHidden = true
                cell.buttonHide.tag = indexPath.row
                cell.buttonHide.addTarget(self, action: #selector(hideBtnCellClick(_:)), for: .touchUpInside)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
