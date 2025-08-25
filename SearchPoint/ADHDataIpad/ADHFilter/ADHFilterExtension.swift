
//
//  ADHF.swift
//  SearchPoint
//
//  Created by Rajni on 08/04/25.
//

import Foundation
import UIKit

//MARK: COLLECTIONVIEW DATASOURCE AND DELEGATES
extension ADHFilteriPadVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == breedCollectionvIEW {
            return breedArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == breedCollectionvIEW {
            let collectionViewSizeWidth = collectionView.frame.size.width
            return CGSize(width: collectionViewSizeWidth/3 - 20 , height: 50)
        }
        
        return CGSize(width: 150, height: 40)
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
        let cell  = breedCollectionvIEW.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.adhFilterBreedCellId, for: indexPath as IndexPath) as! ADHFilterBreedCell
        cell.breedTitle.text = self.breedArray[indexPath.row]
        cell.breedTitle.layer.borderWidth = 0.5
        cell.breedTitle.layer.borderColor = UIColor.gray.cgColor
        cell.breedTitle.radiusOfCorner = 17
        cell.radiusOfCorner = 17
        
        if breedIDArray[indexPath.row] == breedID {
            breedIndexPath = indexPath.row
            cell.breedTitle.backgroundColor = UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0)
            cell.breedTitle.textColor = UIColor.white
            cell.breedTitle.layer.borderWidth = 0.0
        } else{
            cell.breedTitle.backgroundColor = UIColor.white
            cell.breedTitle.textColor = UIColor.black
            cell.breedTitle.layer.borderWidth = 2.0
            cell.breedTitle.layer.borderColor =  UIColor(red: 57/255, green: 69/255, blue: 73/255, alpha:1.0).cgColor
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        breedIndexPath = indexPath.row
        breedID = breedIDArray[indexPath.row]
        breedCollectionvIEW.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
      
      
    }
}

//MARK: OBJC SELECTOR AND UI METHODS
extension ADHFilteriPadVC {
    @objc func doneClick() {
        let formatterADH = DateFormatter()
        formatterADH.dateFormat = DateFormatters.MMddyyyyFormat
        let selectedDateADH = formatterADH.string(from: datePicker.date)
        if bttnTagClass == 0 {
            dateFromBttn.setTitle(selectedDateADH, for: .normal)
            fromDateDateFormat = datePicker.date
        }
        else {
            toDateDateFormat = datePicker.date
            let isLessThan = fromDateDateFormat.isSmallerThan(toDateDateFormat)
            
            if !isLessThan  {
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
                return
            }
            dateToBttn.setTitle(selectedDateADH, for: .normal)
        }
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        
        if UserDefaults.standard.value(forKey: keyValue.fromdate.rawValue) as! String != "" {
            UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
            let dateFormatter1 = DateFormatter()
            dateFormatter1.dateStyle = .medium
            dateFormatter1.timeStyle = .none
            dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
            
            if bttnTagClass == 0{
                let dateToNw = dateToBttn.titleLabel?.text ?? ""
                toDateClass = dateFormatter3.date(from: dateToNw)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateFromBttn.setTitle(selectedDate, for: .normal)
                fromDate = dateFormatter3.date(from: selectedDate)!
                let isLessThan = fromDate.isSmallerThan(toDateClass)
                if isLessThan {
                    dateFrom  = selectedDate
                    dateTo = selectedDate
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
                }
            }
            else{
                let dateFromNw = dateFromBttn.titleLabel?.text ?? ""
                fromDate = dateFormatter3.date(from: dateFromNw)!
                if UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM"{
                    dateFormatter3.dateFormat = DateFormatters.MMddyyyyFormat
                } else {
                    dateFormatter3.dateFormat = DateFormatters.ddMMyyyyFormat
                }
                
                let selectedDate = dateFormatter3.string(from: datePicker.date)
                dateToBttn.setTitle(selectedDate, for: .normal)
                toDateClass = dateFormatter3.date(from: selectedDate)!
                let isLessThan = fromDate.isSmallerThan(toDateClass)
                
                if isLessThan {
                    dateFrom  = selectedDate
                    dateTo = selectedDate
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: ""))
                }
            }
            self.datePicker.resignFirstResponder()
            datePicker.isHidden = true
            self.toolBar.isHidden = true
            calenderView.isHidden = true
            calendarViewBkg.isHidden = true
        }
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    
    //MARK: INITIAL UI METHODS
    func setUIOnDidLoad(){
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        self.breedCollectionvIEW?.collectionViewLayout = layout
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        UserDefaults.standard.setValue(true, forKey: keyValue.sortOrder.rawValue)
        byDefaultValueSet()
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        self.filterBackroundView.isHidden = false
        self.filterView.isHidden = false
        self.innerview.isHidden = false
      //  self.scroolingview.isHidden = false
        providerIndexPath = 0
        setupLanguage()
        getToDateFromDate()
        let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        let fetchBreeds = fetchBreedData(entityName: Entities.getBreedsTblEntity, provId: pvid)
        
        if fetchBreeds.count != 0 {
            breedArray.removeAll()
            for i in 0 ..< fetchBreeds.count{
                let obj = fetchBreeds[i] as! GetBreedsTbl
                let getProductName = obj.breedName ?? ""
                breedArray.append(getProductName)
                breedIDArray.append(obj.breedId ?? "")
            }
        }
        breedArray = breedArray.removeDuplicates()
        breedIDArray = breedIDArray.removeDuplicates()
        
        if !UserDefaults.standard.bool(forKey: keyValue.ADHFilterApplied.rawValue) {
            breedID = UserDefaults.standard.value(forKey: keyValue.breed.rawValue) as? String ?? ""
        }  else {
            let breedindex = UserDefaults.standard.integer(forKey: keyValue.breedindexADH.rawValue)
            if(breedIDArray.count>0){
                breedID = breedIDArray[breedindex]
            }
        }
    }
    
    func setupLanguage() {
        lblDaterangeTitle.text = NSLocalizedString(ButtonTitles.dateRangeText, comment: "")
        lblGenderTitle.text = NSLocalizedString("Gender", comment: "")
        breedLbl.text = NSLocalizedString(ButtonTitles.breedText, comment: "")
        cancleBtnFilterScreenOutlet.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        clearFilterBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.clearFilterText, comment: ""), for: .normal)
        doneBtnFilterScreenOutlet.setTitle(NSLocalizedString(LocalizedStrings.doneStr.localized, comment: ""), for: .normal)
    }
}

