import UIKit
import BarcodeScanner


class BeefAnimalBrazilVC: UIViewController,UIScrollViewDelegate,BarcodeScannerCodeDelegate,BarcodeScannerErrorDelegate,BarcodeScannerDismissalDelegate {

    //  MARK: - OtherView
 
    @IBOutlet weak var genotypeBarcodeBttn: UIButton!
    @IBOutlet weak var barcodeBttn: UIButton!
    @IBOutlet weak var genotypeView: UIView!
    @IBOutlet weak var scrollInnerView: UIView!
    @IBOutlet weak var NetworkStatusLbl: UILabel!
    
    @IBOutlet weak var offLineBtn: UIButton!
    @IBOutlet weak var networkStatusImg: UIImageView!
    @IBOutlet weak var innerView: UIView!
    var lblTimeStamp = String()
    @IBOutlet weak var genotypeScrollView: UIScrollView!
    
    @IBOutlet weak var barcodeView: UIView!
    
    @IBOutlet weak var scrolView: UIScrollView!
    
    @IBOutlet weak var scanBarcodeTextfield: UITextField!
    
    @IBOutlet weak var serieTextfield: UITextField!
    
    @IBOutlet weak var rGNTextfield: UITextField!
    
    @IBOutlet weak var rGDTextfield: UITextField!
    
    @IBOutlet weak var tissueHideLbl: UILabel!
    
    @IBOutlet weak var tissueBttn: customButton!
    
    @IBOutlet weak var maleFemaleBttn: UIButton!
    
    @IBOutlet weak var dateBttnOutlet: UIButton!
    
    @IBOutlet weak var animalTextfield: UITextField!
    var requiredflag = 0
    @IBOutlet weak var calenderView: UIView!
    @IBOutlet weak var calenderbkg: UIView!

    
    @IBOutlet weak var dobView: UIView!
    
    //GENOTYPE
    
    
    
    @IBOutlet weak var genotypeScanBarcodeView: UIView!
    
    @IBOutlet weak var genotypeScanBarcodeTextField: UITextField!
    
    @IBOutlet weak var genotypeSerieTextfield: UITextField!
    
    @IBOutlet weak var genotypeRgnTextfield: UITextField!
    
    @IBOutlet weak var genotypeTissueBttn: customButton!
    
    @IBOutlet weak var genotypeDOBBttn: UIButton!
    
    @IBOutlet weak var genotypeAnimalNameTextfield: UITextField!
    
    @IBOutlet weak var genotypeMaleFemaleBttn: UIButton!
    
    @IBOutlet weak var genotypeTissueHideLbl: UILabel!
    
    @IBOutlet weak var genotypeRgdTextfield: UITextField!
    
    @IBOutlet weak var calenderViewOutlet: UIView!
    
    @IBOutlet weak var priorityBreeingBtnOutlet: customButton!
    
    @IBOutlet weak var secondaryBreddingOutlet: customButton!
    
    @IBOutlet weak var secondaryHidenLbl: UILabel!
    
    @IBOutlet weak var priorityBreddingLbl: UILabel!
    
    var genderString = String()
    
    var othersGenderString = String()
    
    
        var selectedDate = Date()
    var btnTag = Int()
    
    var priorityBreeding = NSArray()
    
    var secondaryBreeding = NSArray()
    
    var tissueArr = NSArray()
    
    let buttonbg2 = UIButton ()
    
    var droperTableView  = UITableView ()
     var datePicker : UIDatePicker!
    var genderToggleFlag : Int = 0
       var timeStampString = String()
    var othersGenderToggleFlag : Int = 0
     var addContiuneBtn = Int()
    var scanAnimalText = String()
    var farmIdText = String()
    let buttonbg1 = UIButton ()
    var customPopView1 :TipPopUp!
    var animalTag = true
    var sireIdBool = true
    var offPmidBool = true
    var barCodeIdBool = true
    var damIdBool = true
    var farmIdTagBool = true
    var idAnimal = Int()
    var isUpdate = Bool()
    var msgUpatedd = Bool()
    var animalSucInOrder = String()
    var isGenotypeOnlyAdded = false
    var animalIdBool = Bool()
    // var droperTableView  = UITableView ()
    var breedArr = NSArray()
    var breedRegArr = NSArray()
    var breedId = Int()
    var tissuId = Int()
    var animalId1 = Int()
    let toolBar = UIToolbar()
    var identify = Bool()
    var identify1 = Bool()
    var msgcheckk  = Bool()
    var isautoPopulated = false
    var statusOrder = Bool()
    var updateOrder = Bool()
    var editIngText = Bool()
    var autoD = Int()
    var editAid = Int()
    var messageCheck = Bool()
    var msgAnimalSucess = Bool()
    let userId = UserDefaults.standard.integer(forKey: "userId")
    let orderId = UserDefaults.standard.integer(forKey: "orderId")
    var langId = UserDefaults.standard.value(forKey: "lngId") as? Int
     @IBOutlet weak var notificationLblCount: UILabel!
    
     @IBOutlet weak var countLbl: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
            UserDefaults.standard.set("BR", forKey: "Brazil")
        self.GenotypetextfieldLeftPadding()
        
        self.GenotypebyDefaultScreen()
        
