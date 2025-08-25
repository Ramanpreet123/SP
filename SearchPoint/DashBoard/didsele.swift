//
//  OrderingDefaultsVC.swift
//  SearchPoint
//
//  Created by Alok Yadav on 01/10/2019.
//  Copyright © 2019 Rajlaxmi Shekhawat. All rights reserved.
// Beef - product Grouping

import UIKit

class OrderingDefaultsVC: UIViewController ,offlineCustomView1,UIScrollViewDelegate {
    
    @IBOutlet weak var selctProductLbl: UILabel!
    @IBOutlet weak var providerTitleLbl: UILabel!
    @IBOutlet weak var productTblView: UITableView!
    var productPopupFlag = 0
    @IBOutlet weak var primarlyHeightConst: NSLayoutConstraint!
    @IBOutlet weak var continueOrderBttn: UIButton!
    @IBOutlet weak var speciesCollectionView: UICollectionView!
    @IBOutlet weak var evalutionProviderCV: UICollectionView!
    @IBOutlet weak var calendarViewBkg: UIView!
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var farmIdBttn: UIButton!
    @IBOutlet weak var rfidBttn: UIButton!
    var brazilProduct = [String]()
    @IBOutlet weak var billingView: UIView!
    var productArr = NSArray()
    var productSelected  =  [GetProductTbl]()
    var ScreenDef = String()
    @IBOutlet weak var networkStatusImg: UIImageView!
    var byDefaultProvider = "CLARIFIDE CDCB (US)"
    @IBOutlet weak var nominatorHeightConst: NSLayoutConstraint!
    @IBOutlet weak var primarlyBasedView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    
    @IBOutlet weak var screenTitle: UILabel!
    @IBOutlet weak var marketView: UIView!
    var specname = String()
    var orderSlideTag : Int?
    var sampleArr = NSMutableArray()
    var breedArr  = NSMutableArray()
    var providerVM: GetProviderViewModel?
    var breedVM: GetBreedViewModel?
    var speciesVM: GetSpeciesViewModel?
    var marketVM :GetMarketsViewModel?
    var productVM :GetProductsViewModel?
    var nominatorsVM :GetNominatorsViewModel?
    var speciesArray = [GetSpeciesTbl]()
    var providerId = Int()
    @IBOutlet weak var menuBttn: UIButton!
    var dataModel:LoginModel?
    var speiecCountCheck = NSArray()
    var provideCountCheck = NSArray()
    @IBOutlet weak var dateBtnOutlet: customButton!
    @IBOutlet weak var date1BtnOutlet: customButton!
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var holsteinBtnOutlet: customButton!
    @IBOutlet weak var zoetisBtnOutlet: customButton!
    let dateFormatter = DateFormatter()
    let locale = NSLocale.current
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var isSelectedArray = [Bool]()
    
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var evalutionProvideOutlet: customButton!
    var editflag :Int?
    var langId = UserDefaults.standard.value(forKey: "lngId") as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set( 1, forKey: "SpeciesId")
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        
        calenderView.isHidden = true
        calendarViewBkg.isHidden = true
        let datevalue = UserDefaults.standard.value(forKey: "date") as? String
        if datevalue == "MM"{
            dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            date1BtnOutlet.layer.borderWidth = 1
            
            dateBtnOutlet.layer.borderWidth = 2
        }
        else if datevalue == "DD" {
            date1BtnOutlet.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            
            date1BtnOutlet.layer.borderWidth = 2
            
            dateBtnOutlet.layer.borderWidth = 1
        }else {
            dateBtnOutlet.layer.borderWidth = 2
            
        }
        
        self.speiecCountCheck = fetchAllData(entityName: "GetSpeciesTbl")
        //  self.provideCountCheck = fetchAllData(entityName: "GetProviderTbl")
        if UserDefaults.standard.value(forKey: "name") as? String == "Dairy" ||  UserDefaults.standard.value(forKey: "name") as? String == nil  {
            self.provideCountCheck = fetchdataOfProvider(specisId: 1)
        }
        else if UserDefaults.standard.value(forKey: "name") as? String == "Beef"{
            self.provideCountCheck = fetchdataOfProvider(specisId: 2)
        }
        self.speciesCollectionView.delegate = self
        self.speciesCollectionView.dataSource = self
        self.speciesCollectionView.reloadData()
        self.evalutionProviderCV.delegate = self
        self.evalutionProviderCV.dataSource = self
        self.evalutionProviderCV.reloadData()
        
