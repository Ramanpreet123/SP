//
//  AppHelpImagesVC.swift
//  SearchPoint
//
//  Created by Mobile Programming on 31/08/22.
//

import UIKit

class AppHelpImagesVC: UIViewController {
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var imgView: UIImageView?
    @IBOutlet weak var previousBtn: UIButton?
    @IBOutlet weak var nextBtn: UIButton?
    @IBOutlet weak var pageControl: UIPageControl?
    
    // MARK: - VARIABLES
    
    var imagesArray = [String]()
    var imageCount = 0
    var module: String = ""
    var newArray = NSArray()
    var newImages = [UIImage]()
    var allKey3 = NSArray()
    var name = String()
    
    // MARK: - VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch module {
        case NSLocalizedString(LocalizedStrings.actionsRequiredText, comment: ""):
            name = ScreenNames.actionsRequired.rawValue
            
        case NSLocalizedString(LocalizedStrings.contactSupportText, comment: ""):
            name = ScreenNames.contactSupport.rawValue
            
        case NSLocalizedString(LocalizedStrings.dashboardText, comment: ""):
            name = ScreenNames.dashboard.rawValue
            
        case NSLocalizedString(LocalizedStrings.dataEntryModeText, comment: ""):
            name = ScreenNames.dataEntry.rawValue
            
        case NSLocalizedString(LocalizedStrings.addOrderingAnimalsText, comment: ""):
            name = ScreenNames.addAnimal.rawValue
            
        case NSLocalizedString(LocalizedStrings.addOrderingAnimalsTextBeef, comment: ""):
            name = ScreenNames.addAnimalBeef.rawValue
            
        case NSLocalizedString(LocalizedStrings.orderingDefaultsText, comment: ""):
            name = ScreenNames.orderingDefault.rawValue
            
        case NSLocalizedString(LocalizedStrings.resultsText, comment: ""):
            name = ScreenNames.resultHelp.rawValue
            
        case NSLocalizedString(LocalizedStrings.trackSamplesText, comment: ""):
            name = ScreenNames.trackSamples.rawValue
            
        case NSLocalizedString(LocalizedStrings.menuText, comment: ""):
            name = ScreenNames.menu.rawValue
            
        default:
            return
        }
        
        let savedImgArr = fetchImgDetailsFromDB(name: name) as [NSDictionary]
        allKey3 = savedImgArr.compactMap { $0["imageData"] } as NSArray
        
        for imageData in allKey3 {
            let image = UIImage(data: imageData as! Data)!
            newImages.append(image)
        }
        
        if newImages.count > 0 {
            imgView?.image = newImages[0]
            pageControl?.numberOfPages = newImages.count
            setImageForNextAndPrevious()
            pageControl?.addTarget(self, action: #selector(self.changePage(_:)), for: .valueChanged)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imagesArray.count == 1 {
            previousBtn?.isHidden = true
            nextBtn?.isHidden = true
        }
    }
    
    // MARK: - IB ACTIONS
    
    @IBAction func nextImage(_ sender: UIButton) {
        
        if imageCount < newImages.count - 1 {
            imageCount = imageCount + 1
            imgView?.image = nil
            imgView?.image = newImages[imageCount]
            pageControl?.currentPage = imageCount
        }
        setImageForNextAndPrevious()
    }
    
    @IBAction func previousImage(_ sender: UIButton) {
        
        if imageCount > 0 {
            imageCount = imageCount - 1
            imgView?.image = nil
            imgView?.image = newImages[imageCount]
            pageControl?.currentPage = imageCount
        }
        setImageForNextAndPrevious()
    }
    
    func setImageForNextAndPrevious(){
        if imageCount >= imagesArray.count - 1 {
            nextBtn?.setImage(UIImage(named: ImageNames.nextInactiveImg), for: .normal)
        }else{
            nextBtn?.setImage(UIImage(named: ImageNames.nextActiveImg), for: .normal)
        }
        if imageCount <= 0 {
            previousBtn?.setImage(UIImage(named: ImageNames.previousInactiveImg), for: .normal)
        }else{
            previousBtn?.setImage(UIImage(named: ImageNames.previousActiveImg), for: .normal)
        }
    }
    
    
    @IBAction func skipAppHelp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func appHelpCpmpleted(button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - EXTENSIONS

extension AppHelpImagesVC: UIPageViewControllerDelegate {
    
    @objc func changePage(_ sender: UIPageControl) {
      let page: Int = sender.currentPage
      imgView?.image = UIImage(named: imagesArray[page])
      pageControl?.currentPage = page
      imageCount = page
  }
    
}
