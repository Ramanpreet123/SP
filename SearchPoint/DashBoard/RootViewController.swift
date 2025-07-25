//
//  RootViewController.swift
//  SearchPoint
//
//  Created by "" on 03/10/2019.
//  ""
//

import UIKit
import AKSideMenu

public class RootViewController: AKSideMenu, AKSideMenuDelegate {
   
    override public func awakeFromNib() {
        super.awakeFromNib()
        self.menuPreferredStatusBarStyle = .lightContent
        self.contentViewShadowColor = .black
        self.contentViewShadowOffset = CGSize(width: 0, height: 0)
        self.contentViewShadowOpacity = 0.6
        self.contentViewShadowRadius = 12
        self.contentViewShadowEnabled = true
        self.panGestureEnabled = false
        self.panFromEdge = false
        
       // self.backgroundImage = UIImage(named: "Stars")
        self.delegate = self
        var storyBoard = UIStoryboard()
        if UIDevice().userInterfaceIdiom == .phone {
             storyBoard = UIStoryboard(name: StoryboardType.MainStoryboard, bundle: nil)
            self.contentViewController = storyBoard.instantiateViewController(withIdentifier: "contentViewController")
               
            self.rightMenuViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC")
        }
        else {
             storyBoard = UIStoryboard(name: "iPad", bundle: nil)
            self.contentViewController = storyBoard.instantiateViewController(withIdentifier: "contentViewController")
               
            self.leftMenuViewController = storyBoard.instantiateViewController(withIdentifier: "SideMenuVC")
        }
        
       // if let storyboard = self.storyboard {
     
            
       // }
    }
    
    // MARK: - <AKSideMenuDelegate>
    
    public func sideMenu(_ sideMenu: AKSideMenu, willShowMenuViewController menuViewController: UIViewController) {
       
    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, didShowMenuViewController menuViewController: UIViewController) {
       
    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, willHideMenuViewController menuViewController: UIViewController) {
       let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.deleg!.changeCornerRadius(val :0)
        

    }
    
    public func sideMenu(_ sideMenu: AKSideMenu, didHideMenuViewController menuViewController: UIViewController) {
       
    }
}
