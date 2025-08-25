//
//  NotesPhotosVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 27/05/25.
//

import Foundation
import UIKit

//MARK: CLASS
class NotesPhotosVCiPad: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var notesLabl: UILabel!
    @IBOutlet weak var notesTxtView: UITextView!
    @IBOutlet weak var placeholderImageView: UIImageView!
    @IBOutlet weak var noImageLabl: UILabel!
    
    //MARK: VARIABLES AND CONSTANTS
    var notesStr = String()
    var photoFound = Bool()
    var photo = UIImage()
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        if notesStr != ""{
            notesTxtView.text = notesStr
        } else {
            notesTxtView.text = LocalizedStrings.noNotesAvailable.localized
            notesTxtView.textAlignment = .center
        }
        if photoFound{
            photoImageView.image = photo
            photoImageView.contentMode = .scaleAspectFit
            noImageLabl.isHidden = true
        } else {
            photoImageView.image = UIImage(named: ImageNames.noImage)
            noImageLabl.text = LocalizedStrings.noImageAvailable.localized
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    
    //MARK: IB ACTIONS
    @IBAction func closeButtonAction(sender: UIButton){
        self.dismiss(animated: true)
    }
}
