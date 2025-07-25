//
//  StoryboardPageTabMenuController.swift
//  SearchPoint
//
//  Created by Mobile Programming on 29/02/24.
//

import Foundation
import UIKit
import Swift_PageMenu
import Alamofire

//MARK: CLASS
class StoryboardPageTabMenuViewController: PageMenuController {
    
    //MARK: VARIABLES AND CONSTANTS
    var items: [[String]]
    var titles: [String]
    var tabT = [String]()
    var productName = String()
    var fetchMyHerdData = [ResultMyHerdData]()
    var bckScreenIndexGet = Int()
    var boolcheck = false
    var searchbyAnimal = Bool()
    
    //MARK: INITIALIZATION
    init(items: [[String]], titles: [String], options: PageMenuOptions? = nil) {
        self.items = items
        self.titles = titles.map { $0.uppercased()}
        super.init(options: options)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        bckScreenIndexGet = UserDefaults.standard.value(forKey: keyValue.myHerdListSelectIndex.rawValue) as? Int ?? 0
        let custmerID = UserDefaults.standard.value(forKey: keyValue.currentActiveCustomerId.rawValue) as? Int64 ?? 0
        searchbyAnimal = UserDefaults.standard.bool(forKey: keyValue.searchByAnimal.rawValue)
        var selectedProuductName = ""
        if searchbyAnimal {
            fetchMyHerdData   = fetchResultpagenumberMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID ,searchFound: true) as! [ResultMyHerdData]
            selectedProuductName = productName
            UserDefaults.standard.set(productName, forKey: keyValue.selectedProviderName.rawValue)
        } 
        else {
            fetchMyHerdData = fetchResultMyHerdData(entityName: Entities.resultMyherdDataTblEntity,customerId:custmerID) as! [ResultMyHerdData]
            
            if productName == keyValue.USDairyProducts.rawValue || productName == keyValue.clarifideCDCBBenelux.rawValue  || productName == LocalizedStrings.clarifideCDCB  || productName == "" {
                if UserDefaults.standard.bool(forKey: keyValue.isHerditySelected.rawValue)
                {
                    selectedProuductName = LocalizedStrings.herdity
                } else {
                    selectedProuductName = LocalizedStrings.clarifideCDCB
                }
            }
            else {
                selectedProuductName = LocalizedStrings.clarifideDataGene
            }
        }
        
        if searchbyAnimal {
            let traitHeader = fetchResultHeaderAllDataForSearchAnimal(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabT = hName.removeDuplicates()
        }
        else {
            let traitHeader = fetchResultHeaderAllData(entityName: Entities.resultTraitHeaderTblEntity, productName: selectedProuductName)
            let hName :[String] = traitHeader.value(forKey: keyValue.headerName.rawValue) as! [String]
            tabT = hName.removeDuplicates()
        }
        
        self.edgesForExtendedLayout = []
        if options.layout == .layoutGuide && options.tabMenuPosition == .bottom {
            self.view.backgroundColor = .red
        } else {
            self.view.backgroundColor = .white
        }
        
        if self.options.tabMenuPosition == .custom {
            self.view.addSubview(self.tabMenuView)
            self.tabMenuView.translatesAutoresizingMaskIntoConstraints = false
            
            self.tabMenuView.heightAnchor.constraint(equalToConstant: self.options.menuItemSize.height).isActive = true
            self.tabMenuView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
            self.tabMenuView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            if #available(iOS 11.0, *) {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            } else {
                self.tabMenuView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
            }
        }
        self.delegate = self
        self.dataSource = self
    }
}

//MARK: PAGE MENU CONTROLLER DATASOURCE
extension StoryboardPageTabMenuViewController: PageMenuControllerDataSource {
    func viewControllers(forPageMenuController pageMenuController: PageMenuController) -> [UIViewController] {
        return self.items.map(ChildViewController.init)
        
    }
    func menuTitles(forPageMenuController pageMenuController: PageMenuController) -> [String] {
        return self.titles
    }
    func defaultPageIndex(forPageMenuController pageMenuController: PageMenuController) -> Int {
        return 0
    }
}

//MARK: PAGE MENU CONTROLLER DELEGATE
extension StoryboardPageTabMenuViewController: PageMenuControllerDelegate {
    func pageMenuController(_ pageMenuController: PageMenuController, didScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        if index == 0{
            UserDefaults.standard.removeObject(forKey: keyValue.checkGroupIcon.rawValue)
        }
        else{
            UserDefaults.standard.setValue("false", forKey: keyValue.checkGroupIcon.rawValue)
        }
        UserDefaults.standard.setValue(index, forKey: keyValue.scrollIncrement.rawValue)
        UserDefaults.standard.setValue(index, forKey: keyValue.checkIndex.rawValue)
    }
    
    func pageMenuController(_ pageMenuController: PageMenuController, willScrollToPageAtIndex index: Int, direction: PageMenuNavigationDirection) {
        
    }
    
    func pageMenuController(_ pageMenuController: PageMenuController, scrollingProgress progress: CGFloat, direction: PageMenuNavigationDirection) {
        
    }
    
    func pageMenuController(_ pageMenuController: PageMenuController, didSelectMenuItem index: Int, direction: PageMenuNavigationDirection) {
        UserDefaults.standard.setValue(index, forKey: keyValue.checkIndex.rawValue)
        if index == 0{
            UserDefaults.standard.removeObject(forKey: keyValue.checkGroupIcon.rawValue)
        }
        else{
            UserDefaults.standard.setValue("false", forKey: keyValue.checkGroupIcon.rawValue)
        }
    }
}


