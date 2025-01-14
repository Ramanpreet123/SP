//
//  MyHerdTblCell.swift
//  SearchPoint
//
//  Created by Mobile Programming on 05/03/21.
//

import UIKit

//MARK: MY HERD TABLE CELL
class MyHerdTblCell: UITableViewCell {
    
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

    var checkCOntroller = ""
    var index = 0
    var delegate : swipeCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action:#selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.addGestureRecognizer(leftSwipe)
        self.addGestureRecognizer(rightSwipe)
        
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.index = sender.view?.tag ?? 0
        checkCOntroller = UserDefaults.standard.value(forKey: keyValue.checkGroup.rawValue) as? String ?? ""
        if checkCOntroller == keyValue.groupKey.rawValue
        {
            let groupstatus = UserDefaults.standard.integer(forKey: keyValue.checkActiveInactive.rawValue)
            if groupstatus == 0
            {
                return
            }
        }
        
        if (sender.direction == .left) {
            self.delegate?.swipeLeft(index: sender.view?.tag ?? 0)
            UIView.animate(withDuration: 0.9,delay: 0.3, options: [.curveEaseOut],animations:  {
                
                self.cellBackroundView.transform = CGAffineTransform.init(translationX: -300, y: 0)
                self.cellBackroundView.layer.cornerRadius = 10
            }) { (success) in
                
                UIView.animate(withDuration: 0.2,delay: 0.3, options: [.curveLinear],animations:  {
                    self.cellBackroundView.transform = .identity
                    self.cellBackroundView.layer.cornerRadius = 0
                    
                }) { (success) in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.animationEndNoti), object: nil)
                }}
            
        }
        
        if (sender.direction == .right) {
            self.delegate?.swipeRight(index: sender.view?.tag ?? 0)
            UIView.animate(withDuration: 0.9,delay: 0.3,options: [.curveEaseOut],animations:  {
                self.cellBackroundView.transform = CGAffineTransform.init(translationX: 300, y: 0)
                self.cellBackroundView.layer.cornerRadius = 10
            }) { (success) in
                UIView.animate(withDuration: 0.2,delay: 0.3,options: [.curveLinear],animations:  {
                    self.cellBackroundView.transform = .identity
                    self.cellBackroundView.layer.cornerRadius = 0
                }) { (success) in
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: LocalizedStrings.animationEndNoti), object: nil)
                }}
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: MY HERD COLLECTION CELL
class MyHerdCollectionCell: UICollectionViewCell {
    @IBOutlet weak var providerTitle: UILabel!
    @IBOutlet weak var breedTitle: UILabel!
    @IBOutlet weak var ProviderBGView: UIView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = UIColor(red: 15/255, green: 117/255, blue: 187/255, alpha:1.0)
            } else {
                backgroundColor = UIColor.white
                
            }
            
            
        }
    }
    
}
