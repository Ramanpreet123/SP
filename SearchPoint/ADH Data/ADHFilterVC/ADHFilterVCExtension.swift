//
//  ADHFilterVCExtension.swift
//  SearchPoint
//
//  Created by Mobile Programming on 09/03/24.
//

import Foundation
import UIKit

//MARK: COLLECTIONVIEW DATASOURCE AND DELEGATES
extension ADHFilterVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == breedCollectionvIEW {
            return breedArray.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == breedCollectionvIEW {
            let collectionViewSizeWidth = collectionView.frame.size.width
            return CGSize(width: (collectionViewSizeWidth / 2) - 10 , height: 40)
        }
        
        return CGSize(width: collectionView.frame.size.width  / 2, height: 40)
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
            cell.breedTitle.backgroundColor = UIColor(red: 29/255, green: 131/255, blue: 174/255, alpha:1.0)
            cell.breedTitle.textColor = UIColor.white
        } else{
            cell.breedTitle.backgroundColor = UIColor.white
            cell.breedTitle.textColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        breedIndexPath = indexPath.row
        breedID = breedIDArray[indexPath.row]
        breedCollectionvIEW.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // Intentionally left empty.
           // This delegate method is required by the protocol,
           // but we don’t need custom behavior here (for now).
      
    }
}

//MARK: OBJC SELECTOR AND UI METHODS
extension ADHFilterVC {
    @objc func doneClick() {
        let formatterADH = DateFormatter()
        formatterADH.dateFormat = DateFormatters.MMddyyyyFormat
        let selectedDateADH = formatterADH.string(from: datePicker.date)
        
        if bttnTagClass == 0 {
            dateFromBttn.setTitle(selectedDateADH, for: .normal)
            fromDateDateFormat = datePicker.date
        } else {
            toDateDateFormat = datePicker.date
            guard fromDateDateFormat.isSmallerThan(toDateDateFormat) else {
                showDateError()
                return
            }
            dateToBttn.setTitle(selectedDateADH, for: .normal)
        }
        
        hideDatePickerUI()
        
        if let fromDateStr = UserDefaults.standard.string(forKey: keyValue.fromdate.rawValue),
           !fromDateStr.isEmpty {
            UserDefaults.standard.setValue(keyValue.newKey.rawValue, forKey: keyValue.checkDate.rawValue)
            
            if bttnTagClass == 0 {
                handleFromDateSelection()
            } else {
                handleToDateSelection()
            }
            hideDatePickerUI()
        }
    }
    
    private func hideDatePickerUI() {
        datePicker.resignFirstResponder()
        datePicker.isHidden = true
        toolBar.isHidden = true
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
    }

    private func showDateError() {
        CommonClass.showAlertMessage(
            self,
            titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""),
            messageStr: NSLocalizedString(AlertMessagesStrings.fromDateSmallerThanDate, comment: "")
        )
    }

    private func configureFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = (UserDefaults.standard.string(forKey: keyValue.date.rawValue) == "MM")
            ? DateFormatters.MMddyyyyFormat
            : DateFormatters.ddMMyyyyFormat
        return df
    }

    private func handleFromDateSelection() {
        let dateFormatter = configureFormatter()
        
        if let dateToStr = dateToBttn.titleLabel?.text,
           let toDate = dateFormatter.date(from: dateToStr) {
            toDateClass = toDate
        }
        
        let selectedDateStr = dateFormatter.string(from: datePicker.date)
        dateFromBttn.setTitle(selectedDateStr, for: .normal)
        fromDate = dateFormatter.date(from: selectedDateStr) ?? datePicker.date
        
        guard fromDate.isSmallerThan(toDateClass) else {
            showDateError()
            return
        }
        
        dateFrom = selectedDateStr
        dateTo = selectedDateStr
    }

    private func handleToDateSelection() {
        let dateFormatter = configureFormatter()
        
        if let dateFromStr = dateFromBttn.titleLabel?.text,
           let fromDt = dateFormatter.date(from: dateFromStr) {
            fromDate = fromDt
        }
        
        let selectedDateStr = dateFormatter.string(from: datePicker.date)
        dateToBttn.setTitle(selectedDateStr, for: .normal)
        toDateClass = dateFormatter.date(from: selectedDateStr) ?? datePicker.date
        
        guard fromDate.isSmallerThan(toDateClass) else {
            showDateError()
            return
        }
        
        dateFrom = selectedDateStr
        dateTo = selectedDateStr
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
        self.scroolingview.isHidden = false
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
        lblGenderTitle.text = NSLocalizedString(ButtonTitles.sexTest, comment: "")
        breedLbl.text = NSLocalizedString(ButtonTitles.breedText, comment: "")
        lblStartDateTitle.text = NSLocalizedString(ButtonTitles.startDateText, comment: "")
        lblEndDateTitle.text = NSLocalizedString(ButtonTitles.endDateText, comment: "")
        cancleBtnFilterScreenOutlet.setTitle(NSLocalizedString("Cancel", comment: ""), for: .normal)
        clearFilterBtnOutlet.setTitle(NSLocalizedString(ButtonTitles.clearFilterText, comment: ""), for: .normal)
        doneBtnFilterScreenOutlet.setTitle(NSLocalizedString(LocalizedStrings.doneStr.localized, comment: ""), for: .normal)
    }
}
