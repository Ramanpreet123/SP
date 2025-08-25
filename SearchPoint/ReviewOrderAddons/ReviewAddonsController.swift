//
//  ReviewAddonsController.swift
//  SearchPoint
//
//

import UIKit

//MARK: REVIEW ADDON CONTROLLER
class ReviewAddonsController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var addonsCollectionView: UICollectionView!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    @IBOutlet weak var addOnsProductLbl: UILabel!
    
    //MARK: VARIABLES AND CONSTANTS
    var addonsArray = [SubProductTbl]()
    var addonsArrayBeef = [SubProductTblBeef]()
    var animalTag = String()
    var animalId = Int()
    var productId = Int()
    var userId = Int()
    var orderId = Int()
    var orderIdBeef = Int()
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        addOnsProductLbl.text = NSLocalizedString(ButtonTitles.addOnProdText, comment: "")
        userId = UserDefaults.standard.integer(forKey: keyValue.userId.rawValue)
        orderId = UserDefaults.standard.integer(forKey: keyValue.orderId.rawValue)
        orderIdBeef = UserDefaults.standard.integer(forKey: keyValue.orderIdBeef.rawValue)
        addonsCollectionView.delegate = self
        addonsCollectionView.dataSource = self
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            self.addonsArrayBeef =  (fetchSubProductDataTrueBeef(entityName:Entities.subProductBeefTblEntity,productId: Int(productId),animalTag: animalTag, status: "true",orderId:orderIdBeef,userId:userId) as? [SubProductTblBeef])!
            if addonsArrayBeef.count <= 2 {
                viewHeight.constant = 130
            } else if addonsArrayBeef.count <= 4 {
                viewHeight.constant = 180
            }
            else if addonsArrayBeef.count <= 6 {
                viewHeight.constant = 250
            }
            else  {
                viewHeight.constant = 300
            }
            
        } else {
            self.addonsArray = ((fetchSubProductDataDairyreview(productId: Int(productId),animalTag: animalId,orderId:orderId,userId:userId, status: "true") as? [SubProductTbl])!)
            
               if addonsArray.count <= 2 {
                     viewHeight.constant = 130
                 } else  if addonsArray.count <= 4 {
                     viewHeight.constant = 180
                 }
                 else if addonsArray.count <= 6 {
                     viewHeight.constant = 250
                 }
                 else  {
                     viewHeight.constant = 300
                 }
        }
        addonsCollectionView.reloadData()
    }
    
    //MARK: IB ACTIONS
    @IBAction func crossClick(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        self.addonsCollectionView.isHidden = true
    }
    
    //MARK: COLLECTIONVIEW DATASOURCE AND DELEGATES
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            return self.addonsArrayBeef.count
        }
        return self.addonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addonsCollectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addonsCellId, for: indexPath as IndexPath) as! ReviewAddonsCell
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            let addon = self.addonsArrayBeef[indexPath.row]
            cell.addontitle.text = addon.adonName
        }
        else {
            let addon = self.addonsArray[indexPath.row]
            cell.addontitle.text = addon.adonName
        }
        return cell
    }
      
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 160.0, height: 40)
    }
}
