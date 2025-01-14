//
//  AppDelegate.swift
//  SearchPoint
//  Created by "" on 27/09/2019.
//  ""
//

import UIKit
import CoreData
import AKSideMenu
import IQKeyboardManagerSwift
import Alamofire
import UserNotifications
import Firebase
import Messages
import JNKeychain
import FirebaseMessaging
import FirebaseCore
import Messages
import DropDown
import Security



class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
    
    let gcmMessageIDKey = "gcm.Message_ID"
    var mobileVersionVM:MobileVersionViewModel?
    var orientationLock = UIInterfaceOrientationMask.landscape
    var window: UIWindow?
    var deleg : SideMenuUI?
    var switchFlag : Int = 0
    let maximumTime = 55
    var reachability : Reachability? = Reachability()
    var status :String?
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return self.orientationLock
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if UserDefaults.standard.value(forKey: keyValue.firstLogin.rawValue) == nil{
            _ = self.keychain_deleteObjectForKey("userName")
            _ = self.keychain_deleteObjectForKey("emailId")
            _ = self.keychain_deleteObjectForKey("password")
            
        }
        
        DropDown.startListeningToKeyboard()
        FirebaseApp.configure()
        Localizer.DoTheMagic()
        
        if UserDefaults.standard.bool(forKey:"Provider") == false {
            UserDefaults.standard.set(4, forKey: "radio1")
            UserDefaults.standard.set(2, forKey: "radio2")
            UserDefaults.standard.set(keyValue.farmId.rawValue, forKey: keyValue.screen.rawValue)
            UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
            UserDefaults.standard.set(1, forKey: keyValue.lngId.rawValue)
            UserDefaults.standard.set(keyValue.rfidKey.rawValue, forKey: keyValue.scannerSelection.rawValue)
            UserDefaults.standard.set(keyValue.ocrKey.rawValue, forKey: keyValue.beefScannerSelection.rawValue)
            UserDefaults.standard.set(keyValue.alphaNumericKeyboard.rawValue, forKey: keyValue.keyboardSelection.rawValue)
            
        }
        
        sleep(2)
        initialNetworkCheck()
        UserDefaults.standard.set(0, forKey: keyValue.orderSlideTag.rawValue)
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.toolbarConfiguration.placeholderConfiguration.showPlaceholder = false
        IQKeyboardManager.shared.enableAutoToolbar = true
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.badge]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _,_ in }
                
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.badge], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        let udidkEY =  getDeviceIdentifierFromKeychain()
        UserDefaults.standard.set(udidkEY, forKey: "DeviceId")
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(udidkEY, forKey: "ApplicationIdentifier")
        userDefaults.synchronize()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil)
        //Added Code to display notification when app is in Foreground
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        
        return true
    }
  
    func initialNetworkCheck() {
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        self.reachability = Reachability.forInternetConnection()
        self.reachability?.startNotifier()
        let remotehostStatus =  self.reachability?.currentReachabilityStatus()
        
        if((remotehostStatus?.rawValue) == 0) {
            
            self.status = NSLocalizedString("Not Connected", comment: "")
        }
        else {
            
            self.status = NSLocalizedString(ButtonTitles.connectedText, comment: "")
        }
    }
    
    @objc  func checkForReachability(notification:Notification){
        
        let remotehostStatus = self.reachability?.currentReachabilityStatus()
        
        if((remotehostStatus?.rawValue) == 0) {
            
            self.status = NSLocalizedString("Not Connected", comment: "")
        }
        else{
            
            self.status = NSLocalizedString(ButtonTitles.connectedText, comment: "")
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        let farmValue = UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String
        Constants.farmValue = farmValue
        let marketName = UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String
        Constants.marketName = marketName
        UserDefaults.standard.setValue(marketName, forKey: "speciesName")
        let providerId = UserDefaults.standard.value(forKey: keyValue.providerID.rawValue) as? Int
        Constants.providerId = providerId
        let beefProviderId = UserDefaults.standard.value(forKey: keyValue.beefPvid.rawValue) as? Int
        Constants.beefPvId = beefProviderId
        Date().saveCurrentDate()
        NotificationCenter.default.removeObserver(self, name: .appTimeout, object: nil)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        let farmValue = UserDefaults.standard.value(forKey: keyValue.farmValue.rawValue) as? String
        if farmValue == nil || farmValue == "" {
            UserDefaults.standard.setValue(Constants.farmValue, forKey: keyValue.farmValue.rawValue)
        }
        let marketName = UserDefaults.standard.value(forKey: keyValue.name.rawValue) as? String
        if marketName == nil || marketName == "" {
            UserDefaults.standard.setValue(Constants.marketName, forKey: keyValue.name.rawValue)
        }
        let providerId = UserDefaults.standard.value(forKey: keyValue.providerID.rawValue) as? Int
        if providerId == nil || providerId == 0 {
            UserDefaults.standard.setValue(Constants.providerId, forKey: keyValue.providerID.rawValue)
        }
        let beefProviderId = UserDefaults.standard.value(forKey: keyValue.beefPvid.rawValue) as? Int
        if beefProviderId == nil || beefProviderId == 0 {
            UserDefaults.standard.setValue(Constants.beefPvId, forKey: keyValue.beefPvid.rawValue)
        }
        let mintues =  Date().CompareTime()
        let maximumTime = 55
        if mintues >= maximumTime && mintues < 60{
            if Connectivity.isConnectedToInternet(){
                if UserDefaults.standard.object(forKey: keyValue.firstLogin.rawValue) as! String == "true"{
                    showAlertForLogin()
                }
            }
        }
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(AppDelegate.applicationDidTimeout(notification:)),
                                               name: .appTimeout,
                                               object: nil)
        callGetSpecies()
    }
    func callGetSpecies(){
        if UserDefaults.standard.value(forKey: "accessToken") as? String == nil || UserDefaults.standard.value(forKey: "accessToken") as? String == "" {
        } else {
            
            let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
            
            let headerDict :[String:String] = ["Authorization":"" + " " + accessToken!]
            let Network = NetworkManager()
            Network.delegate = self
            Network.CallApi(packet: NetwrokPackets( Method: HTTPMethod.get, Headers: headerDict, bodyParams: nil, Url: Configuration.Dev(packet: ApiKeys.getSpecies.rawValue).getUrl()))
            
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {}
    
    var customerOrderSetting = CustomerOrderSetting()
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.customerOrderSetting.saveCustomerSetting()
        self.saveContext()
    }
    
    @objc func applicationDidTimeout(notification: NSNotification) {
        if UserDefaults.standard.object(forKey: keyValue.firstLogin.rawValue) as? String ?? "" == "true"{
            if Connectivity.isConnectedToInternet(){
                self.showAlertForLogin()
                print("application did timeout, perform actions")
            }
        }
        
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "SearchPoint")
      
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
             
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
  
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        let aps = userInfo[AnyHashable("gcm.notification.messagetype")]!
        print("get it",aps)
        if let aps1 = (userInfo[AnyHashable("gcm.notification.messagetype")] as? NSString)?.integerValue
        {
            if aps1 == 2
            {
                if let messageID = userInfo[gcmMessageIDKey] {
                    print("Message ID: \(messageID)")
                }
                print(userInfo)
                guard let idToDelete = userInfo["messageID"] as? String else {
                    completionHandler(.noData)
                    return
                }
                UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [idToDelete])
                completionHandler(.noData)
                return
            }
        }
        
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}
  
    
    static let sharedInstance = AppDelegate()
    
    func getDeviceIdentifierFromKeychain() -> String {
        
        var deviceUDID = self.keychain_valueForKey("keychainDeviceUDID") as? String
        if deviceUDID == nil {
            deviceUDID = UIDevice.current.identifierForVendor!.uuidString
            self.keychain_setObject(deviceUDID! as AnyObject, forKey: "keychainDeviceUDID")
        }
        return deviceUDID!
    }
    
    // MARK: - Keychain
    
    func keychain_setObject(_ object: AnyObject, forKey: String) {
        let result = JNKeychain.saveValue(object, forKey: forKey)
        if !result {
            print("keychain saving: smth went wrong")
        }
    }
    
    func keychain_deleteObjectForKey(_ key: String) -> Bool {
        let result = JNKeychain.deleteValue(forKey: key)
        return result
    }
    
    func keychain_valueForKey(_ key: String) -> AnyObject? {
        print("Value for key '%@' is: '%@'", key, JNKeychain.loadValue(forKey: key));
        let value = JNKeychain.loadValue(forKey: key)
        return value as AnyObject?
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
        UserDefaults.standard.setValue(fcmToken, forKey: "pushToken")
        let dataDict:[String: String] = ["token": fcmToken ?? ""]
        
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
      
    }
}
var barcodeScreen = Bool()
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        
        print(userInfo)
        let aps = userInfo[AnyHashable("gcm.notification.messagetype")]!
        print("get it",aps)
        if let aps1 = (userInfo[AnyHashable("gcm.notification.messagetype")] as? NSString)?.integerValue
        {
            if aps1 == 2
            {
                print("done")
                completionHandler([])
            } else {
                completionHandler([.alert, .sound])
            }
        }
        UserDefaults.standard.setValue("abc", forKey: "del")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
    
    
}


