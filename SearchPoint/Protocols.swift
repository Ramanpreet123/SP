//
//  Protocols.swift
//  SearchPoint
//
//  Created by Mobile Programming on 30/11/23.
//

import Foundation

// MARK: - PROTOCOLS

protocol SideMenuUI {
    func changeCornerRadius(val:Int)
}

protocol QrScannerProtocol {
    func qrCodeScannedResult(_ qrValue: String)
    
}


protocol CustomCamVCDelegate {
    func imageCaptured( _ image: UIImage)
}

protocol scannedOCRProtocol {
    func ocrDetected(_ scannedResult: String)
}

protocol ValidateDeviceControllerDelegate:  AnyObject {
    func validateCodeSuccess()
}

protocol offlineCustomView1 {
    func crossBtn()
}

protocol syncApiOffline{
    func failWithErrorOffline(statusCode:Int)
    func failWithErrorInternalOffline()
    func didFinishApiOffline(response: String)
    func failWithInternetConnectionOffline()
}

protocol ResponseDelegate {
   func responseRecieved(_ data:Data?,status:Bool)

}

protocol AnimalMergeProtocol: AnyObject {
    func refreshUI()
}

@objc protocol objectPickCartScreen {
    func objectGetOnSelection(temp:Int)
    @objc optional func anOptionalMethod(check :Bool)
}

protocol syncApi{
    func failWithError(statusCode:Int)
    func failWithErrorInternal()
    func didFinishApi(response: String)
    func failWithInternetConnection()
}

protocol updateDataEntryListDelegate{
  func refreshList()
    func navigateToMergeList(listName : String, descText : String)
}

protocol UpdateGroupsName{
  func refreshList()
}


protocol UpdateView {
    func responseRecievedStatus(value:String)
   
}

protocol filterInfoUpdate : AnyObject{
  func genderInfoUpdate(sex:String, providerIndexPath: Int, breedIndexPath: Int, fromdatevalue : String , todatevalue : String,header: String,trait: String)
  func breedInfoUpdate(index:Int)
  func providerInfoUpdate(index:Int)
  func dateInfoUpdate(date:String)
  func reloaddata()
  func dissmissbackcall()
  func cancelPressed()
  func tablereload()
  func breednameset()
  
}

protocol chosseProviderDelegate{
  func selectedProviderIndex(providerName:String)
}

protocol ResultTypeSelectionDelegate {
    func selectedIndex(index:Int)
}

protocol swipeCell {
    func swipeLeft(index:Int)
    func swipeRight(index:Int)
}

@objc protocol objectPickforcellDelegate {
    func selectionObjectcell(check :Bool)
}

protocol BillingDelegate {
    func updateUI(selectedBillingCustomer:GetBillingContact)
    func updateUIForButtonTitle()
}

@objc protocol objectPickfromConfilict {
    @objc optional func selectionObject(check :Bool)
    @objc optional func dataReload(check :Bool)
    @objc optional func firstLevel(check:Bool)
}

protocol CustomTableViewCellDelegate {
    func didToggleRadioButton(_ indexPath: IndexPath)
}

@objc protocol DismissConflictPopUp {
    func updateDismissUI()
}

protocol ADHBarcodeView {
    func showBarcodeView(isHidden : Bool?)
}


@objc protocol ImportListProtocol {
    func importList(listNameString: String, listId: Int)
}

protocol ADHFilterProtocol {
  func applyFilterData(fromDate: String, toDate: String, gender: String, breed: String)
}

protocol ADHCellProtocol {
    func barCodeEntered(_ animalData: AnimalMaster)
    func textField(editingDidBeginIn cell: ADHListCell)
    func textField(editingChangedInTextField newText: String, in cell: ADHListCell)
    func textFieldEndedEditing(finalText barCode: String, in cell: ADHListCell)
    func openCamForBarCodeScan(_ cell: ADHListCell)
}

protocol ResponseDataCollectorApi {
    func responseRecievedStatus(status:Bool)
}


protocol CustomersListControllerDelegate: AnyObject {
    func selectedCustomer(selectedCustomer: GetCustomer?, isForSingleUser: Bool)
}

protocol InheritQuestionaireControllerDelegate: AnyObject {
    func inheritQuestionaireControllerDismissed()
}

protocol ResponseValidateDeviceApi: AnyObject {
    func responseRecievedStatusForValidateDevice(status:Bool, response : ValidateDeviceModel?)
}

protocol TermsConditionViewModelDelegate: AnyObject {
    func responseRecieved(status:Bool)
}

protocol ResultFoundDelegate {
    func resultStatus(status:Bool)
}