        self.byDefaultSetting()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initialNetworkCheck()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg = self
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        landIdApplangaugeConversion(langid: langId!)
        let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false")
        notificationLblCount.text = String(animalCount.count)
        if animalCount.count == 0{
            notificationLblCount.isHidden = true
            countLbl.isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true
        
        
        let selectedProduct = fetchAllData(entityName: "GetProductTblBeef")
        
        for product in selectedProduct as? [GetProductTblBeef] ?? [] {
            if product.productName?.uppercased() == "Genotype Only".uppercased() {
                 UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                isGenotypeOnlyAdded = true
            }
            else{
                UserDefaults.standard.set(Int(product.productId), forKey: "BfProductId")
                
            }
        }
        
        if isGenotypeOnlyAdded {
            print("Added")
            genotypeScrollView.isHidden = false
            scrolView.isHidden = true
            genotypeView.isHidden = false
             UserDefaults.standard.set("Genotype Only", forKey: "beefProduct")
        } else {
            UserDefaults.standard.set("Non-Genotype", forKey: "beefProduct")
            genotypeScrollView.isHidden = true
            scrolView.isHidden = false
             genotypeView.isHidden = true
            print("Not Added ")
        }
        otherBorderColor()
        
        genotypeSetBorder()
        autoD = UserDefaults.standard.integer(forKey: "orderId")
        timeStampString = timeStamp()
          UserDefaults.standard.set(timeStampString, forKey: "timeStamp")
        timeStampString = UserDefaults.standard.value(forKey: "timeStamp") as? String ?? ""
        if UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart") > 0 {
            var temp = UserDefaults.standard.integer(forKey: "BeefAnimalIdSelectionCart")
            animalIdBool = true
            othersByDefaultBackroundWhite()
            UserDefaults.standard.set(0, forKey: "BeefAnimalIdSelectionCart")
            dataPopulateInScreen(animalId: temp)
            isautoPopulated = true
            messageCheck = true
            
        }
    }
    func timeStamp()-> String{
        
        var time1 = NSDate()
        
        var formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyyHH:mm:ss"
        var timestamp = formatter.string(from: time1 as Date)
        lblTimeStamp = timestamp.replacingOccurrences(of: "-", with: "", options: .regularExpression)
        lblTimeStamp = lblTimeStamp.replacingOccurrences(of: ":", with: "", options: .regularExpression)
        let string = lblTimeStamp as String
        let charset = CharacterSet(charactersIn: "i")
        if string.rangeOfCharacter(from: charset) != nil {
            // print("yes")
        }
        let udid = UserDefaults.standard.value(forKey: "ApplicationIdentifier")! as! String
        let sessionGUID1 =   lblTimeStamp + "_" + String(describing: autoD as Int)
        lblTimeStamp = sessionGUID1 + "_" + "iOS" + "_" + String(udid)
        return lblTimeStamp
    }
    func dataPopulateInScreen(animalId:Int){
        isautoPopulated = true
        var samplename = String()
        var animalFetch = NSArray()
        let userId = UserDefaults.standard.integer(forKey: "userId")
        if !isGenotypeOnlyAdded {
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl", animalId: animalId)
                var data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: "userId")
                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                animalId1 = Int(data.animalId)
                /////////end
                
                
                
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                animalTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                     if values.count > 1 {
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        
                    }
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "MM/dd/yyyy"
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                     if values.count > 1 {
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = date + "/" + month + "/" + year
                    }
                    dateBttnOutlet.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if dateBttnOutlet.titleLabel!.text != nil{
                self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                
                
                }
                else{
                    self.selectedDate = Date()
                }
                let dates =  formatter.string(from: selectedDate)
                scanBarcodeTextfield.text = data.animalTag
                rGNTextfield.text = data.offPermanentId
                serieTextfield.text = data.offsireId
                rGDTextfield.text = data.offDamId
                
                //                animalNameTextfield.text  = data.anima
                
                tissueBttn.setTitleColor(.black, for: .normal)
                animalTextfield.text = data.animalbarCodeTag
                tissueBttn.setTitle(data.tissuName, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "tissueBttn")
                
                breedId = Int(data.breedId)
                samplename = data.tissuName!
                let pvidAA = data.providerId
             
                
                if data.gender == "Male" {
                    
                    self.maleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
                    genderToggleFlag = 1
                    genderString = "Male"
                    
                } else {
                    
                    self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
                    genderToggleFlag = 0
                    genderString = "Female"
                    
                }

                
                
                tissuId = Int(data.tissuId)
                
                dateBttnOutlet.setTitleColor(.black, for: .normal)
                let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    // statusOrder = true
                }
                
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal)
                if animalFetch.count > 0 {
                    var  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    let userId = UserDefaults.standard.integer(forKey: "userId")
                    let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                    animalId1 = Int(data.animalId)
                    /////////end
                    
                    
                    barcodeView.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    animalTextfield.layer.borderColor = UIColor.gray.cgColor
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    //
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                    var formatter = DateFormatter()
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                         if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        }
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                        formatter.dateFormat = "MM/dd/yyyy"
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                         if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        }
                        dateBttnOutlet.setTitle(dateVale, for: .normal)
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                    if dateBttnOutlet.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
                    
                    
                    }
                    else{
                        self.selectedDate = Date()
                    }
                    let dates =  formatter.string(from: selectedDate)
                    scanBarcodeTextfield.text = data.animalTag
                    rGNTextfield.text = data.offPermanentId
                    serieTextfield.text = data.offsireId
                    rGDTextfield.text = data.offDamId
                    
                    //                animalNameTextfield.text  = data.anima
                    
                    tissueBttn.setTitleColor(.black, for: .normal)
                    animalTextfield.text = data.animalbarCodeTag
                    tissueBttn.setTitle(data.tissuName, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: "tissueBttn")
                    
                    breedId = Int(data.breedId)
                    samplename = data.tissuName!
                    let pvidAA = data.providerId
                    //UserDefaults.standard.set(breedId, forKey: "Beefbreed")
                    
                    if data.gender == "Male" {
                        
                        self.maleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
                        genderToggleFlag = 1
                        genderString = "Male"
                        
                    } else {
                        
                        self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
                        genderToggleFlag = 0
                        genderString = "Female"
                        
                    }

                    
                    
                    let screenRefernce = UserDefaults.standard.value(forKey:"screen") as! String
                    
                    
                    tissuId = Int(data.tissuId)
                    
                    dateBttnOutlet.setTitleColor(.black, for: .normal)
                    let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                    let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    animalIdBool = false
                    
                    
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        statusOrder = true
                    }
                }
            }
        }
        else{
            GenotypebyDefaultbackroundWhite()
            if animalIdBool == true {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimaladdTbl", animalId: animalId)
                var data = animalFetch.object(at: 0) as! BeefAnimaladdTbl
                let userId = UserDefaults.standard.integer(forKey: "userId")
                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                animalId1 = Int(data.animalId)
                /////////end
                
                
                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                //
                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                var formatter = DateFormatter()
                
                if dateStr == "MM"{
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                    if values.count > 1 {
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = month + "/" + date + "/" + year
                    }
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "MM/dd/yyyy"
                }
                else {
                    var dateVale = ""
                    let values = data.date!.components(separatedBy: "/")
                     if values.count > 1 {
                    let date = values[0]
                    let month = values[1]
                    let year = values[2]
                    dateVale = date + "/" + month + "/" + year
                    }
                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
                    formatter.dateFormat = "dd/MM/yyyy"
                }
                if genotypeDOBBttn.titleLabel!.text != nil{
                self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
               
                }
                else{
                    self.selectedDate = Date()
                }
                let dates =  formatter.string(from: selectedDate)
                genotypeScanBarcodeTextField.text = data.animalTag
                genotypeRgnTextfield.text = data.offPermanentId
                genotypeSerieTextfield.text = data.offsireId
                genotypeRgdTextfield.text = data.offDamId
                genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                //                animalNameTextfield.text  = data.anima
                priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                genotypeTissueBttn.setTitleColor(.black, for: .normal)
                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
                
                breedId = Int(data.breedId)
                samplename = data.tissuName!
                let pvidAA = data.providerId
                // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
                UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
                if data.gender == "Male" {
                    
                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
                    genderToggleFlag = 1
                    genderString = "Male"
                    
                    
                } else {
                    
                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
                    genderToggleFlag = 0
                    genderString = "Female"
                    
                }
                
                
                
                tissuId = Int(data.tissuId)
                  genotypeDOBBttn.setTitleColor(.black, for: .normal)
                let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                
                animalIdBool = false
                
                if adata.count > 0{
                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
                    idAnimal = Int(animal.animalId)
                    // statusOrder = true
                }
                
            } else {
                animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal)
                if animalFetch.count > 0 {
                    var  data = animalFetch.object(at: 0) as! BeefAnimalMaster
                    
                    
                    
                    let userId = UserDefaults.standard.integer(forKey: "userId")
                    let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
                    animalId1 = Int(data.animalId)
                    /////////end
                    
                    genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    //
                    let dateStr = UserDefaults.standard.value(forKey: "date") as? String
                    var formatter = DateFormatter()
                    
                    if dateStr == "MM"{
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                         if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = month + "/" + date + "/" + year
                        }
                        genotypeDOBBttn.setTitle(dateVale, for: .normal)
                        formatter.dateFormat = "MM/dd/yyyy"
                    }
                    else {
                        var dateVale = ""
                        let values = data.date!.components(separatedBy: "/")
                         if values.count > 1 {
                        let date = values[0]
                        let month = values[1]
                        let year = values[2]
                        dateVale = date + "/" + month + "/" + year
                        }
                        genotypeDOBBttn.setTitle(dateVale, for: .normal)
                        formatter.dateFormat = "dd/MM/yyyy"
                    }
                     if genotypeDOBBttn.titleLabel!.text != nil{
                    self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
                    
                    }
                     else{
                    self.selectedDate = Date()
                    }
                    let dates =  formatter.string(from: selectedDate)
                    genotypeScanBarcodeTextField.text = data.animalTag
                    genotypeRgnTextfield.text = data.offPermanentId
                    genotypeSerieTextfield.text = data.offsireId
                    genotypeRgdTextfield.text = data.offDamId
                    genotypeAnimalNameTextfield.text = data.animalbarCodeTag
                    //                animalNameTextfield.text  = data.anima
                    priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
                    genotypeTissueBttn.setTitleColor(.black, for: .normal)
                    priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
                    genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
                    secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
                    secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
                    UserDefaults.standard.set(data.tissuName, forKey: "genotypeTissueBttn")
                    
                    breedId = Int(data.breedId)
                    samplename = data.tissuName!
                    let pvidAA = data.providerId
                    // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
                    UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
                    if data.gender == "Male" {
                        
                        self.genotypeMaleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
                        genderToggleFlag = 1
                        genderString = "Male"
                        
                        
                    } else {
                        
                        self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
                        genderToggleFlag = 0
                        genderString = "Female"
                        
                    }
                    
                    
                    
                    let screenRefernce = UserDefaults.standard.value(forKey:"screen") as! String
                    
                    
                    tissuId = Int(data.tissuId)
                    
                    genotypeDOBBttn.setTitleColor(.black, for: .normal)
                    let fetch = fetchAllData(entityName: "BeefAnimalMaster")
                    let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
                    animalIdBool = false
                    
                    
                    if adata.count > 0{
                        let animal  = adata.object(at: 0) as! BeefAnimalMaster
                        idAnimal = Int(animal.animalId)
                        statusOrder = true
                    }
                }
            }
        }
    }
    func statusOrderTrue() -> Bool{
        
        let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal)
        if animalFetch.count > 0{
            statusOrder = true
            return true
        }else{
            return false
        }
        
    }
    @IBAction func sideMenuAction(_ sender: UIButton) {
        
        self.sideMenuViewController?.presentRightMenuViewController()
        self.view.makeCorner(withRadius: 40)
    }
    
    func GenotypetextfieldLeftPadding(){

        genotypeScanBarcodeTextField.addPadding(.left(20))
        
        genotypeSerieTextfield.addPadding(.left(20))
        
        genotypeRgnTextfield.addPadding(.left(20))
        
        genotypeAnimalNameTextfield.addPadding(.left(20))
        
        genotypeRgdTextfield.addPadding(.left(20))
        scanBarcodeTextfield.addPadding(.left(20))
        
        serieTextfield.addPadding(.left(20))
        
        rGNTextfield.addPadding(.left(20))
        
        rGDTextfield.addPadding(.left(20))
        
        animalTextfield.addPadding(.left(20))
 
    }
    //  MARK: - OtherType
    func otherBorderColor(){
        serieTextfield.layer.cornerRadius = (serieTextfield.frame.size.height / 2)
        
        serieTextfield.layer.borderWidth = 0.5
        
        serieTextfield.layer.borderColor = UIColor.gray.cgColor
        
        serieTextfield.layer.masksToBounds = true
        
        
        
        rGNTextfield.layer.cornerRadius = (rGNTextfield.frame.size.height / 2)
        
        rGNTextfield.layer.borderWidth = 0.5
        
        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
        
        rGNTextfield.layer.masksToBounds = true
        
        
        
        rGDTextfield.layer.cornerRadius = (rGDTextfield.frame.size.height / 2)
        
        rGDTextfield.layer.borderWidth = 0.5
        
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        
        rGDTextfield.layer.masksToBounds = true
        
        
        
        animalTextfield.layer.cornerRadius = (animalTextfield.frame.size.height / 2)
        
        animalTextfield.layer.borderWidth = 0.5
        
        animalTextfield.layer.borderColor = UIColor.gray.cgColor
        
        animalTextfield.layer.masksToBounds = true
        
        
        
        barcodeView.layer.cornerRadius = (barcodeView.frame.size.height / 2)
        
        barcodeView.layer.borderWidth = 0.5
        
        barcodeView.layer.borderColor = UIColor.gray.cgColor
        
        barcodeView.layer.masksToBounds = true
        
        
        
        dobView.layer.cornerRadius = (dobView.frame.size.height / 2)
        
        dobView.layer.borderWidth = 0.5
        
        dobView.layer.borderColor = UIColor.gray.cgColor
        
        dobView.layer.masksToBounds = true
        
        
        
        tissueBttn.layer.borderWidth = 0.5
        
        tissueBttn.layer.borderColor = UIColor.gray.cgColor
        
        
        
    }
    
    
    
    
    
    func othersByDefaultBackroundWhite(){
        
        
        
        scanBarcodeTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        serieTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        rGNTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        rGDTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        animalTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        dateBttnOutlet.layer.backgroundColor = UIColor.white.cgColor
        
        tissueBttn.layer.backgroundColor = UIColor.white.cgColor
        
        serieTextfield.isEnabled = true
        
        rGNTextfield.isEnabled = true
        
        rGDTextfield.isEnabled = true
        
        animalTextfield.isEnabled = true
        
        dateBttnOutlet.isEnabled = true
         barcodeBttn.isEnabled = true
        
        
        tissueBttn.isEnabled = true
        
        maleFemaleBttn.isEnabled = true
        
        dateBttnOutlet.isEnabled = true
        
        tissueBttn.setTitleColor(.black, for: .normal)
        
        dateBttnOutlet.setTitleColor(.black, for: .normal)
        
        //otherBorderColor()
        
    }
    
    func byDefaultSetting(){
        
        let dateformt = DateFormatter()
        
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        
        if dateStr == "MM" {
            
            dateformt.dateFormat = "MM/dd/yyyy"
            
        } else {
            
            dateformt.dateFormat = "dd/MM/yyyy"
            
        }
        
                animalId1 = 0
        
                idAnimal = 0
        
                isUpdate = false
        
                msgUpatedd = false
        
                self.msgcheckk = false
        
                self.isautoPopulated = false
        
        dateBttnOutlet.setTitleColor(UIColor.gray, for: .normal)
        
        
        
        // isautoPopulated = false
        
        let dte = Date()
        
       // dateBttnOutlet.setTitle( dateformt.string(from: dte ), for: .normal)
        
        
        
        //SplitEmbryoOutlet.layer.borderWidth = 0.5
        
        //        internalBtnOulet.layer.borderWidth = 0.5
        
        //        scanEarTagTextField.layer.borderWidth = 0.5
        
        //        scanBarcodeTextfield.layer.borderWidth = 0.5
        
        
        
        serieTextfield.layer.borderColor = UIColor.gray.cgColor
        
        
        
        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
        
        
        
        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        
        
        
        animalTextfield.layer.borderColor = UIColor.gray.cgColor
        
        
        
        
        
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        
        
        
        dateBttnOutlet.layer.borderColor = UIColor.gray.cgColor
        
        
        
        scanBarcodeTextfield.text?.removeAll()
        
        serieTextfield.text?.removeAll()
        
        rGNTextfield.text?.removeAll()
        
        rGDTextfield.text?.removeAll()
        
        animalTextfield.text?.removeAll()
        
        
        
        
        
        tissueBttn.setTitle("Allflex (TSU)", for: .normal)
        
        self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
        
                genderToggleFlag = 0
        
                genderString = "Female"
        
        
        
                if UserDefaults.standard.string(forKey: "tissueBttn") == nil{
        
                    tissueBttn.setTitle("Allflex (TSU)", for: .normal)
                    tissuId = 16
        
                }
        
                else{
        
                    tissueBttn.setTitle(UserDefaults.standard.string(forKey: "tissueBttn"), for: .normal)
        
                }
        
        
        
        
        
        //  self.selectedDate = Date()
        
        OtherbyTextfieldGray()
        
        self.scrolView.contentOffset.y = 0.0
        
        
        
    }
    
    func OtherbyTextfieldGray(){
        
        serieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        rGNTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        rGDTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        animalTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        dateBttnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        dobView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        tissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        
        barcodeBttn.isEnabled = false
        serieTextfield.isEnabled = false
        
        rGNTextfield.isEnabled = false
        
        rGDTextfield.isEnabled = false
        
        animalTextfield.isEnabled = false
        
        dateBttnOutlet.isEnabled = false
        
        tissueBttn.isEnabled = false
        
        maleFemaleBttn.isEnabled = false
        
        dateBttnOutlet.isEnabled = false
        
        tissueBttn.setTitleColor(.gray, for: .normal)
        
        
        
        dateBttnOutlet.setTitleColor(.gray, for: .normal)
        
        // otherBorderColor()
        
        
        
    }
    
    func validation(){
        
        if  scanBarcodeTextfield.text == ""{
            
            barcodeView.layer.borderColor = UIColor.red.cgColor
            
        }
            
        else{
            
            barcodeView.layer.borderColor = UIColor.gray.cgColor
            
        }
        if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
            requiredflag = 0
        }
        if requiredflag == 1{
            serieTextfield.layer.borderColor = UIColor.gray.cgColor
            rGNTextfield.layer.borderColor = UIColor.gray.cgColor
            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
        }
        else{
            serieTextfield.layer.borderColor = UIColor.red.cgColor
            rGNTextfield.layer.borderColor = UIColor.red.cgColor
            rGDTextfield.layer.borderColor = UIColor.red.cgColor
        }
        