        if self.revealViewController() != nil {
            
            self.menuBttn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.rightRevealToggle(_:)), for: .touchUpInside);
            
            self.revealViewController()?.rightViewRevealWidth = 200;
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    
    @IBAction func donePopUpClick(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "name") == "Beef" {
            let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            
            if pvid == 5 {
                //for Global
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                        deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                        deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                        deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: Int(product.breedId), mkId: Int(product.marketId), status:"true", isAdded: "true")
                    }
                    
                }
            }
            
            if pvid == 6 {
                //for Brazil
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: Int(product.breedId), mkId: Int(product.marketId), status:"true", isAdded: "true")
                    } else {
                        deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                    }
                }
            }
            
            if pvid == 7 {
                //for Newzealand
                for product in self.productArr as? [GetProductTbl] ?? [] {
                    if product.isAdded == "true" {
                        deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                        deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                        deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                        deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                        UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                        saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: Int(product.breedId), mkId: Int(product.marketId), status:"true", isAdded: "true")
                    }
                }
            }
        }
        
        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
        if fetchPid.count > 0 {
            if let productTblBeef = fetchPid[0] as? GetProductTblBeef {
                if UserDefaults.standard.value(forKey: "settingDone") == nil {
                    
                    
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 5 {
                            //                             UserDefaults.standard.set("true", forKey: "settingDone")
                            //                            if productTblBeef.productName?.uppercased() == "INHERIT".uppercased() {
                            //                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "InheritQuestionaireController") as! InheritQuestionaireController
                            //                                vc.delegate = self
                            //                                self.navigationController?.present(vc, animated: false, completion: nil)
                            //                            }
                            //  else{
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                            // }
                            
                        }
                        if pvid == 6{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                        }
                        if pvid == 7{
                            
                            UserDefaults.standard.set("true", forKey: "settingDone")
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                        }
                    }
                    
                    
                    
                } else {
                    if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    if UserDefaults.standard.string(forKey: "name") == "Beef"{
                        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                        if pvid == 5 {
                            if productTblBeef.productName?.uppercased() == "INHERIT".uppercased() {
                                let vc = self.storyboard!.instantiateViewController(withIdentifier: "InheritQuestionaireController") as! InheritQuestionaireController
                                vc.delegate = self
                                self.navigationController?.present(vc, animated: false, completion: {
                                    // print("working")
                                })
                            }
                            else{
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                            }
                        }
                        if pvid == 6{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                        if pvid == 7{
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        }
                    }
                    
                    
                }
                
            }
            
            calendarViewBkg.isHidden = true
            billingView.isHidden = true
        } else {
            deleteRecordFromDatabase(entityName: "GetProductTblBeef")
            deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
            deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
            deleteRecordFromDatabase(entityName: "SubProductTblBeef")
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select the product(s)", comment: ""))
        }
    }
    
    
    
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    
    @IBAction func dateAction(_ sender: UIButton) {
        UserDefaults.standard.set("MM", forKey: "date")
        dateBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderWidth = 2
        date1BtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        date1BtnOutlet.layer.borderWidth = 1
        
    }
    
    @IBAction func dateAction1(_ sender: UIButton) {
        UserDefaults.standard.set("DD", forKey: "date")
        date1BtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        dateBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        date1BtnOutlet.layer.borderWidth = 2
        dateBtnOutlet.layer.borderWidth = 1
        dateBtnOutlet.layer.backgroundColor = UIColor.white.cgColor
        
    }
    
    @IBAction func zoetisBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 2
        holsteinBtnOutlet.layer.borderWidth = 1
    }
    
    
    @IBAction func holsteinBtnAction(_ sender: Any) {
        UserDefaults.standard.set("Holstein USA", forKey: "NominatorSave")
        holsteinBtnOutlet.layer.borderColor =    UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
        zoetisBtnOutlet.layer.borderWidth = 1
        holsteinBtnOutlet.layer.borderWidth = 2
    }
    
    @IBAction func continueToOrderBtnClk(_ sender: UIButton) {
        
        if UserDefaults.standard.value(forKey: "NominatorSave") == nil {
            UserDefaults.standard.set("Zoetis", forKey: "NominatorSave")
        }
        UserDefaults.standard.set("true", forKey: "settingDefault")
        
        if UserDefaults.standard.value(forKey: "settingDone") == nil {
            
            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                UserDefaults.standard.set("true", forKey: "settingDone")
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "OrderingAnimalVC")), animated: true)
            }
            if UserDefaults.standard.string(forKey: "name") == "Beef" {
                
                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr:NSLocalizedString("Please select a product grouping.", comment: "") )
                    return
                }
                
                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                
                if pvid == 5 {
                    //For Global
                    if productPopupFlag == 0{
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                for addedProduct in fetchPid as? [GetProductTblBeef] ?? [] {
                                    if addedProduct.productName?.uppercased() == product.productName?.uppercased() {
                                        product.isAdded = addedProduct.isAdded
                                    } else {
                                        product.isAdded = "false"
                                    }
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        calendarViewBkg.isHidden = false
                        billingView.isHidden = false
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                    }
                }
                
                if pvid == 6 {
                    //For Brazil
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                for addedProduct in fetchPid as? [GetProductTblBeef] ?? [] {
                                    if addedProduct.productName?.uppercased() == product.productName?.uppercased() {
                                        product.isAdded = addedProduct.isAdded
                                        break
                                    }
                                }
                            }
                            
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                        calendarViewBkg.isHidden = false
                        billingView.isHidden = false
                        productTblView.reloadData()
                        
                    } else {
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                    }
                }
                
                if pvid == 7 {
                    //For Newzealand
                    if productPopupFlag == 0 {
                        //                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
                        //                        if fetchPid.count > 0 {
                        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
                        //                                for addedProduct in fetchPid as? [GetProductTblBeef] ?? [] {
                        //                                    if addedProduct.productName?.uppercased() == product.productName?.uppercased() {
                        //                                        product.isAdded = addedProduct.isAdded
                        //                                    } else {
                        //                                        product.isAdded = "false"
                        //                                    }
                        //                                }
                        //                            }
                        //                        } else {
                        //                            for product in self.productArr as? [GetProductTbl] ?? [] {
                        //                                product.isAdded = "false"
                        //                            }
                        //                        }
                        //                        productPopupFlag = 1
                        //                        calendarViewBkg.isHidden = false
                        //                        billingView.isHidden = false
                        //                        productTblView.reloadData()
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                        }
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: Int(product.breedId), mkId: Int(product.marketId),status:"true", isAdded: "true")
                            }
                        }
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                        
                    } else {
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                    }
                }
            }
            
            
            
        } else {
            if UserDefaults.standard.string(forKey: "name") == "Dairy"{
                
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
            }
            if UserDefaults.standard.string(forKey: "name") == "Beef"{
                guard UserDefaults.standard.integer(forKey: "BeefPvid") != 0 else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please select a product grouping.", comment: ""))
                    return
                }
                
                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                if pvid == 5 {
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                for addedProduct in fetchPid as? [GetProductTblBeef] ?? [] {
                                    if addedProduct.productName?.uppercased() == product.productName?.uppercased() {
                                        product.isAdded = addedProduct.isAdded
                                    } else {
                                        product.isAdded = "false"
                                    }
                                }
                            }
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                        }
                        
                        productPopupFlag = 1
                                                calendarViewBkg.isHidden = false
                                                billingView.isHidden = false
                                                productTblView.reloadData()
                        //self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    }
                    else{
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
                    }
                }
                
                if pvid == 6 {
                    
                    if productPopupFlag == 0 {
                        let fetchPid = fetchAllData(entityName: "GetProductTblBeef")
                        if fetchPid.count > 0 {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                product.isAdded = "false"
                            }
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                for addedProduct in fetchPid as? [GetProductTblBeef] ?? [] {
                                    if addedProduct.productName?.uppercased() == product.productName?.uppercased() {
                                        product.isAdded = addedProduct.isAdded
                                        break
                                    }
                                }
                            }
                            
                        } else {
                            for product in self.productArr as? [GetProductTbl] ?? [] {
                                deleteDataWithProductBeef(entityName: "GetProductTblBeef", productId: Int(product.productId))
                                product.isAdded = "false"
                            }
                        }
                        productPopupFlag = 1
                                                calendarViewBkg.isHidden = false
                                                billingView.isHidden = false
                                                productTblView.reloadData()
                        //self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    } else {
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC")), animated: true)
                    }
                }
                
                if pvid == 7 {
                    if productPopupFlag == 0 {
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            product.isAdded = "true"
                        }
                        
                        for product in self.productArr as? [GetProductTbl] ?? [] {
                            if product.isAdded == "true" {
                                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                                saveProductSaveBeef(entity: "GetProductTblBeef", productId: Int(product.productId), productName: product.productName ?? "", providerId: Int(product.providerId), breedId: Int(product.breedId), mkId: Int(product.marketId), status:"true", isAdded: "true")
                            }
                        }
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                        
                    } else {
                        productPopupFlag = 0
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC")), animated: true)
                    }
                }
            }
            
            
        }
        
        
    }
    
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        calendarViewBkg.isHidden = true
        productTblView.delegate = self
        productTblView.dataSource = self
        initialNetworkCheck()
        billingView.isHidden = true
        
        let screen  = UserDefaults.standard.value(forKey: "screen") as? String
        if screen == "farmid"{
            farmIdBttn.layer.borderColor =    UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
            farmIdBttn.layer.borderWidth = 2
            rfidBttn.layer.borderWidth = 1
            // UserDefaults.standard.set("farmid", forKey: "FOSampleTrackingDetailVC")
            
        }
        else if  screen == "officialid"{
            farmIdBttn.layer.borderWidth = 1
            rfidBttn.layer.borderWidth = 2
            farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
            rfidBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            // UserDefaults.standard.set("officialid", forKey: "FOSampleTrackingDetailVC")
        }
        if UserDefaults.standard.string(forKey: "InheritFOReviewOrderVC") == nil{
            UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
        }
        if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == nil{
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
        }
        if UserDefaults.standard.string(forKey: "FOSampleTrackingDetailVC") == nil{
            UserDefaults.standard.set("farmid", forKey: "FOSampleTrackingDetailVC")
        }
        if UserDefaults.standard.string(forKey: "FOReviewOrderVC") == nil{
            UserDefaults.standard.set("farmid", forKey: "FOReviewOrderVC")
        }
        let tag = UserDefaults.standard.integer(forKey: "orderSlideTag")
        if tag == 1{
            
        } else {
            let settingDefault = UserDefaults.standard.value(forKey: "settingDefault") as? String
            
            if settingDefault == "true" {
                
                if editflag == 0 {
                    
                } else {
                    
                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let newViewController = storyBoard.instantiateViewController(withIdentifier: "OrderingAnimalVC") as! OrderingAnimalVC
                    self.navigationController?.pushViewController(newViewController, animated: false)
                }}
        }
        
        
        for i in 0 ..< provideCountCheck.count{
            isSelectedArray.append(false)
        }
        
        self.navigationController?.navigationBar.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        
        
        let checkValue = UserDefaults.standard.value(forKey: "settingDone") as? String
        if checkValue == "true" {
            continueOrderBttn.setTitle(NSLocalizedString("Done", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Settings", comment: "")
        }
        else {
            continueOrderBttn.setTitle(NSLocalizedString("Continue to Ordering", comment: ""), for: .normal)
            screenTitle.text = NSLocalizedString("Ordering Defaults", comment: "")
        }
        
        
        let zoeties = UserDefaults.standard.value(forKey: "NominatorSave") as? String
        if zoeties == nil || zoeties == "Zoetis"{
            zoetisBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            holsteinBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 2
            holsteinBtnOutlet.layer.borderWidth = 1
        }
        else{
            holsteinBtnOutlet.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            zoetisBtnOutlet.layer.borderColor = UIColor.lightGray.cgColor
            zoetisBtnOutlet.layer.borderWidth = 1
            holsteinBtnOutlet.layer.borderWidth = 2
        }
        
        if UserDefaults.standard.string(forKey: "providerNameUS") == nil {
            UserDefaults.standard.set("CLARIFIDE CDCB (US)", forKey: "providerNameUS")
            byDefaultProvider = "CLARIFIDE CDCB (US)"
        }
        else{
            byDefaultProvider = UserDefaults.standard.string(forKey: "providerNameUS")!
        }
        if UserDefaults.standard.string(forKey: "name") == nil{
            UserDefaults.standard.set("Dairy", forKey: "name")
        }
        if UserDefaults.standard.string(forKey: "name") == "Dairy"{
            primarlyHeightConst.constant = 146
            if byDefaultProvider == "CLARIFIDE CDCB (US)"{
                nominatorHeightConst.constant = 95
                
            }else{
                nominatorHeightConst.constant = 0
            }
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider", comment: "")
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            productTblView.reloadData()
        }
        else{
            marketView.isHidden = true
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            productTblView.reloadData()
            
        }
    }
    
    
    @objc  func checkForReachability(notification:Notification){
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected" || NetworkStatusLbl?.text == "Conectado"{
            self.offLineBtn.isUserInteractionEnabled = false
            //   self.offLineBtn.setImage(UIImage(named: "status_online_sign"), for: .normal)
            networkStatusImg.image = UIImage(named: "status_online_sign")
            
        } else {
            self.offLineBtn.isUserInteractionEnabled = false
            
            networkStatusImg.image = UIImage(named: "status_offline")
        }
    }
    
    @IBAction func farmIDAction(_ sender: UIButton) {
        farmIdBttn.layer.borderColor =  UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        rfidBttn.layer.borderColor = UIColor.lightGray.cgColor
        ScreenDef = "farmid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        farmIdBttn.layer.borderWidth = 2
        rfidBttn.layer.borderWidth = 1
    }
    
    
    @IBAction func rfidAction(_ sender: UIButton) {
        ScreenDef = "officialid"
        UserDefaults.standard.set(ScreenDef, forKey: "screen")
        UserDefaults.standard.set(ScreenDef, forKey: "FOSampleTrackingDetailVC")
        UserDefaults.standard.set(ScreenDef, forKey: "FOReviewOrderVC")
        
        farmIdBttn.layer.borderColor =    UIColor.lightGray.cgColor
        rfidBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
        farmIdBttn.layer.borderWidth = 1
        rfidBttn.layer.borderWidth = 2
    }
    
    @IBAction func marketTipPopClick(_ sender: UIButton) {
        
        if langId == 1{
            
            let screenSize = UIScreen.main.bounds
            buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
            buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
            buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
            self.view.addSubview(buttonbg1)
            customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
            customPopView1.arrow_left.isHidden = true
            
            var yFrame = (marketView.layer.frame.minY + 148) - self.scrolView.contentOffset.y
            
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (marketView.layer.frame.minY + 148 - 7 + 3) - self.scrolView.contentOffset.y
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (marketView.layer.frame.minY + 148 + 8) - self.scrolView.contentOffset.y
                case 2688:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (marketView.layer.frame.minY + 148 + 20) - self.scrolView.contentOffset.y
                case 1792:
                    yFrame = (marketView.layer.frame.minY + 148 + 18) - self.scrolView.contentOffset.y
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
                }
            }
            
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = true
            customPopView1.textLbl2.isHidden = true
            customPopView1.frame = CGRect(x: 40,y: yFrame  ,width: screenSize.width - 80, height: 137)
            customPopView1.textLabel1.text =  NSLocalizedString("This is which dairy genetic evaluation you normally received data from. This is automatically established by the market you are in but you can change the default if you normally order products from a different market.", comment: "")
            
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        } else {
            
            let screenSize = UIScreen.main.bounds
            buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
            buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
            buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
            self.view.addSubview(buttonbg1)
            customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
            customPopView1.arrow_left.isHidden = true
            
            var yFrame = (marketView.layer.frame.minY + 148) - self.scrolView.contentOffset.y
            
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (marketView.layer.frame.minY + 148 - 7 + 8) - self.scrolView.contentOffset.y
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                    yFrame = (marketView.layer.frame.minY + 148  + 13) - self.scrolView.contentOffset.y
                    
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (marketView.layer.frame.minY + 148 + 8 + 8) - self.scrolView.contentOffset.y
                case 2688:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (marketView.layer.frame.minY + 148 + 20 + 8) - self.scrolView.contentOffset.y
                case 1792:
                    yFrame = (marketView.layer.frame.minY + 148 + 18 + 8) - self.scrolView.contentOffset.y
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
                }
            }
            
            
            customPopView1.elipseImage2.isHidden = true
            customPopView1.elipseImage1.isHidden = true
            customPopView1.textLbl2.isHidden = true
            customPopView1.frame = CGRect(x: 54,y: yFrame ,width: screenSize.width - 80, height: 160)
            customPopView1.textLabel1.text = NSLocalizedString("This is which dairy genetic evaluation you normally received data from. This is automatically established by the market you are in but you can change the default if you normally order products from a different market.", comment: "")
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
            
        }}
    
    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
        print(self.scrolView.contentOffset.y)
    }
    
    
    @IBOutlet weak var primaryBasedOutlet: customButton!
    
    @IBAction func primarlyBasedTipPopClock(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg1.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg1.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressedTip), for: .touchUpInside)
        buttonbg1.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg1)
        customPopView1 = TipPopUp.loadFromNibNamed("TipPopUp") as? TipPopUp
        
        if langId == 1{
            
            var yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 21) -  self.scrolView.contentOffset.y
                    
                case 2688:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 34) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 34) -  self.scrolView.contentOffset.y
                    
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
                }
            }
            
            print(primaryBasedOutlet.frame)
            customPopView1.elipseImage2.isHidden = false
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            
            
            customPopView1.frame = CGRect(x: 51,y: yFrame ,width: 310, height: 133)
            customPopView1.textLabel1.text = NSLocalizedString("On-Farm ID can be the Herd Management #.", comment: "")//\n\n
            customPopView1.textLbl2.text = NSLocalizedString("Official ID can be an Official RFID Tag, Unique Metal Ear Tag, Breed Registration#.", comment: "")
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: primaryBasedOutlet.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }else {
            var yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 18) -  self.scrolView.contentOffset.y
            var strDeviceType = ""
            if UIDevice().userInterfaceIdiom == .phone {
                switch UIScreen.main.nativeBounds.height {
                case 1136:
                    strDeviceType = "iPhone 5 or 5S or 5C"
                case 1334:
                    strDeviceType = "iPhone 6/6S/7/8"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 8) -  self.scrolView.contentOffset.y
                    
                case 1920, 2208:
                    strDeviceType = "iPhone 6+/6S+/7+/8+"
                case 2436:
                    strDeviceType = "iPhone X"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 24) -  self.scrolView.contentOffset.y
                    
                case 2688:
                    strDeviceType = "iPhone Xs Max"
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 34) -  self.scrolView.contentOffset.y
                    
                case 1792:
                    yFrame = (primarlyBasedView.layer.frame.minY + 11 + 133 + 34) -  self.scrolView.contentOffset.y
                    
                    strDeviceType = "iPhone Xr"
                default:
                    strDeviceType = "unknown"
                }
            }
            
            
            print(primaryBasedOutlet.frame)
            customPopView1.elipseImage2.isHidden = false
            customPopView1.elipseImage1.isHidden = false
            customPopView1.textLbl2.isHidden = false
            customPopView1.textLabel1.isHidden = false
            customPopView1.frame = CGRect(x: 51,y: yFrame ,width: 310, height: 133)
            customPopView1.textLabel1.text = NSLocalizedString("On-Farm ID can be the Herd Management #.", comment: "")//\n\n
            customPopView1.textLbl2.text = NSLocalizedString("Official ID can be an Official RFID Tag, Unique Metal Ear Tag, Breed Registration#.", comment: "")
            customPopView1.arrow_left.isHidden = true
            customPopView1.arrow_Top.frame = CGRect(x: primaryBasedOutlet.frame.minX - 45 , y: -24, width: 26, height: 26)
            customPopView1.delegate = self
            customPopView1.layer.borderColor = UIColor.blue.cgColor
            customPopView1.layer.borderWidth = 1
            customPopView1.layer.cornerRadius = 8
            customPopView1.layer.borderWidth = 3
            customPopView1.layer.borderColor =  UIColor.clear.cgColor
            self.buttonbg1.addSubview(customPopView1)
        }
        
    }
    
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del =  UIApplication.shared.delegate as? AppDelegate
        
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected" || NetworkStatusLbl?.text == "Conectado"{
            self.offLineBtn.isUserInteractionEnabled = false
            networkStatusImg.image = UIImage(named: "status_online_sign")
        }
        else {
            networkStatusImg.image = UIImage(named: "status_offline")
            self.offLineBtn.isUserInteractionEnabled = true
        }
    }
    
    
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingDefaultsVC.buttonbgPressed), for: .touchUpInside)
        buttonbg.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.6)
        self.view .addSubview(buttonbg)
        customPopView = OfflinePopUp.loadFromNibNamed("OfflinePopUp") as? OfflinePopUp
        customPopView.delegate = self
        customPopView.frame = CGRect(x: 30,y: 160,width: screenSize.width - 30,height: screenSize.height/1.7)
        
        customPopView.center = view.center
        customPopView.layer.cornerRadius = 8
        customPopView.layer.borderWidth = 3
        customPopView.layer.borderColor =  UIColor.clear.cgColor
        self.buttonbg .addSubview(customPopView)
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        productPopupFlag = 0
        calendarViewBkg.isHidden = true
        billingView.isHidden = true
    }
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
    @objc func buttonbgPressedTip (){
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
    }
    
    func crossBtn() {
        buttonbg1.removeFromSuperview()
        customPopView1.removeFromSuperview()
        
    }
}
extension OrderingDefaultsVC:offlineCustomView{
    func crossBtnCall() {
        
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    
}
extension OrderingDefaultsVC :UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return speiecCountCheck.count
        }
        else {
            return provideCountCheck.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let item = collectionView.dequeueReusableCell(withReuseIdentifier: "species", for: indexPath) as! SpeciesCollectionViewCell
            let data = speiecCountCheck[indexPath.row] as! GetSpeciesTbl
            let fetchAray = fetchAllData(entityName: "SettingTbl")
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            item.speciesBttn.setTitle("\(data.speciesName!)", for: .normal )
            item.speciesBttn.addTarget(self, action: #selector(OrderingDefaultsVC.specisButton(_:)) , for: .touchUpInside )
            item.speciesBttn.tag = indexPath.row
            
            if data.speciesName!  == spName{
                item.speciesBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                item.speciesBttn.isUserInteractionEnabled = true
                item.speciesBttn.layer.borderWidth = 2
            }
                
            else{
                item.speciesBttn.layer.borderColor = UIColor.gray.cgColor
                // item.speciesBttn.isUserInteractionEnabled = false
                item.speciesBttn.layer.borderWidth = 1
            }
            return item
            
        }
        else  {
            let spName = UserDefaults.standard.value(forKey: "name") as? String
            if spName == "Dairy"{
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                
                if byDefaultProvider == "CLARIFIDE CDCB (US)"{
                    nominatorHeightConst.constant = 95
                    
                }else{
                    nominatorHeightConst.constant = 0
                }
                
                item.EcalutionProviderBttn.tag = indexPath.row
                let arrData = provideCountCheck[indexPath.row] as! GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                
                let pvid = UserDefaults.standard.integer(forKey: "Pvid")
                if pvid == arrData.providerId{
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                }
                else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    
                }
                if item.EcalutionProviderBttn.tag == 3 {
                    item.isUserInteractionEnabled = false
                }
                else{
                    item.isUserInteractionEnabled = true
                }
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
            }
            else{
                let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                
                let item = evalutionProviderCV.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! EvaluationProviderViewCell
                item.EcalutionProviderBttn.tag = indexPath.row
                item.isUserInteractionEnabled = true
                let arrData = provideCountCheck[indexPath.row] as! GetProviderTbl
                item.EcalutionProviderBttn.setTitle("\(arrData.providerName!)", for: .normal )
                item.EcalutionProviderBttn.setTitleColor(UIColor.gray, for: .normal)
                if pvid == arrData.providerId{
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                }
                else {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    
                }
                item.EcalutionProviderBttn.addTarget(self, action: #selector(OrderingDefaultsVC.providerButton(_:)) , for: .touchUpInside )
                
                return item
                
            }
        }
    }
    
    @objc func specisButton(_ sender:UIButton) {
        let specisObject : GetSpeciesTbl = speiecCountCheck.object(at: sender.tag) as! GetSpeciesTbl
        if specisObject.speciesName ==  "Dairy" {
            marketView.isHidden = false
            primaryBasedOutlet.isHidden = false
            providerTitleLbl.text = NSLocalizedString("Evaluation Provider", comment: "")
            primarlyHeightConst.constant = 146
            //       beefCollectionView.isHidden = true
            // evaluationProviderHeight.constant = 140
            if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)"{
                self.nominatorHeightConst.constant = 95
                
            }else{
                self.nominatorHeightConst.constant = 0
            }
            //    primarlyBasedHeight.constant = 146
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            
            
            
            self.provideCountCheck = fetchdataOfProvider(specisId: Int(specisObject.speciesId))
            for i in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set( Int(specisObject.speciesId), forKey: "SpeciesId")
            saveSettingData(entity: "SettingTbl", specisId: Int(specisObject.speciesId), specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "", fromDatae: "", toDate: "", status: "true",index: sender.tag)
        }
        else if specisObject.speciesName ==  "Beef" {
            marketView.isHidden = true
            primaryBasedOutlet.isHidden = true
            providerTitleLbl.text = NSLocalizedString("Product Groupings", comment: "")
            primarlyHeightConst.constant = 0
            nominatorHeightConst.constant = 0
            sender.isSelected = !sender.isSelected
            if sender.isSelected {
                sender.isSelected = true
                sender.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
            } else {
                
                sender.setImage(nil, for: .normal)
                sender.layer.borderColor = UIColor.lightGray.cgColor
                sender.backgroundColor = UIColor.white
            }
            self.provideCountCheck = fetchdataOfProvider(specisId: Int(specisObject.speciesId))
            for i in 0 ..< provideCountCheck.count{
                isSelectedArray.append(false)
            }
            specname = specisObject.speciesName!
            UserDefaults.standard.set(specname, forKey: "name")
            UserDefaults.standard.set( Int(specisObject.speciesId), forKey: "SpeciesId")
            saveSettingData(entity: "SettingTbl", specisId: Int(specisObject.speciesId), specisName: specisObject.speciesName ?? "", providerName: "", providerId: 0, nominater: "", fromDatae: "", toDate: "", status: "true",index: sender.tag)
            
            
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            
            if let  products = productArr as? [GetProductTbl] {
                for product in products {
                    product.isAdded = "false"
                }
                deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                deleteRecordFromDatabase(entityName: "SubProductTblBeef")
            }
            productTblView.reloadData()
            
        }
        self.evalutionProviderCV.reloadData()