extension AppDelegate: ResponseDelegate {
    func responseRecieved(_ data: Data?, status: Bool) {
        if data == nil {
            return
        }
    }
}


extension AppDelegate {
    
    func addObjForIdleTime(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(showAlertForLogin),
            name: NSNotification.Name(rawValue: "showAlert_idle"),
            object: nil
        )
    }
    
    @objc func showAlertForLogin(){
        var heartBeatViewModel:HeartBeatViewModel?
        let alertController = UIAlertController(title: AlertMessagesStrings.alertString, message: "Are you still using the app?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            heartBeatViewModel = HeartBeatViewModel(callBack: self.navigateToAnotherVc)
            heartBeatViewModel?.callGetHearBeatData()
            
        }
        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.default) {
            UIAlertAction in
            self.logoutSuccess()
            UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
            UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(nil, forKey: "BeefPvid")
            UserDefaults.standard.set(nil, forKey: "name")
            UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.settingDone.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.nominatorSave.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefProductAdded.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.screen.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerNameUS.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.speciesId.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.keyboardSelection.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.scannerSelection.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefScannerSelection.rawValue)
            UserDefaults.standard.set(false, forKey: "BVDVSeleted")
            UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
            
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        
        
        let when = DispatchTime.now() + 30
        DispatchQueue.main.asyncAfter(deadline: when){
            alertController.dismiss(animated: true, completion: nil)
            self.logoutSuccess()
            UserDefaults.standard.set(false, forKey: keyValue.settingDefault.rawValue)
            UserDefaults.standard.set("MM", forKey: keyValue.date.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerID.rawValue)
            UserDefaults.standard.set(nil, forKey: "BeefPvid")
            UserDefaults.standard.set(nil, forKey: "name")
            UserDefaults.standard.set(nil, forKey: keyValue.settingDefault.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.isInhertDisabledForBrazil.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.settingDone.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.nominatorSave.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefProductAdded.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerName.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.screen.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.providerNameUS.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.speciesId.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.keyboardSelection.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.scannerSelection.rawValue)
            UserDefaults.standard.set(nil, forKey: keyValue.beefScannerSelection.rawValue)
            UserDefaults.standard.set(false, forKey: "BVDVSeleted")
            UserDefaults.standard.set(false, forKey: keyValue.beefBVDVSeleted.rawValue)
            
        }
        
    }
    
    func logoutSuccess(){
        NotificationCenter.default.post(name: Notification.Name(keyValue.notificationIdentifier.rawValue), object: nil)
 
    }
    
    func navigateToAnotherVc(){}
}