//        if  serieTextfield.text == ""{
//
//            serieTextfield.layer.borderColor = UIColor.red.cgColor
//
//        }
//
//        else{
//
//            serieTextfield.layer.borderColor = UIColor.gray.cgColor
//
//        }
//
//        if  rGNTextfield.text == ""{
//
//            rGNTextfield.layer.borderColor = UIColor.red.cgColor
//
//        }
//
//        else{
//
//            rGNTextfield.layer.borderColor = UIColor.gray.cgColor
//
//        }
//
//        if  rGDTextfield.text == ""{
//
//            rGDTextfield.layer.borderColor = UIColor.red.cgColor
//
//        }
//
//        else{
//
//            rGDTextfield.layer.borderColor = UIColor.gray.cgColor
//
//        }
        
//        if  animalTextfield.text == ""{
//
//            animalTextfield.layer.borderColor = UIColor.red.cgColor
//
//        }
//
//        else{
//
//            animalTextfield.layer.borderColor = UIColor.gray.cgColor
//
//        }
        
        
        
        
        
        
        
    }
    
    
    
    //  MARK: - Genotype
    
    
    
    func GenotypebyDefaultbackroundWhite(){
        
        genotypeScanBarcodeView.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeSerieTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeRgnTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeAnimalNameTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeRgdTextfield.layer.backgroundColor = UIColor.white.cgColor
        
        calenderViewOutlet.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeTissueBttn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeDOBBttn.layer.backgroundColor = UIColor.white.cgColor
        
        genotypeSerieTextfield.isEnabled = true
        
        genotypeRgnTextfield.isEnabled = true
        
        genotypeAnimalNameTextfield.isEnabled = true
        
        genotypeRgdTextfield.isEnabled = true
        genotypeBarcodeBttn.isEnabled = true
        calenderViewOutlet.isUserInteractionEnabled = true
        
        genotypeDOBBttn.isEnabled = true
        
        genotypeTissueBttn.isEnabled = true
        
        priorityBreeingBtnOutlet.isEnabled = true
        
        secondaryBreddingOutlet.isEnabled = true
        
        
        
        priorityBreeingBtnOutlet.backgroundColor = UIColor.white
        
        secondaryBreddingOutlet.backgroundColor = UIColor.white
        
        secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
        priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
        genotypeTissueBttn.setTitleColor(.black, for: .normal)
        
        
        
    }
    
    
    
    func GenotypebyDefaultbackroundGray(){
        
        genotypeDOBBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        
        
        calenderViewOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeSerieTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeRgnTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeAnimalNameTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        genotypeRgdTextfield.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
         secondaryBreddingOutlet.setTitleColor(.gray, for: .normal)
         priorityBreeingBtnOutlet.setTitleColor(.gray, for: .normal)
        genotypeTissueBttn.setTitleColor(.gray, for: .normal)
        priorityBreeingBtnOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        secondaryBreddingOutlet.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        
        
        genotypeTissueBttn.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        genotypeBarcodeBttn.isEnabled = false
        genotypeSerieTextfield.isEnabled = false
        
        genotypeRgnTextfield.isEnabled = false
        
        genotypeAnimalNameTextfield.isEnabled = false
        
        genotypeRgdTextfield.isEnabled = false
        
        calenderViewOutlet.isUserInteractionEnabled = false
        
        genotypeDOBBttn.isEnabled = false
        
        genotypeTissueBttn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        
        secondaryBreddingOutlet.isEnabled = false
        
        
        
        maleFemaleBttn.isEnabled = false
        
        tissueBttn.isEnabled = false
        
        
        
        priorityBreeingBtnOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        secondaryBreddingOutlet.backgroundColor =  UIColor(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        
        
        
        
    }
    
    func genotypeSetBorder(){
        
        
        
        genotypeTissueBttn.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        
        genotypeTissueBttn.layer.borderWidth = 0.5
        
        genotypeTissueBttn.layer.borderColor = UIColor.gray.cgColor
        
        genotypeTissueBttn.layer.masksToBounds = true
        
        
        
        genotypeScanBarcodeView.layer.cornerRadius = (genotypeScanBarcodeView.frame.size.height / 2)
        
        genotypeScanBarcodeView.layer.borderWidth = 0.5
        
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        
        genotypeScanBarcodeView.layer.masksToBounds = true
        
        
        
        genotypeDOBBttn.layer.cornerRadius = (genotypeDOBBttn.frame.size.height / 2)
        
        genotypeDOBBttn.layer.borderWidth = 0.5
        
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        
        genotypeDOBBttn.layer.masksToBounds = true
        
        
        
        genotypeSerieTextfield.layer.cornerRadius = (genotypeSerieTextfield.frame.size.height / 2)
        
        genotypeSerieTextfield.layer.borderWidth = 0.5
        
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeSerieTextfield.layer.masksToBounds = true
        
        
        
        genotypeRgnTextfield.layer.cornerRadius = (genotypeRgnTextfield.frame.size.height / 2)
        
        genotypeRgnTextfield.layer.borderWidth = 0.5
        
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeRgnTextfield.layer.masksToBounds = true
        
        
        
        genotypeAnimalNameTextfield.layer.cornerRadius = (genotypeAnimalNameTextfield.frame.size.height / 2)
        
        genotypeAnimalNameTextfield.layer.borderWidth = 0.5
        
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeAnimalNameTextfield.layer.masksToBounds = true
        
        
        
        genotypeRgdTextfield.layer.cornerRadius = (genotypeRgdTextfield.frame.size.height / 2)
        
        genotypeRgdTextfield.layer.borderWidth = 0.5
        
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeRgdTextfield.layer.masksToBounds = true
        
        
        
        priorityBreeingBtnOutlet.layer.cornerRadius = (priorityBreeingBtnOutlet.frame.size.height / 2)
        
        priorityBreeingBtnOutlet.layer.borderWidth = 0.5
        
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        
        priorityBreeingBtnOutlet.layer.masksToBounds = true
        
        
        
        secondaryBreddingOutlet.layer.cornerRadius = (secondaryBreddingOutlet.frame.size.height / 2)
        
        secondaryBreddingOutlet.layer.borderWidth = 0.5
        
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        
        secondaryBreddingOutlet.layer.masksToBounds = true
        
        
        
    }
    
    func GenotypebyDefaultScreen(){
        
        //  MARK: - Genotype
        
        genderToggleFlag = 0
        
        genderString = "Female"
        animalId1 = 0
        
        idAnimal = 0
        
        isUpdate = false
        
        msgUpatedd = false
        
        self.msgcheckk = false
        
        self.isautoPopulated = false

        genotypeScanBarcodeTextField.text?.removeAll()
        
        genotypeSerieTextfield.text?.removeAll()
        
        genotypeRgnTextfield.text?.removeAll()
        
        genotypeAnimalNameTextfield.text?.removeAll()
        
        genotypeRgdTextfield.text?.removeAll()
        
        
        
        genotypeSerieTextfield.isEnabled = false
        
        genotypeRgnTextfield.isEnabled = false
        
        genotypeAnimalNameTextfield.isEnabled = false
        
        genotypeRgdTextfield.isEnabled = false
        
        calenderViewOutlet.isUserInteractionEnabled = false
        
        genotypeDOBBttn.isEnabled = false
        
        genotypeTissueBttn.isEnabled = false
        
        priorityBreeingBtnOutlet.isEnabled = false
        
        secondaryBreddingOutlet.isEnabled = false
        
        priorityBreeingBtnOutlet.setTitle("Priority Breeding", for: .normal)
         secondaryBreddingOutlet.setTitle("Secondary Breeding", for: .normal)
        
        maleFemaleBttn.isEnabled = false
        
        tissueBttn.isEnabled = false
        
        
        
        genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
        
        genotypeDOBBttn.layer.borderColor = UIColor.gray.cgColor
        
        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
        
        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
        
        priorityBreeingBtnOutlet.layer.borderColor = UIColor.gray.cgColor
        
        secondaryBreddingOutlet.layer.borderColor = UIColor.gray.cgColor
        
        tissueBttn.layer.borderColor = UIColor.gray.cgColor
        
        GenotypebyDefaultbackroundGray()
         self.scrolView.contentOffset.y = 0.0
        if UserDefaults.standard.string(forKey: "genotypeTissueBttn") == nil{
            
            genotypeTissueBttn.setTitle("Allflex (TSU)", for: .normal)
            tissuId = 16
            
        }
            
        else{
            
            genotypeTissueBttn.setTitle(UserDefaults.standard.string(forKey: "genotypeTissueBttn"), for: .normal)
            
        }
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        print(self.genotypeScrollView.contentOffset.y)
        
    }
    
    @IBAction func tissureBtnAction(_ sender: Any) {
        
        //  MARK: - Genotype
        
        
        
        btnTag = 10
        
        view.endEditing(true)
        
        
        
        let pvid = UserDefaults.standard.integer(forKey: "Pvid")
        
        tissueArr = fetchproviderData(entityName: "GetSampleTbl", provId: pvid)
        
        self.tableViewpop()
        
        var yFrame = (genotypeTissueHideLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        
        
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                
                strDeviceType = "iPhone 5 or 5S or 5C"
                
            case 1334:
                
                strDeviceType = "iPhone 6/6S/7/8"
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 100) - self.genotypeScrollView.contentOffset.y
                
                
                
            case 1920, 2208:
                
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 113) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                
                strDeviceType = "iPhone X"
                
            case 2688:
                
                strDeviceType = "iPhone Xs Max"
                
            case 1792:
                
                yFrame = (genotypeTissueHideLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
                
                
                strDeviceType = "iPhone Xr"
                
            default:
                
                strDeviceType = "unknown"
                
            }
            
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
        
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    
    
    
    
    
    func tableViewpop() {
        
        //  MARK: - Genotype
        
        
        
        buttonbg2.frame = CGRect(x:0,y: 0,width: 1024,height: 1000)
        
        buttonbg2.addTarget(self, action:#selector(BeefAnimalBrazilVC.buttonPreddDroper), for: .touchUpInside)
        
        buttonbg2.backgroundColor = UIColor(red: 45/255, green:45/255, blue:45/255, alpha:0.3)
        
        self.view.addSubview(buttonbg2)
        
        droperTableView.delegate = self
        
        droperTableView.dataSource = self
        
        droperTableView.layer.cornerRadius = 8.0
        
        droperTableView.layer.borderWidth = 0.5
        
        droperTableView.layer.borderColor =  UIColor.gray.cgColor
        
        buttonbg2.addSubview(droperTableView)
        
    }
    
    
    
    @objc func buttonPreddDroper() {
        
        buttonbg2.removeFromSuperview()
        
    }
    
    
    
    
    
    @IBAction func prioorityBreddingAction(_ sender: Any) {
        
        //  MARK: - Genotype
        
        
        
        btnTag = 20
        
        view.endEditing(true)
        
        
        
        priorityBreeding = fetchAllData(entityName: "GetPriorityBreeding")
        
        self.tableViewpop()
        
        var yFrame = (priorityBreddingLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        
        
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                
                strDeviceType = "iPhone 5 or 5S or 5C"
                
            case 1334:
                
                strDeviceType = "iPhone 6/6S/7/8"
                
                yFrame = (priorityBreddingLbl.frame.minY + 100) - self.genotypeScrollView.contentOffset.y
                
                
                
            case 1920, 2208:
                
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                
                yFrame = (priorityBreddingLbl.frame.minY + 120) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                
                strDeviceType = "iPhone X"
                
            case 2688:
                
                strDeviceType = "iPhone Xs Max"
                
            case 1792:
                
                yFrame = (priorityBreddingLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
                
                
                strDeviceType = "iPhone Xr"
                
            default:
                
                strDeviceType = "unknown"
                
            }
            
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
        
    }
    
    
    
    
    
    @IBAction func secondayBtnAction(_ sender: Any) {
        
        
        
        btnTag = 30
        
        view.endEditing(true)
        
        
        
        secondaryBreeding = fetchAllData(entityName: "GetPriorityBreeding")
        
        self.tableViewpop()
        
        var yFrame = (secondaryHidenLbl.frame.minY + 130) - self.genotypeScrollView.contentOffset.y
        
        
        
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                
                strDeviceType = "iPhone 5 or 5S or 5C"
                
            case 1334:
                
                strDeviceType = "iPhone 6/6S/7/8"
                
                yFrame = (secondaryHidenLbl.frame.minY + 100) - self.genotypeScrollView.contentOffset.y
                
                
                
            case 1920, 2208:
                
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                
                yFrame = (secondaryHidenLbl.frame.minY + 119) - self.genotypeScrollView.contentOffset.y
                
            case 2436:
                
                strDeviceType = "iPhone X"
                
            case 2688:
                
                strDeviceType = "iPhone Xs Max"
                
            case 1792:
                
                yFrame = (secondaryHidenLbl.frame.minY + 143) - self.genotypeScrollView.contentOffset.y
                
                
                
                strDeviceType = "iPhone Xr"
                
            default:
                
                strDeviceType = "unknown"
                
            }
            
        }
        
        droperTableView.frame = CGRect(x: 25,y: yFrame,width: 300,height: 250)
        
        droperTableView.reloadData()
        
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    
    
    @IBAction func genotypeAddAnimalAction(_ sender: UIButton) {
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
        })
        self.view.endEditing(true)
        
       // textFieldValidation()
        
        
        
    }
    
    @IBAction func genotypeContinueProductAction(_ sender: UIButton) {
        
        
        addContiuneBtn = 2
        
        let  userId = UserDefaults.standard.integer(forKey: "userId")
        let  orderId = UserDefaults.standard.integer(forKey: "orderId")
        identify1 = true
        let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
        
        let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
        
        if  identyCheck == false || identyCheck == nil{
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    if UserDefaults.standard.value(forKey: "page")  == nil {
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                        
                    } else {
                        if identyCheck == false || identyCheck == nil {
                            if  UserDefaults.standard.value(forKey: "page") == nil {
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                            }
                            else{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                        }
                        else {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            
                        }
                    }
                } else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        
                        
                        if success == true{
                            
                            let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                            if  identyCheck == true {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }  else {
                                if UserDefaults.standard.value(forKey: "page")  == nil{
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                    
                                } else {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    
                                }
                            }
                        }
                    })
                }
            }
            else {
                
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                    self.validation()
                    
                }
                else {
                    
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            if UserDefaults.standard.value(forKey: "page")  == nil{
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                
                            } else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
                                    self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                        }
                    })
                    
                    
                }
            }
        }
        else{
            
            if data1.count > 0 {
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
                    
                    let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                    if  identyCheck == true {
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        
                    }  else {
                        
                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                            if  identyCheck == true {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }  else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                        }
                    })
                }
            }
            else{
                addAnimalBtn(completionHandler: { (success) -> Void in
                    if success == true{
                        let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                        if  identyCheck == true {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        }
                        else {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            
                        }
                    }
                })
            }
        }
        
    }
    
    
    
    @IBAction func maleBtnClick(_ sender: Any) {
        
        //  MARK: - Genotype
        
        
        
        self.view.endEditing(true)
        
        
        
        if(genderToggleFlag == 0) {
            
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
            
            genderToggleFlag = 1
            
            genderString = "Male"
            
        }
            
        else {
            
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            
            genderToggleFlag = 0
            
            genderString = "Female"
            
        }
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    
    
    func textFieldValidation(){
        
        //  MARK: - Genotype
        
        
        
        if genotypeScanBarcodeTextField.text == ""{
            
            genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
            
        }
            
        else {
            
            genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
            
        }
        
        
        
     
        
//
//        if genotypeAnimalNameTextfield.text == ""{
//
//            genotypeAnimalNameTextfield.layer.borderColor = UIColor.red.cgColor
//
//        }
//
//        else {
//
//            genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
//
//        }
        
        if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
            if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                requiredflag = 1
            }else{
                requiredflag = 0
            }
            
        }
        
      
        
            if requiredflag == 1{
                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
            }
            else{
                genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
            }
            
        
        
        
    }
    
    
    //  MARK: - OtherView
    
    func landIdApplangaugeConversion(langid:Int){
        
        if langid == 2 {
            
            animalTextfield.placeholder = "Digite o nome do animal"
            dateBttnOutlet.setTitle("Data de nascimento",for: .normal)
            maleFemaleBttn.setTitle("",for: .normal)
            tissueBttn.setTitle("Allflex(TSU)",for: .normal)
            rGDTextfield.placeholder = "RGD"
            rGNTextfield.placeholder = "RGN"
            serieTextfield.placeholder = "Série"
            scanBarcodeTextfield.placeholder = "Escanear / Inserir código de barras da amostra"
            
            //GENOTYPE
            genotypeScanBarcodeTextField.placeholder = "Escanear / Inserir código de barras da amostra"
            genotypeSerieTextfield.placeholder = "Série"
            genotypeRgnTextfield.placeholder = "RGN"
            genotypeAnimalNameTextfield.placeholder = "Digite o nome do animal"
            genotypeRgdTextfield.placeholder = "RGD ou ID Animal"
            priorityBreeingBtnOutlet.setTitle("Selecione Genótipo Raça primária",for: .normal)
            secondaryBreddingOutlet.setTitle("Selecione Genótipo Raça Secundária",for: .normal)
            
        }
    }

    
    @IBAction func otherMaleBtnAction(_ sender: Any) {
        
  
        
        self.view.endEditing(true)
        
        
        
        if(othersGenderToggleFlag == 0) {
            
            self.maleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
            
            othersGenderToggleFlag = 1
            
            othersGenderString = "Male"
            genderString = othersGenderString
        }
            
        else {
            
            self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            
            othersGenderToggleFlag = 0
            
            othersGenderString = "Female"
             genderString = othersGenderString
        }
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    
    
    
    
   
    
    
    
    
    
    @IBAction func OtherTissuebtnAction(_ sender: Any) {
        
        
        
        btnTag = 40
        
        view.endEditing(true)
        
        
        
        let pvid = UserDefaults.standard.integer(forKey: "Pvid")
        
        tissueArr = fetchproviderData(entityName: "GetSampleTbl", provId: pvid)
        
        self.tableViewpop()
        
        var yFrame = (tissueHideLbl.frame.minY + 130) - self.scrolView.contentOffset.y
        
        
        
        var strDeviceType = ""
        
        if UIDevice().userInterfaceIdiom == .phone {
            
            switch UIScreen.main.nativeBounds.height {
                
            case 1136:
                
                strDeviceType = "iPhone 5 or 5S or 5C"
                
            case 1334:
                
                strDeviceType = "iPhone 6/6S/7/8"
                
                yFrame = (tissueHideLbl.frame.minY + 100) - self.scrolView.contentOffset.y
                
                
                
            case 1920, 2208:
                
                strDeviceType = "iPhone 6+/6S+/7+/8+"
                
                yFrame = (tissueHideLbl.frame.minY + 113) - self.scrolView.contentOffset.y
                
            case 2436:
                
                strDeviceType = "iPhone X"
                
            case 2688:
                
                strDeviceType = "iPhone Xs Max"
                
            case 1792:
                
                yFrame = (tissueHideLbl.frame.minY + 143) - self.scrolView.contentOffset.y
                
                
                
                strDeviceType = "iPhone Xr"
                
            default:
                
                strDeviceType = "unknown"
                
            }
            
        }
        
        droperTableView.frame = CGRect(x: 30,y: yFrame,width: 150,height: 200)
        
        droperTableView.reloadData()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
        
    }
    
    
    
    @IBAction func addAnimalAction(_ sender: UIButton) {
        addContiuneBtn = 1
        addAnimalBtn(completionHandler: { (success) -> Void in
            print(success)
        })
        
        self.view.endEditing(true)
        
       //
       // validation()
        
    }
  
    func addAnimalBtn(completionHandler: @escaping CompletionHandler){
     
        if statusOrder == true {
            msgAnimalSucess = true
     
     
            let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal)
            if animalFetch.count > 0{
                  dataPopulateInScreen(animalId: idAnimal)
                editIngText = true
     
                if msgAnimalSucess == false {
     
                } else {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal Record cannot be updated as the animal has been used for an order.", comment: ""))
     
                    statusOrder = false
                    self.scrolView.contentOffset.y = 0.0
     
                    return
                }
            }
        }
     
     
        let selctionAuProvider = UserDefaults.standard.value(forKey: "ClickAuProvider") as? Bool
     
        if selctionAuProvider == true {
            if !isGenotypeOnlyAdded {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
               
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
     
                    self.validation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                   if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                             print("--> success")
                            completionHandler(true)
                        })
                    }
     
                }
            }
            else{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
     
                    self.textFieldValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                         print("--> success")
                        completionHandler(true)
                    })
     
                }
     
            }
     
        } else {
     
            if !isGenotypeOnlyAdded {
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    requiredflag = 1
                }
                
                if  scanBarcodeTextfield.text == "" || requiredflag == 0{
                    self.validation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                     if !isGenotypeOnlyAdded {
                        addBtnCondtion(completionHandler: { (success) -> Void in
                            if success == true{
                                completionHandler(true)
                            }
                        })
                    }
                }
     
                
     
            }
            else{
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    requiredflag = 1
                }
                if  genotypeScanBarcodeTextField.text == "" || requiredflag == 0 {
     
                    self.textFieldValidation()
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please fill all fields.", comment: ""))
                    completionHandler(false)
                    return
                } else {
                    genotypeAddBtnCondtion(completionHandler: { (success) -> Void in
                        if success == true{
                            completionHandler(true)
                        }
                    })
     
                }
     
            }
        }
        if notificationLblCount.text != "0"{
            countLbl.isHidden = false
            notificationLblCount.isHidden = false
        }
    }
    @IBAction func backBtnClk(_ sender: UIButton) {
        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "DashboardVC")), animated: true)
    }
    @IBAction func viewAnimalClick(_ sender: UIButton) {
        barcodeScreen = false
        selectedDate = Date()
       // InheritSelectedDate = Date()
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "BeefViewAnimalVC") as? BeefViewAnimalVC
       // vc?.delegateCustom = self
        vc!.screenBackSave = false
        vc!.productBackSave = false
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func initialNetworkCheck(){
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.checkForReachability), name: NSNotification.Name.reachabilityChanged, object: nil)
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected" ||  NetworkStatusLbl?.text == "Conectado" {
            
            networkStatusImg.image = UIImage(named: "status_online_sign")
            offLineBtn.isEnabled = false
        }
        else {
            offLineBtn.isEnabled = true
            networkStatusImg.image = UIImage(named: "status_offline")
            
        }
    }
    @objc func checkForReachability(notification:Notification){
        
        let del = UIApplication.shared.delegate as? AppDelegate
        self.NetworkStatusLbl?.text = NSLocalizedString((del?.status)!, comment: "")
        
        if NetworkStatusLbl?.text == "Connected" || NetworkStatusLbl?.text == "Conectado" {
            networkStatusImg.image = UIImage(named: "status_online_sign")
            offLineBtn.isEnabled = false
            
        }
        else {
            networkStatusImg.image = UIImage(named: "status_offline")
            offLineBtn.isEnabled = true
            
        }
    }
    let buttonbg = UIButton ()
    var customPopView :OfflinePopUp!
    @IBAction func offlineBtnAction(_ sender: UIButton) {
        
        let screenSize = UIScreen.main.bounds
        buttonbg.frame = CGRect(x: 0,y: 0,width: screenSize.width,height: screenSize.height)
        buttonbg.addTarget(self, action: #selector(OrderingAnimalVC.buttonbgPressed), for: .touchUpInside)
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
    func addBtnCondtion(completionHandler: CompletionHandler){
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()
        
        dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        if dateStr == "DD"{
            dateVale = dateBttnOutlet.titleLabel?.text ?? ""
        }
        else {
             if dateVale != ""{
            let values = dateVale.components(separatedBy: "/")
            let date = values[0]
            let month = values[1]
            let year = values[2]
            dateVale = month + "/" + date + "/" + year
            }
        }
        
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        //        if scanEarTagTextField.tag == 0 {
        //            scanEarTagTextField = scanAnimalTagText.text!
        //           // farmIdText = farmIdTextField.text!
        //        }
        //        else {
        //
        ////            scanAnimalText = farmIdTextField.text!
        ////            farmIdText = scanAnimalTagText.text!
        //        }
        print(fetchAllData(entityName: "BeefAnimalMaster"))
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:scanBarcodeTextfield.text!, orderId: orderId, userId: userId, animalId: animalId1)
        
    
        if animalData.count > 0  {
            
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1)
            
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl",animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1)
            
            
            
            updateOrderStatusISyncProduct(entity: "ProductAdonAnimlTbLBeef",animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: "SubProductTblBeef",animalTag: scanBarcodeTextfield.text!,barCodetag:  animalTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanBarcodeTextfield.text!,barcodeTag:animalTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
                
                
            }
            
            editAid = animalId1
            animalId1 = 0
            
            //  1
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            return
        }
        else if isUpdate == true {
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1)
            
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString,animalId: animalId1)
            
            
            
            
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:scanBarcodeTextfield.text!,barcodeTag:animalTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                byDefaultSetting()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                    byDefaultSetting()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    byDefaultSetting()
                    
                }
                
                
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            return
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: "GetProductTblBeef")
             let pid = product[0] as! GetProductTblBeef
            
            //            if breedId == 0{
            //                UserDefaults.standard.set(5, forKey: "breed")
            //                breedId = (UserDefaults.standard.value(forKey: "breed") as? Int)!
            //            }
            //            let breedName =   breedBtnOutlet.titleLabel?.text
            //            if breedName == "HO"{
            //                UserDefaults.standard.set(5, forKey: "breed")
            //                breedId = (UserDefaults.standard.value(forKey: "breed") as? Int)!
            //            }
            //
            //
            //            let pvid = UserDefaults.standard.integer(forKey: "Pvid")
            //            let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: breedId )
            //            if product.count == 0{
            //
            //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("The product does not allow for this breed. Please change the breed or product to continue. ", comment: ""))
            //                self.scrolView.contentOffset.y = 0.0
            //
            //            }
            //
            //            else {
            
            var animalID = UserDefaults.standard.integer(forKey: "animalId")
            var animalID1 = UserDefaults.standard.integer(forKey: "animalId")
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                
                
                
                
                
                updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1)
                
            }
            else{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                }
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU:"", userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1)
                }
                else {
                    
                    saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId))
                }
            }
            
            
            print(fetchAllData(entityName: "BeefAnimalMaster"))
            
            //                   let animalDataMaster1 = fetchAnimaldataValidateAnimalMaster(entityName: "AnimaladdTbl", animalTag:scanAnimalText, farmId: farmIdText, animalbarCodeTag: scanBarcodeText.text!, offPermanentId: permanentIDTextField.text!, offDamId: damtexfield.text!, offsireId:sireIdTextField.text ?? "",orderId:orderId,userId:userId)
            //                if animalDataMaster1.count > 0{
            //                    let userId = UserDefaults.standard.integer(forKey: "userId")
            //                    let orderId = UserDefaults.standard.integer(forKey: "orderId")
            //                    let animalData = fetchAnimaldataValidateAnimalMaster(entityName: "AnimalMaster", animalTag:scanAnimalText, farmId: farmIdText, animalbarCodeTag: scanBarcodeText.text!, offPermanentId: permanentIDTextField.text!, offDamId: damtexfield.text!, offsireId: sireIdTextField.text!,orderId:orderId,userId:userId)
            //                    if animalData.count > 0 {
            //
            //                        var data =  animalData.object(at: 0) as! AnimalMaster
            //                      animalId1 = Int(data.animalId)
            //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the Order.", comment: ""))
            //                    }
            //                }
            //  else {
            saveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: scanBarcodeTextfield.text!, barCodetag: animalTextfield.text!, date: dateVale , damId: rGDTextfield.text!, sireId: serieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:rGNTextfield.text!, tissuName: tissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: "", nationHerdAU: "", userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId))
            
            
            
            let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:scanBarcodeTextfield.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: "productCount")
            
            //                if UserDefaults.standard.bool(forKey: "identifyStore") == false  {
            //
            //                    if productCount > 0{
            //
            //                        if product.count == UserDefaults.standard.integer(forKey: "productCount"){
            //                            UserDefaults.standard.set(false, forKey: "identifyStore")
            //                        }
            //                        else {
            //                            UserDefaults.standard.set(true, forKey: "identifyStore")
            //                        }
            //                    }
            //                }
            
            //UserDefaults.standard.set( product.count, forKey: "productCount")
          //  let product  = fetchAllData(entityName: "GetProductTblBeef")
            
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    
             beefSaveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: Int(data.marketId), productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "")
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    if addonArr.count > 0 {
                    
                    for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1)
                        
                        msgShow()
                       
                    }
                }
                    else {
                         msgShow()
                    }
                    
                }
            }
            
            self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            byDefaultSetting()
            
            OtherbyTextfieldGray()
            genderToggleFlag = 0
            genderString = "Female"
            
         
            scanBarcodeTextfield.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderId")
            
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false")
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            //                let result = formatter.string(from: date)
            //                dateBtnOutlet.titleLabel?.text = result
            
            
            
            completionHandler(true)
            // }
        }
    }
    func msgShow()  {
        let message = NSLocalizedString("Animal added successfully.", comment: "")
        statusOrder = false
        UserDefaults.standard.removeObject(forKey: "review")
        self.animalSucInOrder = ""
        //  DispatchQueue.main.async {
        if self.msgAnimalSucess == false {
            if self.addContiuneBtn == 1 {
                if self.msgcheckk == true {
                    self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
                }
                else {
                    
                    if self.isautoPopulated == true {
                        self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                    } else {
                        self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                    }
                }
            } else if self.addContiuneBtn == 2{
                //  self.isautoPopulated = false
                if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                }
                else{
                    if self.isautoPopulated == true {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                        
                    } else {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                    }
                }
            }else {
                if self.msgcheckk == true {
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated and added in order successfully.", comment: ""))
                }
                else{
                    if self.isautoPopulated == true {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully in order.", comment: ""))
                        
                    } else {
                        
                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal added successfully.", comment: ""))
                    }
                }
                
                
                
            }
            self.msgAnimalSucess = false
        } else {
            if self.msgcheckk == true {
                self.view.makeToast(NSLocalizedString("Animal record updated and added in order successfully.", comment: ""), duration: 1, position: .bottom)
            }
            else{
                if self.isautoPopulated == true {
                    self.view.makeToast(NSLocalizedString("Animal added successfully in order.", comment: ""), duration: 1, position: .bottom)
                }else {
                    self.view.makeToast(NSLocalizedString("Animal added successfully.", comment: ""), duration: 1, position: .bottom)
                    
                }
            }
        }
    }
    func genotypeAddBtnCondtion(completionHandler: CompletionHandler){
        
        var dateVale = ""
        let dateStr = UserDefaults.standard.value(forKey: "date") as? String
        let formatter = DateFormatter()
        
        dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
        if dateStr == "DD"{
            dateVale = genotypeDOBBttn.titleLabel?.text ?? ""
        }
        else {
             if dateVale != ""{
            let values = dateVale.components(separatedBy: "/")
            let date = values[0]
            let month = values[1]
            let year = values[2]
            dateVale = month + "/" + date + "/" + year
            }
        }
        
        
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        
        //        if scanEarTagTextField.tag == 0 {
        //            scanEarTagTextField = scanAnimalTagText.text!
        //           // farmIdText = farmIdTextField.text!
        //        }
        //        else {
        //
        ////            scanAnimalText = farmIdTextField.text!
        ////            farmIdText = scanAnimalTagText.text!
        //        }
        print(fetchAllData(entityName: "BeefAnimalMaster"))
        
        let animalData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:genotypeScanBarcodeTextField.text!, orderId: orderId, userId: userId, animalId: animalId1)
        
        
        if animalData.count > 0  {
            
            isUpdate = true
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1)
            
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl",animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: (priorityBreeingBtnOutlet.titleLabel!.text!), nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1)
            
            
            
            updateOrderStatusISyncProduct(entity: "ProductAdonAnimlTbLBeef",animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId:animalId1)
            updateOrderStatusISyncSubProduct(entity: "SubProductTblBeef",animalTag: genotypeScanBarcodeTextField.text!,barCodetag:  genotypeAnimalNameTextfield.text!,farmId: "",orderId: orderId,userId:userId,animalId: animalId1)
            
            
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                GenotypebyDefaultScreen()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                
                
            }
            
            editAid = animalId1
            animalId1 = 0
            
            //  1
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            
            
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            return
        }
        else if isUpdate == true {
            
            animalId1 = editAid
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1)
            
            updateOrderStatusISyncAnimalMaster(entity: "BeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString,animalId: animalId1)
            
            
            
            
            
            if identify1 == true {
                let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
                if data1.count > 0 {
                    completionHandler(true)
                    return
                }
            }
            isautoPopulated = false
            let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: "",animalTag:genotypeScanBarcodeTextField.text!,barcodeTag:genotypeAnimalNameTextfield.text!)
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            
            if adata.count > 0{
                
                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                GenotypebyDefaultScreen()
                
                
            }
                
            else if animalDataMaster.count > 0 {
                if  msgUpatedd == true{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal record updated successfully.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                else{
                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the order.", comment: ""))
                    GenotypebyDefaultScreen()
                    
                }
                
                
            }
            completionHandler(true)
            scrolView.contentOffset.y = 0.0
            return
        }
        else {
            isUpdate = false
            let product  = fetchAllData(entityName: "GetProductTblBeef")
            let pid = product[0] as! GetProductTblBeef
            
            //            if breedId == 0{
            //                UserDefaults.standard.set(5, forKey: "breed")
            //                breedId = (UserDefaults.standard.value(forKey: "breed") as? Int)!
            //            }
            //            let breedName =   breedBtnOutlet.titleLabel?.text
            //            if breedName == "HO"{
            //                UserDefaults.standard.set(5, forKey: "breed")
            //                breedId = (UserDefaults.standard.value(forKey: "breed") as? Int)!
            //            }
            //
            //
            //            let pvid = UserDefaults.standard.integer(forKey: "Pvid")
            //            let product = fetchproviderProductDataBreedId(entityName: "GetProductTbl", provId: pvid, breedId: breedId )
            //            if product.count == 0{
            //
            //                CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("The product does not allow for this breed. Please change the breed or product to continue. ", comment: ""))
            //                self.scrolView.contentOffset.y = 0.0
            //
            //            }
            //
            //            else {
            
            var animalID = UserDefaults.standard.integer(forKey: "animalId")
            var animalID1 = UserDefaults.standard.integer(forKey: "animalId")
            
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0{
                
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                
                
                
                
                
                updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1)
                
            }
            else{
                
                if animalID1 == 0 {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                    
                }
                else {
                    animalID1 = animalID1 + 1
                    UserDefaults.standard.set(animalID1, forKey: "animalId")
                }
                
                let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"true" )
                
                
                if animalDataMaster.count > 0{
                    updateOrderStatusISyncAnimalMasterAnimalId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU:secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalId1,animalidNew:animalID1)
                }
                else {
                    
                    saveAnimaldataBeefInProductId(entity: "BeefAnimalMaster", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "false", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId))
                }
            }
            
            
            print(fetchAllData(entityName: "BeefAnimalMaster"))
            
            //                   let animalDataMaster1 = fetchAnimaldataValidateAnimalMaster(entityName: "AnimaladdTbl", animalTag:scanAnimalText, farmId: farmIdText, animalbarCodeTag: scanBarcodeText.text!, offPermanentId: permanentIDTextField.text!, offDamId: damtexfield.text!, offsireId:sireIdTextField.text ?? "",orderId:orderId,userId:userId)
            //                if animalDataMaster1.count > 0{
            //                    let userId = UserDefaults.standard.integer(forKey: "userId")
            //                    let orderId = UserDefaults.standard.integer(forKey: "orderId")
            //                    let animalData = fetchAnimaldataValidateAnimalMaster(entityName: "AnimalMaster", animalTag:scanAnimalText, farmId: farmIdText, animalbarCodeTag: scanBarcodeText.text!, offPermanentId: permanentIDTextField.text!, offDamId: damtexfield.text!, offsireId: sireIdTextField.text!,orderId:orderId,userId:userId)
            //                    if animalData.count > 0 {
            //
            //                        var data =  animalData.object(at: 0) as! AnimalMaster
            //                      animalId1 = Int(data.animalId)
            //                    CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Animal already added in the Order.", comment: ""))
            //                    }
            //                }
            //  else {
            saveAnimaldataBeefInProductId(entity: "BeefAnimaladdTbl", animalTag: genotypeScanBarcodeTextField.text!, barCodetag: genotypeAnimalNameTextfield.text!, date: dateVale , damId: genotypeRgdTextfield.text!, sireId: genotypeSerieTextfield.text ?? "" , gender: genderString,update: "true", permanentId:genotypeRgnTextfield.text!, tissuName: genotypeTissueBttn.titleLabel!.text!, breedName: "", et: "", farmId:"", orderId: autoD,orderSataus:"false",breedId:breedId,isSync:"false", providerId: pvid,tissuId: tissuId,sireIDAU: priorityBreeingBtnOutlet.titleLabel!.text!, nationHerdAU: secondaryBreddingOutlet.titleLabel!.text!, userId: userId,udid:timeStampString, animalId: animalID1, productId: Int(pid.productId))
            
            
            
            let animalData = fetchAnimaldata(entityName: "BeefAnimaladdTbl", animalTag:genotypeScanBarcodeTextField.text!,orderId:orderId,userId:userId)
            let productCount = UserDefaults.standard.integer(forKey: "productCount")
            
            //                if UserDefaults.standard.bool(forKey: "identifyStore") == false  {
            //
            //                    if productCount > 0{
            //
            //                        if product.count == UserDefaults.standard.integer(forKey: "productCount"){
            //                            UserDefaults.standard.set(false, forKey: "identifyStore")
            //                        }
            //                        else {
            //                            UserDefaults.standard.set(true, forKey: "identifyStore")
            //                        }
            //                    }
            //                }
            
            //UserDefaults.standard.set( product.count, forKey: "productCount")
            //let product  = fetchAllData(entityName: "GetProductTblBeef")
            
            
            for k in 0 ..< animalData.count{
                
                let animalId = animalData[k] as! BeefAnimaladdTbl
                
                for i in 0 ..< product.count {
                    
                    let data = product[i] as! GetProductTblBeef
                    beefSaveProductAdonTbl(entity: "ProductAdonAnimlTbLBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.offsireId ?? "",mkdId: Int(data.marketId), productId:Int(data.productId) , productName: data.productName ?? "", providerId: pvid, status: "true", farmId: animalId.farmId ?? "" , orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, animalId: animalID1, rgd: animalId.offDamId ?? "", rgn: animalId.offPermanentId ?? "")
                    
                   
                    
                    let  addonArr = fetchProductAdonData(entityName: "GetAdonTbl", prodId: Int(data.productId))
                    if addonArr.count > 0 {
                    for j in 0 ..< addonArr.count {
                        
                        let addonDat = addonArr[j] as! GetAdonTbl
                        
                        saveSubroductTbl(entity: "SubProductTblBeef", animalTag: animalId.animalTag ?? "", barCodetag: animalId.animalbarCodeTag ?? "", productId: Int(data.productId), adonName: addonDat.adonName ?? "", adonId: Int(addonDat.adonId), status: "false", orderId: autoD, orderStatus: "false", isSync: "false", userId: userId,udid:timeStampString, farmId: animalId.farmId ?? "", animalId: animalID1)
                        
                       msgShow()
                    }
                }
                    else {
                          msgShow()
                    }
                    
                }
            }
            self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
            GenotypebyDefaultScreen()
            GenotypebyDefaultbackroundGray()
            genderToggleFlag = 0
            genderString = "Female"
            
            
            genotypeScanBarcodeTextField.text = ""
            
            let userId = UserDefaults.standard.integer(forKey: "userId")
            let orderId = UserDefaults.standard.integer(forKey: "orderId")
            
            let animalCount =  fetchAllDataAnimalDatarderId(entityName: "BeefAnimaladdTbl", userId: userId,orderId:orderId,orderStatus:"false")
            notificationLblCount.text = String(animalCount.count)
            
            let dateStr = UserDefaults.standard.value(forKey: "date") as? String
            let formatter = DateFormatter()
            
            if dateStr == "MM"{
                formatter.dateFormat = "MM/dd/yyyy"
            }
            else {
                formatter.dateFormat = "dd/MM/yyyy"
            }
            //                let result = formatter.string(from: date)
            //                dateBtnOutlet.titleLabel?.text = result
            
            
            
            completionHandler(true)
            // }
        }
    }
    @IBAction func dateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        doDatePicker()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    @IBAction func genotypeDateAction(_ sender: UIButton) {
        self.view.endEditing(true)
        calenderView.isHidden = false
        calenderbkg.isHidden = false
        calenderView.layer.cornerRadius = 30
        calenderView.layer.masksToBounds = true
        genotypeDoDatePicker()
        statusOrderTrue()
        if statusOrder == true{
            msgAnimalSucess = true
        }
        else{
            messageCheck = true
        }
        
        let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
        if animalDataMaster.count > 0 {
            msgUpatedd = true
        }
    }
    
    func genotypeDoDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        if selectedDate != nil{
            self.datePicker.setDate(selectedDate, animated: true)
        }
        calenderView.addSubview(self.datePicker)
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        self.datePicker.maximumDate = Date()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.genotypeDoneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    func doDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 40, width: self.calenderView.frame.size.width, height: 260))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        if selectedDate != nil{
            self.datePicker.setDate(selectedDate, animated: true)
        }
        calenderView.addSubview(self.datePicker)
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        self.datePicker.maximumDate = Date()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelClick))
        cancelButton.tintColor = UIColor.black
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        toolBar.frame = CGRect(x: 0, y: 0, width: self.calenderView.frame.size.width, height: 40)
        self.calenderView.addSubview(toolBar)
        self.toolBar.isHidden = false
        
    }
    @objc func doneClick() {
        let date = UserDefaults.standard.value(forKey: "date") as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = "MM/dd/yyyy"
        }
        else {
            dateFormatter3.dateFormat = "dd/MM/yyyy"
        }
        self.selectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        dateBttnOutlet.setTitle(selectedDate, for: .normal)
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func genotypeDoneClick() {
        let date = UserDefaults.standard.value(forKey: "date") as? String
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        let dateFormatter3 = DateFormatter()
        if date == "MM"{
            dateFormatter3.dateFormat = "MM/dd/yyyy"
        }
        else {
            dateFormatter3.dateFormat = "dd/MM/yyyy"
        }
        self.selectedDate = datePicker.date
        
        let selectedDate = dateFormatter3.string(from: datePicker.date)
        genotypeDOBBttn.setTitle(selectedDate, for: .normal)
        
        self.datePicker.resignFirstResponder()
        datePicker.isHidden = true
        self.toolBar.isHidden = true
        calenderView.isHidden = true
        calenderbkg.isHidden = true
    }
    
    @objc func cancelClick() {
        calenderView.isHidden = true
        calenderbkg.isHidden = true
        datePicker.isHidden = true
        self.toolBar.isHidden = true
    }
    @IBAction func continueProductAction(_ sender: UIButton) {
        
            
            addContiuneBtn = 2
            
            let  userId = UserDefaults.standard.integer(forKey: "userId")
            let  orderId = UserDefaults.standard.integer(forKey: "orderId")
            identify1 = true
            let data1 = fetchAllDataOrderStatus(entityName: "BeefAnimaladdTbl",ordestatus: "false", orderId:orderId,userId:userId)
            
            let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
            
            if  identyCheck == false || identyCheck == nil{
                if data1.count > 0 {
                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        requiredflag = 0
                    }
                    else{
                        requiredflag = 1
                    }
                    
                    if  scanBarcodeTextfield.text == "" || requiredflag == 0{

                        if UserDefaults.standard.value(forKey: "page")  == nil {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                            
                        } else {
                           // if identyCheck == false || identyCheck == nil {
                                if  UserDefaults.standard.value(forKey: "page") == nil {
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                }
                                else{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            //}
//                            else {
//
//                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
//
//                            }
                        }
                    } else {
                        
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            
                            
                            if success == true{
                                
                                let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                                if  identyCheck == true {
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    
                                }  else {
                                    if UserDefaults.standard.value(forKey: "page")  == nil{
                                        
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                        
                                    } else {
                                        self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                        
                                    }
                                }
                            }
                        })
                    }
                }
                else {
                    
                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        requiredflag = 0
                    }
                    else{
                        requiredflag = 1
                    }
                    
                    if  scanBarcodeTextfield.text == "" || requiredflag == 0{

                        CommonClass.showAlertMessage(self, titleStr: NSLocalizedString("Alert", comment: ""), messageStr: NSLocalizedString("Please add at least one animal.", comment: ""))
                        self.validation()
                        
                    }
                    else {
                        
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true{
                                if UserDefaults.standard.value(forKey: "page")  == nil{
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderingProductSelectionVC")), animated: true)
                                    
                                } else {
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController:
                                        self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            }
                        })
                        
                        
                    }
                }
            }
            else{
                
                if data1.count > 0 {
                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                        requiredflag = 0
                    }
                    else{
                        requiredflag = 1
                    }
                    
                    if  scanBarcodeTextfield.text == "" || requiredflag == 0{

                        let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                        if  identyCheck == true {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            
                        }  else {
                            
                            self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                        }
                    }
                    else{
                        addAnimalBtn(completionHandler: { (success) -> Void in
                            if success == true{
                                let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                                if  identyCheck == true {
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                    
                                }  else {
                                    
                                    self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                }
                            }
                        })
                    }
                }
                else{
                    addAnimalBtn(completionHandler: { (success) -> Void in
                        if success == true{
                            let identyCheck = UserDefaults.standard.value(forKey: "identifyStore") as? Bool
                            if  identyCheck == true {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                            }
                            else {
                                
                                self.sideMenuViewController!.setContentViewController(UINavigationController(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "BeefOrderProductSelectionSecondVC")), animated: true)
                                
                            }
                        }
                    })
                }
            }
        
    }
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
        let viewController = BarcodeScannerViewController()
        viewController.codeDelegate = self
        viewController.errorDelegate = self
        viewController.dismissalDelegate = self
        return viewController
    }
    @IBAction func BarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
    }
    @IBAction func genotypeBarcodeAction(_ sender: UIButton) {
        barcodeScreen = true
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
    }
    func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
        if isGenotypeOnlyAdded == true {
           genotypeScanBarcodeTextField.text = code
        }else{
              scanBarcodeTextfield.text = code
        }
        
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
        
    }
    
    func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}


