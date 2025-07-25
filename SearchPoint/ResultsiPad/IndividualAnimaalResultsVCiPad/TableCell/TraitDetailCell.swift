//
//  TraitDetailCell.swift
//  SearchPoint
//
//  Created by Rajni on 22/05/25.
//

import Foundation
import UIKit
import CoreData


class TraitDetailCell: UITableViewCell {
    
    @IBOutlet weak var indexButton: UIButton!
    @IBOutlet weak var indexLbl: UILabel!
    @IBOutlet weak var showAllButton: UIButton!
    @IBOutlet weak var dropDownImgView: UIImageView!
    @IBOutlet weak var dropBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showButtonHeightConst: NSLayoutConstraint!
    weak var delegate: MyCollectionViewCellDelegate?
    var tableIndexPath: IndexPath?
    var resultsAdded = false
    var hideUnhideArray  = [String]()
    var reaultArrGet = [ResultTraitHeader]()
    var resultMasterGet = [ResultMasterTemplate]()
    var fetchMyHerdData = [ResultMyHerdData]()
    var MyHerdData = [ResultMyHerdData]()
    var myHerdArray = [ResultGroupsAnimals]()
    var tabTitles = String()
    var showAllBool = Bool()
    var dropDown = false
    var selectedProuductName = String()
    var searchByAnimal = UserDefaults.standard.bool(forKey: keyValue.searchByAnimal.rawValue)
    let selectedBreedID =  UserDefaults.standard.value(forKey: keyValue.selectedAnimalBreedID.rawValue) as? String ?? ""
    var productName = UserDefaults.standard.value(forKey: keyValue.selectedProviderName.rawValue) as? String ?? ""
    var custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
    var userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
   
    var showButton = [showAll]()
    override func awakeFromNib() {
        super.awakeFromNib()
       // showButtonHeightConst.constant = showAllBool ? 44 : 0
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func getTraitData(title:String){
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles,productName: selectedProuductName, searchByAnimal:searchByAnimal)
        
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                if fetchTempObj.count > 1{
                }
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                print("breedid = ",selectedBreedID)
                print(objFetch.breedFilter as Any)
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        if self.resultsAdded == false {
                            self.resultMasterGet.append(objFetch)
                        }
                        
                    } else {
                        
                    }
                } else {
                    if self.resultsAdded == false {
                        self.resultMasterGet.append(objFetch)
                    }
                }
            }
        }
        resultsAdded = true
    }
    @objc func hideBtnCellClick(_ sender: UIButton){
        let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
        let fetchZeroObj = resultMasterGet[myIndexPath.row]
        saveTraitValueHideWithIndex(entity: Entities.resultHideIndexTblEntity ,traitId: fetchZeroObj.traitId ?? "", customerId: custmerID , headerName: tabTitles, userId: userId ?? 0)
        fetchAllDataShowHide()
        if let indexPath = tableIndexPath {
                    delegate?.didTapHideButton(for: indexPath)
        }
       // guard let indexPath = myIndexPath else { return }
       // delegate?.didTapHideButton(for: myIndexPath as! IndexPath)
        self.collectionView.reloadData()
    }
    
    func fetchAllDataShowHide(){
        resultMasterGet.removeAll()
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: searchByAnimal) as! [ResultMyHerdData]
        let traitHeader = fetchAllData(entityName: Entities.resultTraitHeaderTblEntity)
        let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
        let tabT = hName.removeDuplicates()
       
        
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles, productName: selectedProuductName,searchByAnimal: searchByAnimal)
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                print("breedid = ",selectedBreedID)
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        self.resultMasterGet.append(objFetch)
                    }
                } else {
                    self.resultMasterGet.append(objFetch)
                }
                
            } else {
                reloadParentTableView()
                showAllBool = true
                showButtonHeightConst.constant = showAllBool ? 44 : 0
            }
        }
    }
    
    @IBAction func showAllButton(_ sender: UIButton) {
      //  let myIndexPath = sender.tag - 1
        let myIndexPath = NSIndexPath(row: sender.tag-1, section: 0)
        delegate?.didTapShowButton(for: myIndexPath as IndexPath)
        deleteRecordFromDatabase(entityName: Entities.resultHideIndexTblEntity)
        resultMasterGet.removeAll()
        custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID,searchFound: searchByAnimal) as! [ResultMyHerdData]
        let traitHeader = fetchAllData(entityName: Entities.resultTraitHeaderTblEntity)
        let hName : [String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
        let tabT = hName.removeDuplicates()
        let fetchTraitObj = fetchResultTraitIdGet(entityName: Entities.resultTraitHeaderTblEntity,species: marketNameType.Dairy.rawValue, headerName: tabTitles, productName: selectedProuductName, searchByAnimal: searchByAnimal)
        for i in 0 ..< fetchTraitObj.count {
            let productName = fetchTraitObj[i] as! ResultTraitHeader
            let traitId = productName.traitId
            let resultHideIndex = fetchResultTraitIdHideIndex(entityName: Entities.resultHideIndexTblEntity, headerName: tabTitles , userId: userId ?? 0, customerId: custmerID, traitId: traitId ?? "")
            
            if resultHideIndex.count == 0 {
                let fetchTempObj = fetchResultTraitIdTemplate1(entityName: Entities.resultMasterTemplateTblEntity,traitId: traitId ?? "")
                let objFetch = fetchTempObj.object(at: 0) as! ResultMasterTemplate
                print("breedid = ",selectedBreedID)
                let breedFilter : [String] = objFetch.breedFilter as! [String]
                if breedFilter.count > 0 {
                    let breedArray = breedFilter.filter{$0 == selectedBreedID}
                    if breedArray.count > 0{
                        self.resultMasterGet.append(objFetch)
                        reloadParentTableView()
                        showAllBool = false
                        showButtonHeightConst.constant = showAllBool ? 44 : 0
                    } else {
                        
                    }
                } else {
                    self.resultMasterGet.append(objFetch)
                    reloadParentTableView()
                    showAllBool = false
                    showButtonHeightConst.constant = showAllBool ? 44 : 0
                }
            }
        }
        collectionView.reloadData()
    }
    private func reloadParentTableView() {
           if let tableView = self.superview(of: UITableView.self) {
               tableView.beginUpdates()
               tableView.endUpdates()
           }
       }
    
}