//self.speciesCollectionView.reloadData()
        self.speciesCollectionView.reloadItems(at: self.speciesCollectionView.indexPathsForVisibleItems)
    }
    
    @objc func providerButton(_ sender:UIButton) {
       // UserDefaults.standard.removeObject(forKey: "screen")
        UserDefaults.standard.removeObject(forKey: "Brazil")
        if UserDefaults.standard.string(forKey: "name") == "Dairy" {
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderId")
            
            let myIndexPath = NSIndexPath(row: sender.tag, section: 0)
            let item = evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
            sender.isSelected = !sender.isSelected
            let providerObject : GetProviderTbl = provideCountCheck.object(at: sender.tag) as! GetProviderTbl
            deleteRecordFromDatabase(entityName: "Saveprovider")
            
            saveSettingProviderData(entity: "Saveprovider", specisId: Int(providerObject.speciesId), specisName: specname, providerName: providerObject.providerName! , providerId: Int(providerObject.providerId), nominater: "Zoetis", fromDatae: "", toDate: "", status: "true", index: sender.tag)
            let fetchAray = fetchAllData(entityName: "Saveprovider")
            
            let pvId = fetchAray.object(at: 0) as! Saveprovider
            let pviduser = UserDefaults.standard.integer(forKey:"Pvid" )
            byDefaultProvider = pvId.providerName!
            
            if pviduser == pvId.providerId {
                
            }
            else{
                //                let alert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to change the provider?", comment: ""),   preferredStyle: UIAlertController.Style.alert)
                //                alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                //                    //Cancel Action
                //                }))
                //                alert.addAction(UIAlertAction(title:  NSLocalizedString("Yes", comment: ""),style: UIAlertAction.Style.default, handler: ))
                //                self.present(alert, animated: true, completion: nil)
                
                
                UserDefaults.standard.set(providerObject.providerName!, forKey: "ProviderName")
                let pvid = UserDefaults.standard.integer(forKey: "Pvid")
                let sampleType =  fetchproviderData(entityName: "GetSampleTbl", provId: Int(pvId.providerId)  )
                var animaltbl = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                for i in 0 ..< sampleType.count {
                    let samType  = sampleType[i] as! GetSampleTbl
                    animaltbl = animaltbl.filter { (item) -> Bool in
                        if let value = item as? AnimaladdTbl, value.tissuName != samType.sampleName{
                            return true
                        }else{
                            return false
                        }
                    }
                }
                
                let breedType =   fetchBreedData(entityName: "GetBreedsTbl", provId:  Int(pvId.providerId) )
                var animaltbl1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId).mutableCopy() as! Array<Any>
                
                for i in 0 ..< breedType.count {
                    let bredTy  = breedType[i] as! GetBreedsTbl
                    animaltbl1 = animaltbl1.filter { (item) -> Bool in
                        if let value = item as? AnimaladdTbl, value.breedId != bredTy.breedId{
                            return true
                        } else {
                            return false
                        }
                    }
                }
                
                if sender.tag == 3 {
                    
                } else {
                    
                    if sender.tag == 2 {
                        UserDefaults.standard.set(true, forKey: "ClickAuProvider")
                        
                    } else {
                        
                        UserDefaults.standard.set(false, forKey: "ClickAuProvider")
                        
                    }
                }
                
                var strinBreed = String()
                var StringSampleType = String()
                if animaltbl1.count > 0 || animaltbl.count > 0 {
                    if animaltbl1.count > 0{
                        strinBreed =  "Breed of \(animaltbl1.count) animal(s) not available in the selected provider."
                    }
                    else if animaltbl.count > 0{
                        StringSampleType = "Sample type of \(animaltbl.count) animal(s) not available in the selected provider."
                    }
                    
                    
                    let alert = UIAlertController(title: NSLocalizedString("Alert?", comment: ""), message: NSLocalizedString("\(strinBreed) \(StringSampleType) Do you want to remove the conflicting animals from the current order?",comment : ""),  preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default, handler: { _ in
                        //self.addProduct()
                    }))
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default,
                                                  handler: {(_: UIAlertAction!) in
                                                    for item1 in animaltbl{
                                                        if let value = item1 as? AnimaladdTbl{
                                                            
                                                            deleteDataWithAnimalSampleType(value.tissuName!,orderstatus:"false")
                                                        }
                                                    }
                                                    
                                                    for item in animaltbl1{
                                                        if let value = item as? AnimaladdTbl{
                                                            
                                                            deleteDataWithAnimalBreedId(Int(value.breedId),orderstatus:"false")
                                                        }
                                                    }
                                                    UserDefaults.standard.set(Int(pvId.providerId), forKey: "Pvid")
                                                    
                                                    if  sender.isSelected {
                                                        self.isSelectedArray[sender.tag] = true
                                                        for i in 0 ..<  self.provideCountCheck.count {
                                                            
                                                            let myIndexPath = NSIndexPath(row: i, section: 0)
                                                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                                            let  pvid = UserDefaults.standard.integer(forKey: "Pvid")
                                                            let arrData =    self.provideCountCheck[i] as! GetProviderTbl
                                                            if pvid == arrData.providerId{
                                                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                                                
                                                            }
                                                            else{
                                                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                                                item.EcalutionProviderBttn.layer.borderWidth = 1
                                                                
                                                                
                                                            }
                                                            
                                                        }
                                                        
                                                    } else {
                                                        
                                                        self.isSelectedArray[sender.tag] = false
                                                        for i in 0 ..<  self.provideCountCheck.count {
                                                            let myIndexPath = NSIndexPath(row: i, section: 0)
                                                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                                                            let  pvid = UserDefaults.standard.integer(forKey: "Pvid")
                                                            let arrData =    self.provideCountCheck[i] as! GetProviderTbl
                                                            if pvid == arrData.providerId{
                                                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                                                
                                                            } else {
                                                                item.EcalutionProviderBttn.layer.borderWidth = 1
                                                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                                            }
                                                        }
                                                    }
                                                    self.addProduct()
                                                    
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else {
                    
                    UserDefaults.standard.set(Int(pvId.providerId), forKey: "Pvid")
                    
                    if  sender.isSelected {
                        self.isSelectedArray[sender.tag] = true
                        for i in 0 ..<  self.provideCountCheck.count {
                            
                            let myIndexPath = NSIndexPath(row: i, section: 0)
                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                            let  pvid = UserDefaults.standard.integer(forKey: "Pvid")
                            let arrData =    self.provideCountCheck[i] as! GetProviderTbl
                            if pvid == arrData.providerId{
                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                
                            }
                            else{
                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
                                item.EcalutionProviderBttn.layer.borderWidth = 1
                            }
                        }
                        
                    } else {
                        
                        self.isSelectedArray[sender.tag] = false
                        for i in 0 ..<  self.provideCountCheck.count {
                            let myIndexPath = NSIndexPath(row: i, section: 0)
                            let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                            let  pvid = UserDefaults.standard.integer(forKey: "Pvid")
                            let arrData =    self.provideCountCheck[i] as! GetProviderTbl
                            if pvid == arrData.providerId{
                                item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                                item.EcalutionProviderBttn.layer.borderWidth = 2
                                
                            } else {
                                item.EcalutionProviderBttn.layer.borderWidth = 1
                                item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                                item.EcalutionProviderBttn.backgroundColor = UIColor.white
                            }
                        }
                    }
                    self.addProduct()
                }
                UserDefaults.standard.set(pvId.providerName!, forKey: "providerNameUS")
                self.byDefaultProvider = pvId.providerName!
                if UserDefaults.standard.string(forKey: "providerNameUS") == "CLARIFIDE CDCB (US)"{
                    self.nominatorHeightConst.constant = 95
                    
                }else{
                    self.nominatorHeightConst.constant = 0
                }
                
            }
        } else {
            //"Beef"
            let providerObject : GetProviderTbl = self.provideCountCheck.object(at: sender.tag) as! GetProviderTbl
            
            if UserDefaults.standard.integer(forKey: "BeefPvid") != Int(providerObject.providerId) {
                print("Same selection")
                UserDefaults.standard.removeObject(forKey: "beefProduct")
                if let  products = self.productArr as? [GetProductTbl] {
                    for product in products {
                        product.isAdded = "false"
                    }
                    deleteRecordFromDatabase(entityName: "GetProductTblBeef")
                    deleteRecordFromDatabase(entityName: "BeefAnimaladdTbl")
                    deleteRecordFromDatabase(entityName: "ProductAdonAnimlTbLBeef")
                    deleteRecordFromDatabase(entityName: "SubProductTblBeef")
                }
            }
            
            UserDefaults.standard.set(Int(providerObject.providerId), forKey: "BeefPvid")
            let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
            self.productArr = fetchproviderProductDataBeef(entityName: "GetProductTbl", provId: pvid)
            
            self.productPopupFlag = 0
            
            for i in 0 ..<  self.provideCountCheck.count {
                let myIndexPath = NSIndexPath(row: i, section: 0)
                let item =  self.evalutionProviderCV.cellForItem(at: myIndexPath as IndexPath) as! EvaluationProviderViewCell
                let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
                let arrData =    self.provideCountCheck[i] as! GetProviderTbl
                
                
                if pvid == arrData.providerId {
                    item.EcalutionProviderBttn.layer.borderColor = UIColor(red: 117/255, green: 206/255, blue: 222/255, alpha: 1).cgColor
                    item.EcalutionProviderBttn.layer.borderWidth = 2
                    
                } else {
                    item.EcalutionProviderBttn.layer.borderWidth = 1
                    item.EcalutionProviderBttn.layer.borderColor = UIColor.lightGray.cgColor
                    item.EcalutionProviderBttn.backgroundColor = UIColor.white
                }
            }
            self.productTblView.reloadData()
            
            //            let alertController = UIAlertController(title: "Alert", message: "Are you sure want to remove previous selected products?", preferredStyle: .alert)
            //            let yesAction = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: UIAlertAction.Style.default) { UIAlertAction in }
            //            let noAction = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: UIAlertAction.Style.default) { UIAlertAction in }
            //            alertController.addAction(yesAction)
            //            alertController.addAction(noAction)
            //            self.present(alertController, animated: true, completion: nil)
        }
    }
    // self.evalutionProviderCV.reloadData()
    //   self.speciesCollectionView.reloadData()
    
    
    func addProduct()  {
        let pvid = UserDefaults.standard.integer(forKey: "Pvid")
        deleteDataProduct(entityName:"ProductAdonAnimalTbl",status:"false")
        deleteDataProduct(entityName:"SubProductTbl", status: "false")
        UserDefaults.standard.removeObject(forKey: "identifyStore")
        UserDefaults.standard.removeObject(forKey: "productCount")
        UserDefaults.standard.removeObject(forKey: "breed")
        UserDefaults.standard.set(nil, forKey: "On")
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        
        updateProductTablStatus(entity: "GetProductTbl")
        updateProductTablStatus(entity: "GetAdonTbl")
        
        let animalArr1 = fetchAllDataOrderStatus(entityName: "AnimaladdTbl",ordestatus: "false",orderId:orderId,userId:userId)
        if animalArr1.count > 0 {
            for k in 0 ..< animalArr1.count {
                let  breedId1  = animalArr1[k] as! AnimaladdTbl
                
                let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: Int(breedId1.breedId) )
                let productCount = UserDefaults.standard.integer(forKey: "productCount")
                if productCount == 0{
                    UserDefaults.standard.set(breedId1.breedId, forKey: "breed")
                }
                if UserDefaults.standard.bool(forKey: "identifyStore") == false  {
                    if productCount > 0{
                        if product.count == UserDefaults.standard.integer(forKey: "productCount"){
                            UserDefaults.standard.set(breedId1.breedId, forKey: "breed")
                            UserDefaults.standard.set(false, forKey: "identifyStore")
                        }
                        else{
                            UserDefaults.standard.set(true, forKey: "identifyStore")
                            
                        }
                    }
                }
                
                UserDefaults.standard.set( product.count, forKey: "productCount")
                var animalID = UserDefaults.standard.integer(forKey: "animalId")
                
                
                for i in 0 ..< product.count{
                    let data = product[i] as! GetProductTbl
                    
                    saveProductAdonTbl(entity: "ProductAdonAnimalTbl", animalTag: breedId1.animalTag!, barCodetag: breedId1.animalbarCodeTag ?? "",mkdId: Int(data.marketId), productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "false", farmId: breedId1.farmId!, orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, animalId: Int(breedId1.animalId) )
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    for j in 0 ..< addonArr.count{
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: "SubProductTbl", animalTag:  breedId1.animalTag!, barCodetag: breedId1.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: Int(breedId1.orderId), orderStatus: "false",isSync:"false", userId: userId,udid:breedId1.udid!, farmId: breedId1.farmId!, animalId: Int(breedId1.animalId))
                    }
                }
                
            }
            
        }
    }
}
extension OrderingDefaultsVC : SideMenuUI{
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}