extension BeefAnimalBrazilVC:offlineCustomView{
    func crossBtnCall() {
        buttonbg.removeFromSuperview()
        customPopView.removeFromSuperview()
    }}
extension BeefAnimalBrazilVC:UITableViewDelegate,UITableViewDataSource {
    
    //  MARK: - Genotype
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        //  MARK: - Genotype
        
        if btnTag == 10 {
            
            return self.tissueArr.count
            
        } else if btnTag == 20 {
            
            return self.priorityBreeding.count
            
        }else  if btnTag == 40 {
            
            return self.tissueArr.count
            
        }
            
        else {
            
            return self.secondaryBreeding.count
            
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        
        
        
        //  MARK: - Genotype
        
        if btnTag == 10 {
            
            
            
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            
            cell.textLabel?.text = tissue.sampleName
            
            return cell
            
            
            
        } else if btnTag == 20 {
            
            
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            
            cell.textLabel?.text = tissue.priorityBreedName
            
            return cell
            
            
            
        }else if btnTag == 40 {
            
            
            
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            
            cell.textLabel?.text = tissue.sampleName
            
            return cell
            
        }
            
        else {
            
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetPriorityBreeding
            
            cell.textLabel?.text = tissue.priorityBreedName
            
            return cell
            
            
            
            
            
        }
        
        return cell
        
    }
    
    
    
