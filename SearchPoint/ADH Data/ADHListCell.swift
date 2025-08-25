//
//  ADHListCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 14/06/22.
//

import UIKit

//MARK: ADH LIST CELL
class ADHListCell: UITableViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var bckroundView: UIView!
    @IBOutlet weak var officialView: UIView!
    @IBOutlet weak var onFarmIdTitleLbl: UILabel!
    @IBOutlet weak var officalIdTitleLbl: UILabel!{
        didSet {
            officalIdTitleLbl.text = NSLocalizedString(LocalizedStrings.officialIDText, comment: "")
        }
    }
    @IBOutlet weak var barcodeTitleLbl: UILabel!
    @IBOutlet weak var onFarmIdLbl: UILabel!
    @IBOutlet weak var officalIdLbl: UILabel!
    @IBOutlet weak var barcodeLbl: UILabel! {
        didSet{
            barcodeLbl.textColor = .darkGray
        }
    }
    @IBOutlet weak var fourthTitleLbl: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var scanBarCodeButton: UIButton!
    @IBOutlet weak var txtFldBarCode: UITextField!
    @IBOutlet weak var scanBarCodeTextField: UITextField! {
        didSet{
          scanBarCodeTextField.keyboardType = .numbersAndPunctuation
          scanBarCodeTextField.delegate = self
        }
    }
    @IBOutlet weak var barCodeTextView: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    //MARK: VARIABLES AND CONSTANTS
    var isReload = false
    var coreDataModel: AnimalMaster?
    var data: AnimalMaster? {
        didSet {
            let pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
            switch pvid {
            case 1,2,3,4,8,10,11,12 :
                onFarmIdTitleLbl.text = NSLocalizedString(LocalizedStrings.onFarmIdText, comment: "")
                self.onFarmIdLbl.text = data?.farmId
                officialView.isHidden = false
                
            case 5,6,7:
                onFarmIdTitleLbl.text = NSLocalizedString(ButtonTitles.earTagText, comment: "")
                self.onFarmIdLbl.text = data?.earTag
                officialView.isHidden = true
            default:
                break
            }
            
            self.officalIdLbl.text  = data?.animalTag
            if data?.animalbarCodeTag != "" {
                self.barView.isHidden =  false
                self.barcodeLbl.text = data?.animalbarCodeTag
                self.barCodeTextView.isHidden = true
            }  else if data?.showTextField ?? false && data?.animalbarCodeTag == ""  {
                scanBarCodeTextField.text = ""
                self.barCodeTextView.isHidden = false
            }
            else {
                self.barView.isHidden =  true
                self.barCodeTextView.isHidden = true
            }
            selectedView.isHidden = !(data?.isADHSelected)!
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
    
    //MARK: UI METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
        bckroundView.radiusOfCorner = 5
        scanBarCodeTextField.addPadding(.left(5))
        barCodeTextView.radiusOfCorner = 10
        barCodeTextView.addBorders(borderWidth: 0.5, borderColor: UIColor.gray.cgColor)
    }
    
    func setAnimalData(animalData: AnimalMaster, index: Int) {
        scanBarCodeTextField.addTarget(self, action: #selector(textFieldValueChanged(_:)), for: .editingChanged)
        scanBarCodeTextField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        scanBarCodeTextField.addTarget(self, action: #selector(editingEnded), for: .editingDidEnd)
        self.scanBarCodeButton.addTarget(self, action: #selector(acnScanButton), for: .touchUpInside)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        self.delegate?.openCamForBarCodeScan(self)
        barcodeScreen = true
    }
}

//MARK: TEXTFIELD DELEGATE
extension ADHListCell : UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      guard !string.isEmpty else {
          return true
      }
    let acceptableCharacters = LocalizedStrings.alphaNumericFormat
    let check  = acceptableCharacters.contains(string)
    if !check {
      return false
    }
    return true
}
    @objc func editingDidBegin() {
        delegate?.textField(editingDidBeginIn: self)
    }
    @objc func textFieldValueChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.textField(editingChangedInTextField: text, in: self)
        }
    }
    @objc func editingEnded(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.textFieldEndedEditing(finalText: text, in: self)
        }
    }
}

