//
//  MyHerdCollectionViewCelliPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 18/05/25.
//

import Foundation

class MyHerdCollectionViewCelliPad: UICollectionViewCell {
    
    @IBOutlet weak var rankTitle: UILabel!
    @IBOutlet weak var cellGroupImage: UIImageView!
    @IBOutlet weak var cellGroupView: UIView!
    @IBOutlet weak var groupListView: UIView!
    @IBOutlet weak var barnGroupView: UIView!
    @IBOutlet weak var cellInnerView: UIView!
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var officialIdLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var tableviewstackview: UIStackView!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var cellBackroundView: UIView!
    @IBOutlet weak var notesImgView: UIImageView!
    @IBOutlet weak var Label1: UILabel!
    @IBOutlet weak var selectedBackroundView: UIView!
    @IBOutlet weak var barnButton: UIButton!
    @IBOutlet weak var dollarButton: UIButton!
    @IBOutlet weak var unassignedButton: UIButton!

    var checksatus = Int16()
    var groupTypeId = Int64()
    var checkCOntroller = ""
    var index = 0
    var delegate : swipeCell?
    var showView = true
    var barnAction:((_ string: String?) -> Void)?
    var dollarAction:((_ string: String?) -> Void)?
    var unAssignedAction:((_ string: String?) -> Void)?
    var isDetailScreen : Bool? = false
    
    @IBAction func groupBtnAction(_ sender: Any) {
        if self.isDetailScreen == true {
            if self.checksatus == 0 {
                return
            }
            if groupTypeId == 1 {
                if showView {
                    self.groupListView.isHidden = false
                    showView = false
                } else {
                    self.groupListView.isHidden = true
                    showView = true
                }
            } else {
                if showView {
                    self.barnGroupView.isHidden = false
                    showView = false
                } else {
                    self.barnGroupView.isHidden = true
                    showView = true
                }
            }
        } else {
            if showView {
                self.groupListView.isHidden = false
                showView = false
            } else {
                self.groupListView.isHidden = true
                showView = true
            }
        }
      
       
    }
    
    @IBAction func barnAction(_ sender: Any) {
        if self.isDetailScreen == true {
            self.barnGroupView.isHidden = true
        } else {
            self.groupListView.isHidden = true
        }
        
        self.barnAction?("")
    }
    
    
    @IBAction func dollarAction(_ sender: Any) {
        self.groupListView.isHidden = true
        self.dollarAction?("")
    }
    
    
    @IBAction func unassignedAction(_ sender: Any) {
        if self.isDetailScreen == true {
            self.barnGroupView.isHidden = true
            self.groupListView.isHidden = true
        } else {
            self.groupListView.isHidden = true
        }
        self.unAssignedAction?("")
    }
 
}