    // method to run when table view cell is tapped
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        
        if btnTag == 10 {
            
            
            
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            
            genotypeTissueBttn.setTitleColor(.black, for: .normal)
            
            genotypeTissueBttn.setTitle(tissue.sampleName, for: .normal)
             UserDefaults.standard.set(tissue.sampleName, forKey: "genotypeTissueBttn")
             buttonbg2.removeFromSuperview()
            
            
            
        }else  if btnTag == 20 {
            
            let tissue = self.priorityBreeding[indexPath.row]  as! GetPriorityBreeding
            
            priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
            
            priorityBreeingBtnOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            UserDefaults.standard.set(tissue.priorityBreedName, forKey: "priorityBreedName")
            if tissue.priorityBreedId == 1 {
                requiredflag = 1
                
                    if requiredflag == 1{
                        genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                        genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                        genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                    }
                    else{
                        genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                        genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                        genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                    }
                    
                
              
            }
            else{
                requiredflag = 0
            }
            
               buttonbg2.removeFromSuperview()
            
        }          else if btnTag == 40 {
            
            
            
            let tissue = self.tissueArr[indexPath.row]  as! GetSampleTbl
            
            tissueBttn.setTitleColor(.black, for: .normal)
            
            tissueBttn.setTitle(tissue.sampleName, for: .normal)
            
            UserDefaults.standard.set(tissue.sampleName, forKey: "tissueBttn")

               buttonbg2.removeFromSuperview()
            
            
            
            
            
            
        }
            
