//
//  ReviewOrderItemCelliPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 24/02/25.
//

import Foundation
import UIKit

class ReviewOrderItemCelliPad:UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    @IBOutlet weak var sectionTitle:PaddingLabel!
    @IBOutlet weak var addOnCollectionView:UICollectionView!
    
    @IBOutlet weak var addOnCollectionViewHeight: NSLayoutConstraint!
    var addonsArray = [SubProductTbl]()
    var addonsArrayBeef = [SubProductTblBeef]()
    override func layoutSubviews() {
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as! String  == marketNameType.Beef.rawValue{
            return self.addonsArrayBeef.count
        }
        return self.addonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = addOnCollectionView.dequeueReusableCell(withReuseIdentifier: ClassIdentifiers.addonsCellId, for: indexPath as IndexPath) as! ReviewAddonsCell
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
        return CGSize(width: 140, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 10.0,left: 10.0,bottom: 15.0,right: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
        
    }
}
