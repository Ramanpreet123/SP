//
//  IndivisiusalAnimaletableViewMethods.swift
//  SearchPoint
//
//  Created by Rajni on 21/05/25.
//

import Foundation
import UIKit

extension IndividualAnimalResultsVCiPad: UITableViewDelegate,UITableViewDataSource,MyCollectionViewCellDelegate {
    func didTapShowButton(for tableIndexPath: IndexPath) {
        if expandedCells.contains(tableIndexPath) {
            expandedCells.remove(tableIndexPath)
        }
       // expandedCells.remove(tableIndexPath)
        indivisualTableView.beginUpdates()
        indivisualTableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.row == 0 {
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.notesCellIdentifier) as? NotesAndPhotosCell else { return UITableViewCell() }
//            return cell
//        }
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "animalCell") as? AnimalDetailCell else { return UITableViewCell() }
           cell.detailView.clipsToBounds = true
           cell.detailView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
           cell.detailView.layer.shadowOffset = CGSize(width: 0, height: 1)
           cell.detailView.layer.shadowOpacity = 0.7
           cell.detailView.layer.shadowRadius = 6
           cell.detailView.layer.masksToBounds = false
           self.populateAletalInformation(cell: cell)
           
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TraitDetailCell") as? TraitDetailCell else { return UITableViewCell() }
        cell.indexLbl.text = titleArray[indexPath.row-1]
        cell.tabTitles = titleArray[indexPath.row-1]
        cell.delegate = self
        cell.tableIndexPath = indexPath
        cell.selectedProuductName = self.selectedProuductName
        if searchbyAnimal {
            fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: true) as! [ResultMyHerdData]
        } else {
            fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: false) as! [ResultMyHerdData]
        }
      
        cell.getTraitData(title: cell.tabTitles)
        cell.collectionView.reloadData()
        cell.showAllButton.tag = indexPath.row
        cell.indexButton.tag = indexPath.row
       // cell.showAllBool[indexPath.row-1] = showButton[indexPath.row-1].show
        cell.indexButton.addTarget(self, action: #selector(DropDownButtonTouch(_:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 0{
//            return 70
//        }
        if indexPath.row == 0 {
            return 206
        }
        else {
           
                let state = traitStates[indexPath.row-1]
                let showButton = showButton[indexPath.row-1]
                if state.dropDown {
                    return 70
                } else {
                    let above = IndexPath(row: indexPath.row - 1, section: indexPath.section)
                    if expandedCells.contains(above) {
                        return 250
                    } else {
                        return 180
                    }
                   // return showButton.show ? 250 : 180
                    //return showButton.show ? 250 : 250
                }
          
//            else {
//                // Return a default height if the cell is not available yet
//                return 180
//            }
        }
            
            return 206
        }
    
    @objc func DropDownButtonTouch(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = indivisualTableView.cellForRow(at: indexPath) as? TraitDetailCell {
            traitStates[ sender.tag-1].dropDown.toggle()
            indivisualTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    func didTapHideButton(for indexPath: IndexPath) {
        let above = IndexPath(row: indexPath.row - 1, section: indexPath.section)
        expandedCells.insert(above) // Or toggle if you want collapse too
        indivisualTableView.beginUpdates()
        indivisualTableView.endUpdates()
        }
    
    
    
    func populateAletalInformation(cell:AnimalDetailCell){
        NotificationCenter.default.addObserver(self, selector: #selector(notificationRecevied(notification:)), name: NSNotification.Name(rawValue: LocalizedStrings.newDataToLoad), object: nil)
        if UserDefaults.standard.value(forKey: keyValue.groupDetails.rawValue) as? String == keyValue.groupName.rawValue{
            let onformid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue) as? String
            let officialID = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue) as? String
            let fetchnote = fetchResultnote(entityName: Entities.resultMyherdDataTblEntity ,onFarmID: onformid ?? "", customerId: custmerID, officialID: officialID ?? "") as! [ResultMyHerdData]
            if fetchnote.count > 0{
                let note = fetchnote[0]
                cell.earTagValueLbl.text = note.onFarmID != "" ? note.onFarmID : "N/A"
                cell.officialIdValueLbl.text = note.officialID != "" ? note.officialID : "N/A"
                cell.breadValueLbl.text = note.breed != "" ? note.breed : "N/A"
                
                if note.sex == "F"{
                    cell.genderValueLbl.text = ButtonTitles.femaleText.localized
                }
                else if note.sex  == "M"{
                    cell.genderValueLbl.text = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                
                let dob = note.dob ?? ""
                let dateonly = dob.components(separatedBy: " ")
                cell.dobValueLbl.text = dateonly[0]
                
                let resultValue = note.resultType != "" ? note.resultType : "N/A"
                cell.resultValueLbl.text = resultValue
                let datetext = note.orderDate ?? "N/A"
                if datetext != ""{
                    cell.orderDateValueLbl.text = datetext
                }
                else{
                    cell.orderDateValueLbl.text = "N/A"
                }
                notesTextView.text = note.notes
                if note.photos != nil {
                    self.profileImgView.image = UIImage(data: note.photos!)
                }
            }
            profileImgView.isHidden = true
          //  groupTitleLbl.text = groupNameExist
          //  cell.groupNameValueLbl.text = groupNameExist
//            if UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) == nil {
//                cell.groupNameValueLbl.text = "N/A"
//            }
//            else {
//                let groupValue = UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String != "NA" ? UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String : "N/A"
//            
//                let groupStatusValue = self.groupStatus
//                if groupStatusValue == "inactive" {
//                    cell.groupNameValueLbl.text = "N/A"
//                } else {
//                    if self.groupName != "" {
//                        cell.groupNameValueLbl.text = groupName
//                    } else {
//                        if groupValue == LocalizedStrings.inactiveStatus{
//                            cell.groupNameValueLbl.text = "N/A"
//                        }
//                        
//                        else{
//                            cell.groupNameValueLbl.text = groupValue
//                        }
//                    }
//                   
//                }
//             
//            }
            
            if self.groupStatus == "doller" && self.groupName != "" {
                self.groupBtnOutlet.setImage(UIImage(named: "dollar_orange"), for: .normal)
                cell.groupNameValueLbl.text = self.groupName
                
            } else if self.groupStatus == "ban" && self.groupName != "" {
                self.groupBtnOutlet.setImage(UIImage(named: "barnImageOrange"), for: .normal)
                cell.groupNameValueLbl.text = self.groupName
                
            } else {
                self.groupBtnOutlet.setImage(UIImage(named: "orangeResultsNA"), for: .normal)
                cell.groupNameValueLbl.text = "N/A"
            }
        }
        else{
            if getMyHerdArray.count != 0{
                animalID = getMyHerdArray[backScreenClickIndex].animalID
                cell.earTagValueLbl.text = getMyHerdArray[backScreenClickIndex].onFarmID != "" ? getMyHerdArray[backScreenClickIndex].onFarmID : "N/A"
                cell.officialIdValueLbl.text = getMyHerdArray[backScreenClickIndex].officialID != "" ?  getMyHerdArray[backScreenClickIndex].officialID : "N/A"
                cell.breadValueLbl.text = getMyHerdArray[backScreenClickIndex].breed != "" ?  getMyHerdArray[backScreenClickIndex].breed : "N/A"
                
                let datatext = getMyHerdArray[backScreenClickIndex].orderDate != "" ?  getMyHerdArray[backScreenClickIndex].orderDate : "N/A"
                if datatext != ""{
                    cell.orderDateValueLbl.text = datatext
                }
                else{
                    cell.orderDateValueLbl.text = "N/A"
                    
                }
                if getMyHerdArray[backScreenClickIndex].sex == "F"{
                    cell.genderValueLbl.text = ButtonTitles.femaleText.localized
                }
                else if getMyHerdArray[backScreenClickIndex].sex == "M"{
                    cell.genderValueLbl.text = NSLocalizedString(ButtonTitles.maleText, comment: "")
                }
                else{
                    cell.genderValueLbl.text = ButtonTitles.allText.localized
                }
                
                let dob = getMyHerdArray[backScreenClickIndex].dob ?? ""
                let dateonly = dob.components(separatedBy: " ")
                cell.dobValueLbl.text = dateonly[0]
//                providerChnageOutlet.titleLabel?.lineBreakMode = .byWordWrapping
//                providerChnageOutlet.titleLabel?.textAlignment = .center
//
                
                let resultValue = getMyHerdArray[backScreenClickIndex].resultType != "" ? getMyHerdArray[backScreenClickIndex].resultType : "N/A"
                cell.resultValueLbl.text = resultValue
//
                if UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) == nil {
                    cell.groupNameValueLbl.text = "N/A"
                }
                else {
                    let groupValue = UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String != "NA" ? UserDefaults.standard.value(forKey: keyValue.groupName.rawValue) as? String : "N/A"
                
                    let groupStatusValue = getMyHerdArray[backScreenClickIndex].status ?? "N/A"
                    if groupStatusValue == "inactive" {
                        cell.groupNameValueLbl.text = "N/A"
                    } else {
                        if self.groupName != "" {
                            cell.groupNameValueLbl.text = groupName
                        } else {
                            cell.groupNameValueLbl.text = groupValue
                        }
                    }
                }
                if getMyHerdArray[backScreenClickIndex].photos != nil {
                    self.profileImgView.image = UIImage(data: getMyHerdArray[backScreenClickIndex].photos!)
                }
            }
        }
    }
    
}