        else {
            
            let tissue = self.secondaryBreeding[indexPath.row]  as! GetPriorityBreeding
            
            secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
            
            secondaryBreddingOutlet.setTitle(tissue.priorityBreedName, for: .normal)
            
            UserDefaults.standard.set(tissue.priorityBreedName, forKey: "secondaryBreddingOutlet")

               buttonbg2.removeFromSuperview()
        }
        
        
        
    }
    
    
    
}



extension BeefAnimalBrazilVC: UITextFieldDelegate{
    
    
    
   
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if isGenotypeOnlyAdded == false {
            
            if (textField == animalTextfield ) {
                
                animalTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                serieTextfield.returnKeyType = UIReturnKeyType.next
                scanBarcodeTextfield.returnKeyType = UIReturnKeyType.next
                rGNTextfield.returnKeyType = UIReturnKeyType.next
                rGDTextfield.returnKeyType = UIReturnKeyType.next
            }
        } else {
            
            if (textField == genotypeAnimalNameTextfield ) {
                
                genotypeAnimalNameTextfield.returnKeyType = UIReturnKeyType.done
            } else {
                genotypeScanBarcodeTextField.returnKeyType = UIReturnKeyType.next
                genotypeSerieTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgnTextfield.returnKeyType = UIReturnKeyType.next
                genotypeRgdTextfield.returnKeyType = UIReturnKeyType.next
                
            }
        }
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        return true
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //  MARK: - Genotype
        let userId = UserDefaults.standard.integer(forKey: "userId")
        let orderId = UserDefaults.standard.integer(forKey: "orderId")
        let pvid = UserDefaults.standard.integer(forKey: "BeefPvid")
        var samplename = String()
        let ob =  fetchAllData(entityName: "BeefAnimalMaster")

