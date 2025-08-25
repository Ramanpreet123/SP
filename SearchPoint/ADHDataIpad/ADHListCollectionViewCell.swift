//
//  ADHListCollectionViewCell.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 07/04/25.
//

import Foundation
import UIKit

//MARK: ADH LIST CELL
class ADHListCollectionViewCell: UICollectionViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var addBarcodeBtn: UIButton!
    @IBOutlet weak var bckroundView: UIView!
    @IBOutlet weak var officialView: UIView!
    @IBOutlet weak var onFarmIdTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!
  
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officalIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel! 
      
    @IBOutlet weak var fourthTitleLbl: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var scanBarCodeButton: UIButton!
    @IBOutlet weak var txtFldBarCode: UITextField!
    @IBOutlet weak var scanBarCodeTextField: UITextField! {
        didSet{
          scanBarCodeTextField.keyboardType = .numbersAndPunctuation
        }
    }
    @IBOutlet weak var barCodeTextView: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    
    //MARK: VARIABLES AND CONSTANTS
    var addBarcodeAction:((_ string: String?) -> Void)?
    var isReload = false
    var coreDataModel: AnimalMaster?
    var data: AnimalMaster? {
        didSet {
            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            switch pvid {
            case 1,2,3,4,8,10,11,12 :
                onFarmIdTitleLbl.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                self.onFarmIdLbl.text = data?.farmId
                
            case 5,6,7:
                onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.onFarmIdLbl.text = data?.earTag
            default:
                break
            }
            
            self.officalIdLbl.text  = data?.animalTag
            
            if data?.isADHSelected == true && data?.animalbarCodeTag != "" {
                self.addBarcodeBtn.setImage(UIImage(named: "selectedBarcodeImg"), for: .normal)
            } else if data?.animalbarCodeTag == "" {
                self.addBarcodeBtn.setImage(UIImage(named: "addBarcodeImg"), for: .normal)
            }
            else {
                self.addBarcodeBtn.setImage(UIImage(named: "unselectedBarcodeImg"), for: .normal)
            }
            self.updateConstraintsIfNeeded()
            
            
            
        }
    }
    var expandCell: AnimalMaster? {
        didSet {
            if data?.animalbarCodeTag == "" {
                self.barCodeTextView.isHidden = false
            }else {
                self.barCodeTextView.isHidden = true
            }
        }
    }
    var delegate: ADHCellProtocol?
    var showBarcodeDelegate : ADHBarcodeView?
    
    //MARK: UI METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    
    func setAnimalData(animalData: AnimalMaster, index: Int) {
        // This method is intentionally left empty.
        // It will be implemented in the future to handle navigation logic.
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let barCode = textField.text, barCode != "" else {
            return
        }
        self.data?.animalbarCodeTag = barCode
    }
    
    override func layoutSubviews() {
        if isReload {
            self.barCodeTextView.isHidden = false
            self.scanBarCodeTextField?.becomeFirstResponder()
        }
    }
    
    @objc func acnScanButton() {
        barcodeScreen = true
    }
    @IBAction func addBarcodeAction(_ sender: Any) {
        self.addBarcodeAction?("")
    }
}