extension Array where Element : Hashable{
    func difference(from other:[Element])->[Element]{
        let first = Set(self)
        let second = Set(other)
        return Array( first.symmetricDifference(second))
    }
}
extension OrderingDefaultsVC : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let cell = tableView.dequeueReusableCell(withIdentifier: "beefproducts", for: indexPath) as! BeefProductsTableViewCell
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        cell.productName.text = product.productName
        cell.radioBttn.isUserInteractionEnabled = false
        
        //for Global
        if pvid == 5 {
            
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
        }
        
        //for brazil
        if pvid == 6 {
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "check"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "Uncheck"), for: .normal)
            }
        }
        
        //for Newzealand
        if pvid == 7 {
            if product.isAdded == "true" {
                cell.radioBttn.setImage(UIImage(named: "radioSeletedBtn"), for: .normal)
            } else{
                cell.radioBttn.setImage(UIImage(named: "radioBtn"), for: .normal)
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        let product =  self.productArr.object(at: indexPath.row) as! GetProductTbl
        
        if pvid == 5{
            //for global
            if let  products = productArr as? [GetProductTbl] {
                for product in products {
                    product.isAdded = "false"
                }
                products[indexPath.row].isAdded = "true"
            }
            if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "rgn" {
                UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
            }
            //UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
           // UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
            UserDefaults.standard.set(product.productId, forKey: "beefProductID")
            UserDefaults.standard.set(product.productName, forKey: "beefProduct")
            productTblView.reloadData()
        }
        
        if pvid == 6 {
            //for brazil
            
            if let  products = productArr as? [GetProductTbl] {
                if products[indexPath.row].isAdded == "true" {
                    products[indexPath.row].isAdded = "false"
                } else {
                    products[indexPath.row].isAdded = "true"
                }
            }
            brazilProduct.append(product.productName!)
            UserDefaults.standard.set(product.productId, forKey: "beefProductID")
            UserDefaults.standard.set(brazilProduct, forKey: "brazilproduct")
            //UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
            //UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
             if UserDefaults.standard.string(forKey: "InheritFOSampleTrackingDetailVC") == "barcode" {
            UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
            }
            productTblView.reloadData()
        }
        
        if pvid == 7 {
            //for Newzealand
           // UserDefaults.standard.set("officialid", forKey: "InheritFOSampleTrackingDetailVC")
//UserDefaults.standard.set("officialid", forKey: "InheritFOReviewOrderVC")
            if let  products = productArr as? [GetProductTbl] {
                for product in products {
                    product.isAdded = "false"
                }
                UserDefaults.standard.set(product.productId, forKey: "beefProductID")
                products[indexPath.row].isAdded = "true"
            }
            
            productTblView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}


extension OrderingDefaultsVC: InheritQuestionaireControllerDelegate {
    func inheritQuestionaireControllerDismissed() {
        print("Working")
        
        if UserDefaults.standard.value(forKey: "settingDone") == nil {
            UserDefaults.standard.set("true", forKey: "settingDone")
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
            self.navigationController?.pushViewController(newViewController, animated: false)
            // self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC")), animated: true)
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: false)
            //self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        }
    }
}