        let animalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:scanBarcodeTextfield.text!, farmId: "", animalbarCodeTag: "", offPermanentId: "", offDamId: rGDTextfield.text!, offsireId: serieTextfield.text!,orderId:orderId,userId:userId)
         let genotypeAnimalData = fetchAnimaldataValidateAnimalwithouOrderID(entityName: "BeefAnimalMaster", animalTag:genotypeScanBarcodeTextField.text!, farmId: "", animalbarCodeTag: genotypeAnimalNameTextfield.text!, offPermanentId: rGNTextfield.text!, offDamId: genotypeRgdTextfield.text!, offsireId: genotypeSerieTextfield.text!,orderId:orderId,userId:userId)
        if isautoPopulated == false{
//            if animalData.count > 0 {
//                isautoPopulated = true
//
//                updateOrder = true
//                var data =  animalData.lastObject as! BeefAnimalMaster
//                let userId = UserDefaults.standard.integer(forKey: "userId")
//                ////////start
//                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
//                animalId1 = Int(data.animalId)
//
//                /////////end
//
//
//
//                barcodeView.layer.borderColor = UIColor.gray.cgColor
//                //                barcodeView.layer.borderColor = UIColor.gray.cgColor
//                //                permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
//                //                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
//                //                damtexfield.layer.borderColor = UIColor.gray.cgColor
//                //
//                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
//                var formatter = DateFormatter()
//
//                if dateStr == "MM"{
//                    var dateVale = ""
//                    let values = data.date!.components(separatedBy: "/")
//                      if values.count > 1{
//                    let date = values[0]
//                    let month = values[1]
//                    let year = values[2]
//                    dateVale = month + "/" + date + "/" + year
//                    }
//                    dateBttnOutlet.setTitle(dateVale, for: .normal)
//                    formatter.dateFormat = "MM/dd/yyyy"
//                }
//                else {
//                    var dateVale = ""
//                    let values = data.date!.components(separatedBy: "/")
//                      if values.count > 1{
//                    let date = values[0]
//                    let month = values[1]
//                    let year = values[2]
//                    dateVale = date + "/" + month + "/" + year
//                    }
//                    dateBttnOutlet.setTitle(dateVale, for: .normal)
//                    formatter.dateFormat = "dd/MM/yyyy"
//                }
//                if dateBttnOutlet.titleLabel!.text != nil{
//                self.selectedDate = formatter.date(from: dateBttnOutlet.titleLabel!.text!)!
//                }
//                else{
//                    self.selectedDate = Date()
//                }
//                let dates =  formatter.string(from: selectedDate)
//
//
//                scanBarcodeTextfield.text = data.animalTag
//                rGNTextfield.text = data.offPermanentId
//                serieTextfield.text = data.offsireId
//                rGDTextfield.text = data.offDamId
//
//                //                animalNameTextfield.text  = data.anima
//
//                tissueBttn.setTitleColor(.black, for: .normal)
//                animalTextfield.text = data.animalbarCodeTag
//                tissueBttn.setTitle(data.tissuName, for: .normal)
//                UserDefaults.standard.set(data.tissuName, forKey: "tissueBttn")
//
//                breedId = Int(data.breedId)
//                samplename = data.tissuName!
//                let pvidAA = data.providerId
//                UserDefaults.standard.set(breedId, forKey: "Beefbreed")
//
//                if data.gender == "Male" {
//
//                    self.maleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
//                    genderToggleFlag = 1
//                    genderString = "Male"
//
//                } else {
//
//                    self.maleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
//                    genderToggleFlag = 0
//                    genderString = "Female"
//
//                }
//
//
//
//
//                tissuId = Int(data.tissuId)
//                textField.resignFirstResponder()
//
//                //                if (textField == self.sireIAuTextField) {
//                //                    self.nationalHerdIdTextField.becomeFirstResponder()
//                //                    if sireIAuTextField.text == ""{
//                //                        sireIAuTextField.layer.borderColor = UIColor.red.cgColor
//                //                    }else{
//                //                        sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
//                //                    }
//                //
//                //                } else if (textField == self.nationalHerdIdTextField) {
//                //                    self.nationalHerdIdTextField.resignFirstResponder()
//                //                    if nationalHerdIdTextField.text == ""{
//                //                        nationalHerdIdTextField.layer.borderColor = UIColor.red.cgColor
//                //                    }else{
//                //                        nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
//                //                        addAnimalBtn(completionHandler: { (success) -> Void in
//                //                        })
//                //                    }
//                //                }
//                dateBttnOutlet.setTitleColor(.black, for: .normal)
//                statusOrder = false
//                messageCheck = false
//                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
//                if adata.count > 0{
//                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
//                    idAnimal = Int(animal.animalId)
//                    //statusOrder = true
//                    messageCheck = true
//                }
//
//                    if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
//                        requiredflag = 0
//                    }
//                    else{
//                        if isautoPopulated == true{
//                            requiredflag = 1
//                        }
//                        else{
//                            requiredflag = 0
//                        }
//                    }
//                    if requiredflag == 1{
//                        serieTextfield.layer.borderColor = UIColor.gray.cgColor
//                        rGNTextfield.layer.borderColor = UIColor.gray.cgColor
//                        rGDTextfield.layer.borderColor = UIColor.gray.cgColor
//                    }
//                    else{
//                        serieTextfield.layer.borderColor = UIColor.red.cgColor
//                        rGNTextfield.layer.borderColor = UIColor.red.cgColor
//                        rGDTextfield.layer.borderColor = UIColor.red.cgColor
//                    }
//
//            }
//            if genotypeAnimalData.count > 0 {
//                isautoPopulated = true
//
//                updateOrder = true
//                var data =  genotypeAnimalData.lastObject as! BeefAnimalMaster
//                let userId = UserDefaults.standard.integer(forKey: "userId")
//                ////////start
//                let animalTbl =  fetchAllData(entityName: "BeefAnimaladdTbl")
//                animalId1 = Int(data.animalId)
//
//                /////////end
//
//
//                genotypeScanBarcodeTextField.layer.borderColor = UIColor.gray.cgColor
//                genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//                genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
//                genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
//                //                barcodeView.layer.borderColor = UIColor.gray.cgColor
//                //                permanentIDTextField.layer.borderColor = UIColor.gray.cgColor
//                //                sireIdTextField.layer.borderColor = UIColor.gray.cgColor
//                //                damtexfield.layer.borderColor = UIColor.gray.cgColor
//                //
//                let dateStr = UserDefaults.standard.value(forKey: "date") as? String
//                var formatter = DateFormatter()
//
//                if dateStr == "MM"{
//                    var dateVale = ""
//                    let values = data.date!.components(separatedBy: "/")
//                    if values.count > 1 {
//                    let date = values[0]
//                    let month = values[1]
//                    let year = values[2]
//                    dateVale = month + "/" + date + "/" + year
//                    }
//                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
//                    formatter.dateFormat = "MM/dd/yyyy"
//                }
//                else {
//                    var dateVale = ""
//                    let values = data.date!.components(separatedBy: "/")
//                     if values.count > 1 {
//                    let date = values[0]
//                    let month = values[1]
//                    let year = values[2]
//                    dateVale = date + "/" + month + "/" + year
//                    }
//                    genotypeDOBBttn.setTitle(dateVale, for: .normal)
//                    formatter.dateFormat = "dd/MM/yyyy"
//                }
//                if  genotypeDOBBttn.titleLabel!.text != nil {
//                self.selectedDate = formatter.date(from: genotypeDOBBttn.titleLabel!.text!)!
//
//                }
//                else{
//                    self.selectedDate = Date()
//                }
//                 let dates =  formatter.string(from: selectedDate)
//
//                genotypeScanBarcodeTextField.text = data.animalTag
//                genotypeRgnTextfield.text = data.offPermanentId
//                genotypeSerieTextfield.text = data.offsireId
//                genotypeRgdTextfield.text = data.offDamId
//                genotypeAnimalNameTextfield.text = data.animalbarCodeTag
//                //                animalNameTextfield.text  = data.anima
//
//                priorityBreeingBtnOutlet.setTitle(data.sireIDAU ,for: .normal)
//                genotypeTissueBttn.setTitleColor(.black, for: .normal)
//                priorityBreeingBtnOutlet.setTitleColor(.black, for: .normal)
//                genotypeTissueBttn.setTitle(data.tissuName, for: .normal)
//                secondaryBreddingOutlet.setTitleColor(.black, for: .normal)
//                secondaryBreddingOutlet.setTitle(data.nationHerdAU, for: .normal)
//                UserDefaults.standard.set(data.tissuName, forKey: "BeefInheritTsu")
//
//                breedId = Int(data.breedId)
//                samplename = data.tissuName!
//                let pvidAA = data.providerId
//               // UserDefaults.standard.set(breedId, forKey: "InheritBeefbreed")
//             UserDefaults.standard.set(data.sireIDAU, forKey: "priorityBreedName")
//                if data.gender == "Male" {
//
//                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "male_active"), for: .normal)
//                    genderToggleFlag = 1
//                    genderString = "Male"
//
//
//                } else {
//
//                    self.genotypeMaleFemaleBttn.setImage(UIImage(named: "female_active"), for: .normal)
//                    genderToggleFlag = 0
//                    genderString = "Female"
//
//                }
//
//
//
//
//                tissuId = Int(data.tissuId)
//                textField.resignFirstResponder()
//
//                //                if (textField == self.sireIAuTextField) {
//                //                    self.nationalHerdIdTextField.becomeFirstResponder()
//                //                    if sireIAuTextField.text == ""{
//                //                        sireIAuTextField.layer.borderColor = UIColor.red.cgColor
//                //                    }else{
//                //                        sireIAuTextField.layer.borderColor = UIColor.gray.cgColor
//                //                    }
//                //
//                //                } else if (textField == self.nationalHerdIdTextField) {
//                //                    self.nationalHerdIdTextField.resignFirstResponder()
//                //                    if nationalHerdIdTextField.text == ""{
//                //                        nationalHerdIdTextField.layer.borderColor = UIColor.red.cgColor
//                //                    }else{
//                //                        nationalHerdIdTextField.layer.borderColor = UIColor.gray.cgColor
//                //                        addAnimalBtn(completionHandler: { (success) -> Void in
//                //                        })
//                //                    }
//                //                }
//                genotypeDOBBttn.setTitleColor(.black, for: .normal)
//                statusOrder = false
//                messageCheck = false
//                let adata = fetchAllDataOrderStatusMaster(entityName: "BeefAnimalMaster", ordestatus: "true", userId: userId,farmId: data.farmId!,animalTag:data.animalTag!,barcodeTag:data.animalbarCodeTag!)
//                if adata.count > 0{
//                    let animal  = adata.object(at: 0) as! BeefAnimalMaster
//                    idAnimal = Int(animal.animalId)
//                    //statusOrder = true
//                    messageCheck = true
//                }
//                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
//                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
//                        requiredflag = 1
//                    }else{
//                        requiredflag = 0
//                    }
//
//                }
//                else{
//                    if isautoPopulated == true{
//                        requiredflag = 1
//                    }
//                    else{
//                        requiredflag = 0
//                    }
//                }
//                if requiredflag == 1{
//                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
//                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
//                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
//                }
//                else{
//                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
//                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
//                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
//                }
//            }
        }
        else{
            
            if scanBarcodeTextfield.text!.count > 0 {
                othersByDefaultBackroundWhite()
            }
            else{
                OtherbyTextfieldGray()
            }
        }
        if genotypeScanBarcodeTextField.text!.count > 0 {
            
            GenotypebyDefaultbackroundWhite()
            
        } else {
            
            GenotypebyDefaultScreen()
            
        }
        
        
        
        if (textField == self.genotypeScanBarcodeTextField) {
            
            if genotypeScanBarcodeTextField.text == ""{
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                genotypeScanBarcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.genotypeSerieTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeSerieTextfield) {
             requiredflag = 1
            if genotypeSerieTextfield.text == ""{
                
              //  genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            }
            
            self.genotypeRgnTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeRgnTextfield) {
             requiredflag = 1
            if genotypeRgnTextfield.text == ""{
                
               // genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            }
            
            self.genotypeRgdTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeRgdTextfield) {
             requiredflag = 1
            if genotypeRgdTextfield.text == ""{
                
               // genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                if genotypeSerieTextfield.text == "" && genotypeRgnTextfield.text == "" && genotypeRgdTextfield.text == ""{
                    if priorityBreeingBtnOutlet.titleLabel?.text  == "Cia de Melhoramento"{
                        requiredflag = 1
                    }else{
                        requiredflag = 0
                    }
                    
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
            } else {
                
                if requiredflag == 1{
                    genotypeSerieTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.gray.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    genotypeSerieTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgnTextfield.layer.borderColor = UIColor.red.cgColor
                    genotypeRgdTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            }
            
            self.genotypeAnimalNameTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.genotypeAnimalNameTextfield) {
            
            if genotypeAnimalNameTextfield.text == ""{
                
                genotypeAnimalNameTextfield.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                genotypeAnimalNameTextfield.layer.borderColor = UIColor.gray.cgColor
                
                
            }
            
         
            self.genotypeAnimalNameTextfield.resignFirstResponder()
            
        }
        
        
        
        
        
        
        
        if scanBarcodeTextfield.text!.count > 0 {
            
            othersByDefaultBackroundWhite()
            
        } else {
            
            OtherbyTextfieldGray()
            
        }
        
        
        
        
        
        //  MARK: - Othertype
        
        
        
        
        
        if (textField == self.scanBarcodeTextfield) {
            
            if scanBarcodeTextfield.text == ""{
                
                barcodeView.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                barcodeView.layer.borderColor = UIColor.gray.cgColor
                
                self.genotypeSerieTextfield.becomeFirstResponder()
                
            }
            
            self.serieTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.serieTextfield) {
            requiredflag = 1
            if serieTextfield.text == ""{
             
                
//serieTextfield.layer.borderColor = UIColor.red.cgColor
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
            self.rGNTextfield.becomeFirstResponder()
            
        }
            
        else if (textField == self.rGNTextfield) {
              requiredflag = 1
            if rGNTextfield.text == ""{
                
               // rGNTextfield.layer.borderColor = UIColor.red.cgColor
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
            self.rGDTextfield.becomeFirstResponder()
            
        }
            
            
            
        else if (textField == self.rGDTextfield) {
              requiredflag = 1
            if rGDTextfield.text == ""{
              
               // rGDTextfield.layer.borderColor = UIColor.red.cgColor
                if serieTextfield.text == "" && rGNTextfield.text == "" && rGDTextfield.text == ""{
                    requiredflag = 0
                }
                else{
                    if isautoPopulated == true{
                        requiredflag = 1
                    }
                    else{
                        requiredflag = 1
                    }
                }
                if requiredflag == 1{
                    serieTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                    rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                }
                else{
                    serieTextfield.layer.borderColor = UIColor.red.cgColor
                    rGNTextfield.layer.borderColor = UIColor.red.cgColor
                    rGDTextfield.layer.borderColor = UIColor.red.cgColor
                }
                
            } else {
                rGNTextfield.layer.borderColor = UIColor.gray.cgColor
                serieTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                rGDTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
            self.animalTextfield.becomeFirstResponder()
            
        }
            
            
            
        else if (textField == self.animalTextfield) {
            
            if animalTextfield.text == ""{
                
                animalTextfield.layer.borderColor = UIColor.red.cgColor
                
            } else {
                
                animalTextfield.layer.borderColor = UIColor.gray.cgColor
                
            }
            
              self.animalTextfield.resignFirstResponder()
            
        }
       
        return true
        
    }
    
    
    
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //  MARK: - Genotype
        
        
        
        if let char = string.cString(using: String.Encoding.utf8) {
            
            
            
            let isBackSpace = strcmp(char, "\\b")
            
            if (isBackSpace == -92) {
                
                print("Backspace was pressed")
                
                if textField == scanBarcodeTextfield{
                    
                    if scanBarcodeTextfield.text!.count == 1 {
                        
                        OtherbyTextfieldGray()
                        
                    } else {
                        
                        othersByDefaultBackroundWhite()
                        
                    }
                    
                }
                
                if textField == genotypeScanBarcodeTextField{
                    
                    if genotypeScanBarcodeTextField.text!.count == 1 {
                        
                        GenotypebyDefaultbackroundGray()
                        
                    } else {
                        
                        GenotypebyDefaultbackroundWhite()
                        
                    }
                    
                }
                
            }
                
            else {
                
                if textField == genotypeScanBarcodeTextField{
                    
                    GenotypebyDefaultbackroundWhite()
                    
                    
                    
                }
                
                if textField == scanBarcodeTextfield{
                    
                    othersByDefaultBackroundWhite()
                    
                    
                    
                }
                
                
                
            }
            if editIngText == true{
                editIngText = false
                
            }
                
            else if isUpdate == true {
                animalId1 = editAid
                isUpdate = false
            }
            if statusOrder == true{
                msgAnimalSucess = true
            }
            else{
                messageCheck = true
            }
            
            let animalFetch = fetchAllDataWithAnimalId(entityName: "BeefAnimalMaster", animalId: idAnimal)
            if animalFetch.count > 0{
                statusOrder = true
            }
            let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimaladdTbl", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
            if animalDataMaster.count > 0 {
                msgUpatedd = true
            }
            
            if isautoPopulated == true {
                let animalData = fetchAnimaldataValidateAnimalTag(entityName: "BeefAnimaladdTbl", animalTag:scanAnimalText, orderId: orderId, userId: userId, animalId: animalId1)
                if animalData.count == 0{
                    let animalDataMaster = fetchAnimaldataValidateAnimalId(entityName: "BeefAnimalMaster", animalId :animalId1,orderId:orderId,userId:userId, orderStatus:"false" )
                    if animalDataMaster.count > 0 {
                        msgcheckk = true
                    }
                }
            }
            
            
        }
        
        return true
        
    }
    
}
extension BeefAnimalBrazilVC : SideMenuUI,objectPickCartScreen{
    func objectGetOnSelection(temp: Int) {
        
    }
    func anOptionalMethod(check :Bool){
        
        if check == true{
            isUpdate = false
            editIngText = false
            statusOrder = false
            //       msgAnimalSucess = false
            animalId1 = -1
            editAid = -1
            idAnimal = 0
            isautoPopulated = false
            byDefaultSetting()
            OtherbyTextfieldGray()
            msgUpatedd = false
        }}
    
    func changeCornerRadius(val: Int) {
        self.view.makeCorner(withRadius: CGFloat(val))
    }
}