extension TraitDetailCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultMasterGet.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IndexCardCell", for: indexPath) as! IndexCardCell
        cell.layer.cornerRadius = 18
        cell.contentView.layer.cornerRadius = 18
        cell.contentView.clipsToBounds = true
        cell.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 6
        cell.layer.masksToBounds = false
        cell.eyeButton.tag = indexPath.row
        cell.eyeButton.addTarget(self, action: #selector(hideBtnCellClick(_:)), for: .touchUpInside)
        cell.delegate = delegate
        cell.tableIndexPath = tableIndexPath
        let fetchZeroObj = resultMasterGet[indexPath.row]
        cell.titleLabel.text = fetchZeroObj.displayName
        if fetchZeroObj.displayName == ButtonTitles.redBreedText {
            cell.titleLabel.text = ButtonTitles.ayrShireText
        }
        let officalidmy = UserDefaults.standard.value(forKey: keyValue.myHerdOfficalid.rawValue)as? String
        let onfarmid = UserDefaults.standard.value(forKey: keyValue.myHerdOnfarmId.rawValue)as? String
        let fetchTempObj1 = fetchResultTraitIdPageApi(entityName: Entities.resultPageByTraitTblEntity,traitId: fetchZeroObj.traitId ?? "", onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
        if fetchTempObj1.count == 0 {
            let fetchnewvalue = fetchResultname(entityName: Entities.resultPageByTraitTblEntity,trait: fetchZeroObj.attributeName ?? "" ,onFarmId: onfarmid ?? "",officalId: officalidmy ?? "")
            if fetchnewvalue.count == 0
            {
                cell.titleLabel.text = fetchZeroObj.displayName
                cell.valueLabel.text = "N/A"
            }
            else
            {
                let newvalue1 = fetchnewvalue.object(at: 0) as? ResultPageByTrait
                if newvalue1?.trait == ButtonTitles.genomicSireText
                {
                    cell.titleLabel.text = ButtonTitles.sireText
                } else if newvalue1?.trait == ButtonTitles.genomicDamText{
                    cell.titleLabel.text = ButtonTitles.damText
                } else if newvalue1?.trait == ButtonTitles.genomicallyConfirmed{
                    cell.titleLabel.text = ButtonTitles.mgsText
                } else if newvalue1?.trait == ButtonTitles.naabGenomicallyConfirmed {
                    cell.titleLabel.text = ButtonTitles.mgsNaabText
                }
                else {
                    cell.titleLabel.text = newvalue1?.display
                }
                let existvalue = newvalue1?.numericFormat
                if existvalue == ""
                {
                    cell.valueLabel.text = newvalue1?.stringValue
                }
                else
                {
                    cell.valueLabel.text = existvalue
                }
            }
        }
        else {
            let fetchTraitValue = fetchTempObj1.object(at: 0) as? ResultPageByTrait
            let checkvalue = fetchTraitValue?.numericFormat
            if fetchTraitValue?.trait == ButtonTitles.genomicSireText
            {
                cell.titleLabel.text = ButtonTitles.sireText
            }
            else if fetchTraitValue?.trait == ButtonTitles.genomicDamText{
                cell.titleLabel.text = ButtonTitles.damText
            }
            else if fetchTraitValue?.trait == ButtonTitles.genomicallyConfirmed{
                cell.titleLabel.text = ButtonTitles.mgsText
            }
            else if fetchTraitValue?.trait == ButtonTitles.naabGenomicallyConfirmed {
                cell.titleLabel.text = ButtonTitles.mgsNaabText
            }
            else {
                cell.titleLabel.text = fetchTraitValue?.display
            }
            if checkvalue == ""
            {
                cell.valueLabel.text = fetchTraitValue?.stringValue
            }
            else
            {
                cell.valueLabel.text = checkvalue
            }
        }
    
      //  cell.configure(title: item.title, value: item.value)
        return cell
    }

    // Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 100)
    }
}
extension UIView {
    func superview<T>(of type: T.Type) -> T? {
        return superview as? T ?? superview?.superview(of: T.self)
    }
}
