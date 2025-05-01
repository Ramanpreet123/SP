//
//  SampleTrackingDeetailCellIpad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 29/04/25.
//

import Foundation
import UIKit

class SampleTrackingDeetailCellIpad: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var orderIdBttn: UIButton!
    @IBOutlet weak var officialIdTitleLabel: UILabel!
    @IBOutlet weak var officialIDLbl: UILabel!
    @IBOutlet weak var onFarmIdTitleLabel: UILabel!
    @IBOutlet weak var onFarm_IDLbl: UILabel!
    @IBOutlet weak var barcodeTitleLabel: UILabel!
    @IBOutlet weak var barcode_Lbl: UILabel!
    @IBOutlet weak var tableInnerview: UIView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productInProgress: UILabel!
    @IBOutlet weak var earTagLbl: UILabel!

    var sampleDetails = [SampleDetails]()
    var isActionRequired = Bool()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadProductData(sampleDetails: [SampleDetails], isActionRequired: Bool){
        self.isActionRequired = isActionRequired
        self.sampleDetails = sampleDetails
        productCollectionView.reloadData()
        updateCollectionViewHeight()
    }
    
    func updateCollectionViewHeight() {
            let rows = ceil(Double(self.sampleDetails.count) / 2.0)
            let itemHeight: CGFloat = 160
            let spacing: CGFloat = 20
            let totalHeight = (itemHeight * CGFloat(rows)) + (spacing * CGFloat(rows + 1))
            collectionViewHeightConstraint.constant = totalHeight
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sampleDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : SampleTrackDetailCollectionCell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "SampleTrackDetailCollectionCell", for: indexPath as IndexPath) as! SampleTrackDetailCollectionCell
        
        cell.productTitle.text = self.sampleDetails[indexPath.row].productName
        if self.sampleDetails[indexPath.row].status != "" && self.sampleDetails[indexPath.row].status != nil{
            cell.statusValue.text = self.sampleDetails[indexPath.row].status
        } else if self.sampleDetails[indexPath.row].status == "" || self.sampleDetails[indexPath.row].status == nil {
            cell.statusValue.text = "N/A"
        }
       
        
        if self.isActionRequired == false {
            if self.sampleDetails[indexPath.row].actionRequired != "" {
                cell.actionRequiredValue.text = self.sampleDetails[indexPath.row].actionRequired
            }  else if self.sampleDetails[indexPath.row].actionRequired == "" || self.sampleDetails[indexPath.row].actionRequired == nil {
                cell.actionRequiredValue.text = "N/A"
            }
            
            cell.actionRequiredTitle.isHidden = false
            cell.actionRequiredValue.isHidden = false
        }
        else {
            cell.actionRequiredTitle.isHidden = true
            cell.actionRequiredValue.isHidden = true
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.productCollectionView.frame.width/2) - 20, height: 160)
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
    
}

