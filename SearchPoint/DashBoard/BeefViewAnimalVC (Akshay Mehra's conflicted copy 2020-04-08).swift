//
//  BeefViewAnimalVC.swift
//  SearchPoint
//
//  Created by Akshay Mehra on 16/03/20.
//

import UIKit


class BeefViewAnimalVC: UIViewController,offlineCustomView {
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    @IBOutlet weak var cartImage: UIImageView!
    @IBOutlet weak var noOrderLbl: UILabel!
    @IBOutlet weak var cartBttnOutlet: UIButton!
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    @IBOutlet weak var appStatusLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    var viewAnimalArray = NSArray()
    @IBOutlet weak var networkImgStatus: UIImageView!
    @IBOutlet weak var notificationLblCount: UILabel!
    var delegateCustom : objectPickCartScreen?
    var screenBackSave = Bool()
    var productBackSave = Bool()
    
    @IBOutlet weak var noAnimalToast: UILabel!
    @IBOutlet weak var clearOrderOutlet: UIButton!
    @IBOutlet weak var offlineBtnOutlet: UIButton!
    
    @IBOutlet weak var bckBtnOutlet: customButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        cartImage.isHidden = true
        var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
        if langId == 1  {
            clearOrderOutlet.setTitle("Clear Cart", for: .normal)
            noAnimalToast.text = "No animals added in order."
            
            
        } else {
            noAnimalToast.text = "Nenhum animal adicionado em ordem."
            
            clearOrderOutlet.setTitle("Carrinho clara", for: .normal)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        initialNetworkCheck()
        //noOrderLbl.isHidden = true
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        
        //        if  UserDefaults.standard.bool(forKey: "review") == true {
        //            viewAnimalArray =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: "")
        //            notificationLblCount.text = String(viewAnimalArray.count)
        //        }
        //        else {
        viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false")
        notificationLblCount.text = String(viewAnimalArray.count)
        
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
        
    }
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderSaveViewController.buttonbgPressed), for: .touchUpInside)
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
    
    @objc func buttonbgPressed (){
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }
    @IBAction func backBtnAction(_ sender: UIButton) {
        
        if viewAnimalArray.count == 0 {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC") as! DashboardVC
            self.navigationController?.pushViewController(newViewController, animated: true)
            
            
        }
        else if screenBackSave == true {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionReviewVC") as! BeefOrderProductSelectionReviewVC
            self.navigationController?.pushViewController(newViewController, animated: false)
            
            
        }else if productBackSave ==  true {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC") as! BeefOrderProductSelectionSecondVC
            self.navigationController?.pushViewController(newViewController, animated: false)
        }
        else {
            self.delegateCustom?.anOptionalMethod?(check: true)
            self.navigationController?.popViewController(animated: false)
        }
        
    }
    
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if appStatusLbl?.text == "Connected" || appStatusLbl?.text == "Conectado"{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: "status_online_sign")
        }
        else {
            networkImgStatus.image = UIImage(named: "status_offline")
            self.offlineBtnOutlet.isUserInteractionEnabled = true
        }
    }
    
    @objc  func checkForReachability(notification:Notification){
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.appStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if appStatusLbl?.text == "Connected" || appStatusLbl?.text == "Conectado"{
            self.offlineBtnOutlet.isUserInteractionEnabled = false
            networkImgStatus.image = UIImage(named: "status_online_sign")
            
        } else {
            self.offlineBtnOutlet.isUserInteractionEnabled = true
            networkImgStatus.image = UIImage(named: "status_offline")
        }
    }
    
    @IBAction func clearOrder(_ sender: UIButton) {
        // MANISH
        let refreshAlert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to clear all order details?", comment: ""), preferredStyle: UIAlertController.Style.alert)
    
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            self.view.makeToast(NSLocalizedString("Order Cleared Successfully", comment: ""), duration: 10, position: .center)
            
            deleteDataProduct(entityName:"BeefAnimaladdTbl",status:"false")
            deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
            deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
            UserDefaults.standard.removeObject(forKey: "identifyStore")
            UserDefaults.standard.removeObject(forKey: "productCount")
            UserDefaults.standard.set(nil, forKey: "On")
            UserDefaults.standard.set(nil, forKey: "page")
            UserDefaults.standard.removeObject(forKey: "breed")
            updateProductTablStatus(entity: "GetProductTblBeef")
            updateProductTablStatus(entity: "GetAdonTbl")
            UserDefaults.standard.removeObject(forKey: "pid")
            UserDefaults.standard.set(nil, forKey: "tsu")
             UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
            self.tblView.isHidden = true
            self.notificationLblCount.text = "0"
            self.bckBtnOutlet.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        self.bckBtnOutlet.isEnabled = true
        
        present(refreshAlert, animated: true, completion: nil)
        
        
    }
}
extension BeefViewAnimalVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewAnimalArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if pvid == 5 || pvid == 7 {
            return 90
        }
        else{
            return 150
        }
       
    }
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:ViewAnimalCell = self.tblView.dequeueReusableCell(withIdentifier: "beefcell") as! ViewAnimalCell
        
        //        if  UserDefaults.standard.bool(forKey: "review") == true{
        //            let animalVal  =  viewAnimalArray[indexPath.row] as! ProductAdonAnimalTbl
        //            cell.officialIdLbl.text = animalVal.animalTag
        //            cell.farmIDLbl.text = animalVal.farmId
        //            cell.barcodeLbl.text = animalVal.animalbarCodeTag
        //        }
        //        else {
        
        let animalVal  =  viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
        if animalVal.isUpadte == "true"
        {
            cell.innnerView.layer.borderColor = UIColor.red.cgColor
        }
        else{
            cell.innnerView.layer.borderColor = UIColor.clear.cgColor
        }
        
          let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        if pvid == 5{
        cell.officialIdLbl.text = animalVal.animalTag
        cell.farmIDLbl.text = animalVal.farmId
        cell.barcodeLbl.text = animalVal.animalbarCodeTag
        }
        if pvid == 7{
            cell.earTagLbl.text = "Animal Tag/Tattoo"
            cell.officialIdLbl.text = animalVal.animalTag
            cell.farmIDLbl.text = animalVal.farmId
            cell.barcodeLbl.text = animalVal.animalbarCodeTag
        }
        if pvid == 6{
        cell.earTagLbl.text = "Barcode"
           cell.officialIdLbl.text = animalVal.animalTag
            cell.barcodetitle.text = "Serie"
            cell.barcodeLbl.text = animalVal.offsireId
            cell.rgnLbl.text = animalVal.offPermanentId
            cell.rgdLbl.text = animalVal.offDamId
        }
        //       }
        
        
        cell.innnerView.layer.borderWidth = 1
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //        if  UserDefaults.standard.bool(forKey: "review") == true{
        //            let animalVal  =  viewAnimalArray[indexPath.row] as! ProductAdonAnimalTbl
        //            self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        //            UserDefaults.standard.set(Int(animalVal.animalId), forKey: "BeefAnimalIdSelectionCart")
        //        }
        //        else {
        
        let animalVal  =  viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
        self.delegateCustom?.objectGetOnSelection(temp: Int(animalVal.animalId))
        UserDefaults.standard.set(Int(animalVal.animalId), forKey: "BeefAnimalIdSelectionCart")
        
        //    }
        if UserDefaults.standard.integer(forKey: "BeefPvid") == 5  {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalGlobalHD50KVC") as! BeefAnimalGlobalHD50KVC
        navigationController?.pushViewController(vc,animated: false)
        }
        else if UserDefaults.standard.integer(forKey: "BeefPvid") == 6{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalBrazilVC") as! BeefAnimalBrazilVC
            navigationController?.pushViewController(vc,animated: false)
        }
        else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "BeefAnimalNZ_VC") as! BeefAnimalNZ_VC
            navigationController?.pushViewController(vc,animated: false)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let refreshAlert = UIAlertController(title: NSLocalizedString("Alert", comment: ""), message: NSLocalizedString("Are you sure you want to delete animal from the order?", comment: ""), preferredStyle: UIAlertController.Style.alert)
        
        
        
        refreshAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "") , style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            
            if editingStyle == .delete {
                
                //                if  UserDefaults.standard.bool(forKey: "review") == true{
                //                    let animalVal  =  self.viewAnimalArray[indexPath.row] as! ProductAdonAnimalTbl
                //                    deleteDataWithProduct(animalVal.animalTag ?? "")
                //                    deleteDataWithSubProduct(animalVal.animalTag ?? "")
                //                    deleteDataWithAnimal(animalVal.animalTag ?? "")
                //                }
                //                else{
                let animalVal  =  self.viewAnimalArray[indexPath.row] as! BeefAnimaladdTbl
                BeefDeleteDataWithProduct(animalVal.animalTag ?? "")
                beefDeleteDataWithSubProduct(animalVal.animalTag ?? "")
                beefDeleteDataWithAnimal(animalVal.animalTag ?? "")
                // }
                
                let userId = UserDefaults.standard.integer(forKey: "userId")
                let orderId = UserDefaults.standard.integer(forKey: "orderId")
                //                if UserDefaults.standard.bool(forKey: "review") == true{
                //                    self.viewAnimalArray =  fetchAllDataFarmIdStatus(entityName: "ProductAdonAnimalTbl", asending: true, status: "true",orderStatus:"false", orderId: orderId,userId:userId, farmId: "")
                //                    self.notificationLblCount.text = String(self.viewAnimalArray.count)
                //
                //                }
                //                else {
                self.viewAnimalArray =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false")
                self.notificationLblCount.text = String(self.viewAnimalArray.count)
                //   }
                self.view.makeToast(NSLocalizedString("Animal removed from the order successfully", comment: ""), duration: 1, position: .bottom)
                
                if self.viewAnimalArray.count == 0 {
                    deleteDataProduct(entityName:"BeefAnimaladdTbl",status:"false")
                    deleteDataProduct(entityName:"ProductAdonAnimlTbLBeef",status:"false")
                    deleteDataProduct(entityName:"SubProductTblBeef", status: "false")
                    UserDefaults.standard.removeObject(forKey: "identifyStore")
                    UserDefaults.standard.removeObject(forKey: "productCount")
                    UserDefaults.standard.set(nil, forKey: "On")
                    UserDefaults.standard.set(nil, forKey: "page")
                    UserDefaults.standard.removeObject(forKey: "breed")
                    updateProductTablStatus(entity: "GetProductTblBeef")
                    updateProductTablStatus(entity: "GetAdonTbl")
                    UserDefaults.standard.removeObject(forKey: "pid")
                     UserDefaults.standard.set(true, forKey: "showbeefproductTbl")
                    print("navigation")
                    //  self.bckBtnOutlet.isEnabled = false
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    //                        // your code here
                    //                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
                    //
                    //                    }
                    
                    
                    self.cartBttnOutlet.isHidden = true
                    self.notificationLblCount.isHidden = true
                    self.clearOrderOutlet.isHidden = true
                    self.noAnimalToast.isHidden = false
                    self.cartImage.isHidden = false
                    
                } else {
                    self.noAnimalToast.isHidden = true
                    
                    self.cartBttnOutlet.isHidden = false
                    self.notificationLblCount.isHidden = false
                    self.clearOrderOutlet.isHidden = false
                    self.cartImage.isHidden = true
                    
                }
                // self.bckBtnOutlet.isEnabled = true
                print(self.viewAnimalArray.count)
                tableView.reloadData()
            }
            else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
}

