//
//  AppHelpImagesVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 31/08/22.
//

//import UIKit
//
//class AppHelpImagesVC: UIViewController {
//    
//    // MARK: - OUTLETS
//    
//    @IBOutlet weak var imgView: UIImageView?
//    @IBOutlet weak var previousBtn: UIButton?
//    @IBOutlet weak var nextBtn: UIButton?
//    @IBOutlet weak var pageControl: UIPageControl?
//    
//    // MARK: - VARIABLES
//    
//    var imagesArray = [String]()
//    var imageCount = 0
//    var module: String = ""
//    var newArray = NSArray()
//    var newImages = [UIImage]()
//    var allKey3 = NSArray()
//    var name = String()
//    
//    // MARK: - VIEW LIFE CYCLE
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        switch module {
//        case NSLocalizedString(LocalizedStrings.actionsRequiredText, comment: ""):
//            name = ScreenNames.actionsRequired.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.contactSupportText, comment: ""):
//            name = ScreenNames.contactSupport.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.dashboardText, comment: ""):
//            name = ScreenNames.dashboard.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.dataEntryModeText, comment: ""):
//            name = ScreenNames.dataEntry.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.addOrderingAnimalsText, comment: ""):
//            name = ScreenNames.addAnimal.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.addOrderingAnimalsTextBeef, comment: ""):
//            name = ScreenNames.addAnimalBeef.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.orderingDefaultsText, comment: ""):
//            name = ScreenNames.orderingDefault.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.resultsText, comment: ""):
//            name = ScreenNames.resultHelp.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.trackSamplesText, comment: ""):
//            name = ScreenNames.trackSamples.rawValue
//            
//        case NSLocalizedString(LocalizedStrings.menuText, comment: ""):
//            name = ScreenNames.menu.rawValue
//            
//        default:
//            return
//        }
//        
//        let savedImgArr = fetchImgDetailsFromDB(name: name) as [NSDictionary]
//        allKey3 = savedImgArr.compactMap { $0["imageData"] } as NSArray
//        
//        for imageData in allKey3 {
//            let image = UIImage(data: imageData as! Data)!
//            newImages.append(image)
//        }
//        
//        if newImages.count > 0 {
//            imgView?.image = newImages[0]
//            pageControl?.numberOfPages = newImages.count
//            setImageForNextAndPrevious()
//            pageControl?.addTarget(self, action: #selector(self.changePage(_:)), for: .valueChanged)
//        }
//        
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        if imagesArray.count == 1 {
//            previousBtn?.isHidden = true
//            nextBtn?.isHidden = true
//        }
//    }
//    
//    // MARK: - IB ACTIONS
//    
//    @IBAction func nextImage(_ sender: UIButton) {
//        
//        if imageCount < newImages.count - 1 {
//            imageCount = imageCount + 1
//            imgView?.image = nil
//            imgView?.image = newImages[imageCount]
//            pageControl?.currentPage = imageCount
//        }
//        setImageForNextAndPrevious()
//    }
//    
//    @IBAction func previousImage(_ sender: UIButton) {
//        
//        if imageCount > 0 {
//            imageCount = imageCount - 1
//            imgView?.image = nil
//            imgView?.image = newImages[imageCount]
//            pageControl?.currentPage = imageCount
//        }
//        setImageForNextAndPrevious()
//    }
//    
//    func setImageForNextAndPrevious(){
//        if imageCount >= imagesArray.count - 1 {
//            nextBtn?.setImage(UIImage(named: ImageNames.nextInactiveImg), for: .normal)
//        }else{
//            nextBtn?.setImage(UIImage(named: ImageNames.nextActiveImg), for: .normal)
//        }
//        if imageCount <= 0 {
//            previousBtn?.setImage(UIImage(named: ImageNames.previousInactiveImg), for: .normal)
//        }else{
//            previousBtn?.setImage(UIImage(named: ImageNames.previousActiveImg), for: .normal)
//        }
//    }
//    
//    
//    @IBAction func skipAppHelp(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    @objc func appHelpCpmpleted(button: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
//
//// MARK: - EXTENSIONS
//
//extension AppHelpImagesVC: UIPageViewControllerDelegate {
//    
//    @objc func changePage(_ sender: UIPageControl) {
//      let page: Int = sender.currentPage
//      imgView?.image = UIImage(named: imagesArray[page])
//      pageControl?.currentPage = page
//      imageCount = page
//  }
//    
//}

import UIKit

class AppHelpImagesVC: UIViewController {
  
  @IBOutlet weak var imgView: UIImageView?
  @IBOutlet weak var previousBtn: UIButton?
  @IBOutlet weak var nextBtn: UIButton?
  @IBOutlet weak var pageControl: UIPageControl?
  
  
  var imagesArray = [String]()
  var imageCount = 0
  var module: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    switch module {
    case NSLocalizedString("Actions Required", comment: ""):
      imagesArray = ["AR0", "AR1", "AR2", "AR3"]
    case NSLocalizedString("Contact Support", comment: ""):
      imagesArray = ["CS0"]
    case NSLocalizedString("Dashboard", comment: ""):
      imagesArray = ["DB0", "DB1", "DB2", "DB3", "DB4", "DB5"]
    case NSLocalizedString("Data Entry Mode", comment: ""):
      imagesArray = ["DEM0", "DEM1", "DEM2", "DEM3", "DEM4", "DEM5", "DEM6", "DEM7", "DEM8", "DEM9", "DEM10","DEM11", "DEM12"]
    case NSLocalizedString("Place An Order : Ordering Add Animal(s)", comment: ""):
      imagesArray = ["OAA0", "OAA1", "OAA2", "OAA3", "OAA4", "OAA5", "OAA6", "OAA7", "OAA8", "OAA9", "OAA10", "OAA11", "OAA12", "OAA13","OAA14", "OAA15", "OAA16","OAA17","OAA18","OAA19","OAA20","OAA21","OAA22","OAA23"]
    case NSLocalizedString("Place An Order : Ordering Defaults", comment: ""):
      imagesArray = ["OD0", "OD1", "OD2"]
    case NSLocalizedString("Results", comment: ""):
      imagesArray = ["RES0", "RES1", "RES2", "RES3", "RES4", "RES5", "RES6", "RES7", "RES8", "RES9", "RES10", "RES11", "RES12", "RES13", "RES14", "RES15", "RES16"]
    case NSLocalizedString("Track Samples", comment: ""):
      imagesArray = ["ST0", "ST1", "ST2"]
    case NSLocalizedString("Menu", comment: ""):
      imagesArray = ["SN0", "SN1", "SN2", "SN3", "SN4", "SN5", "SN6", "SN7"]
    default:
      return
    }
    
    imgView?.image = UIImage(named: imagesArray[imageCount])
    pageControl?.numberOfPages = imagesArray.count
    setImageForNextAndPrevious()
    pageControl?.addTarget(self, action: #selector(self.changePage(_:)), for: .valueChanged)
//    pageControl.addTarget(self, action: #selector(pageControlTapHandler(sender:)), for: .touchUpInside)
    
  }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imagesArray.count == 1 {
            previousBtn?.isHidden = true
            nextBtn?.isHidden = true
        }
     }

  @IBAction func nextImage(_ sender: UIButton) {
    if imageCount < imagesArray.count - 1 {
      imageCount = imageCount + 1
      imgView?.image = nil
      imgView?.image = UIImage(named: imagesArray[imageCount])
      pageControl?.currentPage = imageCount
    }
    setImageForNextAndPrevious()
  }
  
  @IBAction func previousImage(_ sender: UIButton) {
    if imageCount > 0 {
      imageCount = imageCount - 1
      imgView?.image = nil
      imgView?.image = UIImage(named: imagesArray[imageCount])
      pageControl?.currentPage = imageCount
    }
    setImageForNextAndPrevious()
  }
  
  func setImageForNextAndPrevious(){
    if imageCount >= imagesArray.count - 1 {
      nextBtn?.setImage(UIImage(named: "next_inactive_grey.png"), for: .normal)
    }else{
      nextBtn?.setImage(UIImage(named: "next_active.png"), for: .normal)
    }
    if imageCount <= 0 {
      previousBtn?.setImage(UIImage(named: "previous_inactive_grey.png"), for: .normal)
    }else{
      previousBtn?.setImage(UIImage(named: "previous_active.png"), for: .normal)
    }
  }
  
  
  @IBAction func skipAppHelp(_ sender: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func appHelpCpmpleted(button: UIButton) {
    self.dismiss(animated: true, completion: nil)
  }
}


extension AppHelpImagesVC: UIPageViewControllerDelegate {
    
    @objc func changePage(_ sender: UIPageControl) {
        let page: Int = sender.currentPage
        print("PAGE ----->>>>>>>  \(page)")
        
          imgView?.image = UIImage(named: imagesArray[page])
          pageControl?.currentPage = page
            imageCount = page
    }
    
}
