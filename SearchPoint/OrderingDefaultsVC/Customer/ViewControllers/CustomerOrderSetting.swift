//
//  CustomerOrderSetting.swift
//  SearchPoint
//
//  Created by "" 11/06/20.
//

import Foundation

//MARK: CUSTOMER ORDER SETTINGS VC
class CustomerOrderSetting {
    
    //MARK: VARIABLES AND CONSTANTS
    var date: String? = ""
    var pvid: Int?
    var beefPvid: Int?
    var speciesName: String? = marketNameType.Dairy.rawValue
    var userId: Int?
    var customerId: Int?
    var isInhertDisabledForBrazil: Int?
    var isGlobalHD50DisabledForBrazil: Int?
    var settingDefault: String? = "false"
    var settingDone: String? = ""
    var nominatorSave: String? = ""
    var beefProductAdded: String? = "false"
    var providerName: String? = ""
    var screen: String? = ""
    var providerNameUS: String? = ""
    var speciesId: Int?
    var ocrScannerSelection :String?
    var beefScannerSelection :String?
    var keyboardPerfernece :String?
    var defaultDatePicker :String?
    
    //MARK: SAVE CUSTOMER ORDER SETTINGS
    func saveCustomerSetting() {
        if let date = UserDefaults.standard.value(forKey: keyValue.date.rawValue) as? String {
            self.date = date
        }
        self.pvid = UserDefaults.standard.integer(forKey: keyValue.providerID.rawValue)
        self.beefPvid = UserDefaults.standard.integer(forKey: keyValue.beefPvid.rawValue)
        if let name = UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String {
            self.speciesName = name
        }
        if let userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int {
            self.userId = userId
        }
        
        self.customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        self.isInhertDisabledForBrazil = UserDefaults.standard.integer(forKey: keyValue.isInhertDisabledForBrazil.rawValue)
        self.isGlobalHD50DisabledForBrazil = UserDefaults.standard.integer(forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
        self.settingDefault = UserDefaults.standard.value(forKey: keyValue.settingDefault.rawValue) as? String
        self.settingDone = nil
        
        if let settingDone = UserDefaults.standard.value(forKey: keyValue.settingDone.rawValue) as? String {
            self.settingDone = settingDone
        }
        
        if let nominatorSave = UserDefaults.standard.value(forKey: keyValue.nominatorSave.rawValue) as? String {
            self.nominatorSave = nominatorSave
        }
        
        if let beefProductAdded = UserDefaults.standard.value(forKey: keyValue.beefProductAdded.rawValue) as? String {
            self.beefProductAdded = beefProductAdded
        }
        
        if let providerName = UserDefaults.standard.value(forKey: keyValue.providerName.rawValue) as? String {
            self.providerName = providerName
        }
        
        if let screen = UserDefaults.standard.value(forKey: keyValue.screen.rawValue) as? String {
            self.screen = screen
        }
        
        if let providerNameUS = UserDefaults.standard.value(forKey: keyValue.providerNameUS.rawValue) as? String {
            self.providerNameUS = providerNameUS
        }
        
        if UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String  == marketNameType.Beef.rawValue && UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 13 || UserDefaults.standard.integer(forKey:keyValue.beefPvid.rawValue) == 5 {
            if let scanner =  UserDefaults.standard.value(forKey: keyValue.beefScannerSelection.rawValue) as? String{
                self.beefScannerSelection = scanner
            }
        }
        
        if let scanner =  UserDefaults.standard.value(forKey: keyValue.scannerSelection.rawValue) as? String{
            self.ocrScannerSelection = scanner
        }
        
        if let keyboardSelection =  UserDefaults.standard.value(forKey: keyValue.keyboardSelection.rawValue) as? String{
            self.keyboardPerfernece = keyboardSelection
        }
        
        if let defaultDatePicker =  UserDefaults.standard.value(forKey: keyValue.defaultDatePicker.rawValue) as? String{
            self.defaultDatePicker = defaultDatePicker
        }
        self.speciesId = UserDefaults.standard.integer(forKey: keyValue.speciesId.rawValue)
        
        let settingObject : [String: Any?] = [ "date": self.date ?? nil,
                                               "pvid": self.pvid ?? nil,
                                               "beefPvid": beefPvid ?? nil,
                                               "speciesName": speciesName ?? nil,
                                               "userId": userId ?? nil,
                                               "customerId": customerId ?? nil,
                                               "isInhertDisabledForBrazil": isInhertDisabledForBrazil ?? nil,
                                               "isGlobalHD50DisabledForBrazil" : isGlobalHD50DisabledForBrazil ?? nil,
                                               "settingDefault": settingDefault ?? nil,
                                               "settingDone": self.settingDone ?? nil,
                                               "nominatorSave": self.nominatorSave ?? nil,
                                               "beefProductAdded": self.beefProductAdded ?? nil,
                                               "providerName": self.providerName ?? nil,
                                               "screen": self.screen ?? nil,
                                               "providerNameUS": self.providerNameUS ?? nil,
                                               "speciesId":self.speciesId,
                                               "scannerSelection" : self.ocrScannerSelection,
                                               "beefUSscannerSelection" : self.beefScannerSelection ?? nil,
                                               "keyboardSelection" :self.keyboardPerfernece,
                                               "defaultDatePicker" :self.defaultDatePicker
        ]
        
        let customerSavedSetting = fetchCustomerOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: self.customerId ?? -100, userId: self.userId ?? 1) as! [OrderSettings]
        if customerSavedSetting.count > 0 {
            deleteCustomerOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: self.customerId ?? -100,userId: self.userId)
            insert(entity: Entities.orderSettingsTblEntity, attributeKey: nil, objectToSave: settingObject as [String : Any])
        } else {
            insert(entity: Entities.orderSettingsTblEntity, attributeKey: nil, objectToSave: settingObject as [String : Any])
        }
    }
    
    @discardableResult
    func isCustomerAlreadySettingExist() -> Bool {
        self.userId = UserDefaults.standard.value(forKey: keyValue.userId.rawValue) as? Int
        self.customerId = UserDefaults.standard.integer(forKey: keyValue.currentActiveCustomerId.rawValue)
        
        if let customerId = self.customerId,
           let userId = self.userId {
            let customerSavedSetting = fetchCustomerOrderSetting(entityName: Entities.orderSettingsTblEntity, customerId: customerId , userId: userId )
            
            guard  customerSavedSetting.count > 0 else {
                return false
            }
            
            if let customerSetting = customerSavedSetting[0] as? OrderSettings {
                self.date = customerSetting.date
                self.pvid = Int(customerSetting.pvid)
                self.beefPvid = Int(customerSetting.beefPvid)
                self.speciesName = customerSetting.speciesName
                self.userId = Int(customerSetting.userId)
                self.customerId = Int(customerSetting.customerId)
                self.isInhertDisabledForBrazil = Int(customerSetting.isInhertDisabledForBrazil)
                self.settingDefault = customerSetting.settingDefault
                self.settingDone = customerSetting.settingDone
                self.nominatorSave = customerSetting.nominatorSave
                self.beefProductAdded = customerSetting.beefProductAdded
                self.providerName = customerSetting.providerName
                self.screen = customerSetting.screen
                self.providerNameUS = customerSetting.providerNameUS
                self.speciesId = Int(customerSetting.speciesId)
                self.ocrScannerSelection = customerSetting.scannerSelection
                self.keyboardPerfernece = customerSetting.keyboardSelection
                self.isGlobalHD50DisabledForBrazil = Int(customerSetting.isGlobalHD50DisabledForBrazil)
                UserDefaults.standard.set(self.date, forKey: keyValue.date.rawValue)
                UserDefaults.standard.set(self.pvid, forKey: keyValue.providerID.rawValue)
                UserDefaults.standard.set(self.beefPvid, forKey: keyValue.beefPvid.rawValue)
                
                if speciesName == keyValue.clarifideCDCBUS.rawValue {
                    speciesName = marketNameType.Dairy.rawValue
                }
                
                UserDefaults.standard.set(self.speciesName, forKey: keyValue.name.rawValue)
                UserDefaults.standard.set(self.settingDefault, forKey: keyValue.settingDefault.rawValue)
                UserDefaults.standard.set(self.isInhertDisabledForBrazil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
                UserDefaults.standard.set(self.isGlobalHD50DisabledForBrazil, forKey: keyValue.isGlobalHD50DisabledForBrazil.rawValue)
                UserDefaults.standard.set(self.settingDone, forKey: keyValue.settingDone.rawValue)
                UserDefaults.standard.set(self.nominatorSave, forKey: keyValue.nominatorSave.rawValue)
                UserDefaults.standard.set(self.beefProductAdded, forKey: keyValue.beefProductAdded.rawValue)
                UserDefaults.standard.set(self.providerName, forKey: keyValue.providerName.rawValue)
                UserDefaults.standard.set(self.screen, forKey: keyValue.screen.rawValue)
                UserDefaults.standard.set(self.providerNameUS, forKey: keyValue.providerNameUS.rawValue)
                UserDefaults.standard.set(self.speciesId, forKey: keyValue.speciesId.rawValue)
                UserDefaults.standard.set(self.ocrScannerSelection, forKey: keyValue.scannerSelection.rawValue)
                UserDefaults.standard.set(self.keyboardPerfernece, forKey: keyValue.keyboardSelection.rawValue)
            }
            return true
        } else {
            return false
        }
    }
}
