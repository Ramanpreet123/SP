//
//  NotesPhotosViewController.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 18/08/23.
//

import UIKit

//MARK: CLASS
class NotesPhotosViewController: UIViewController {
  
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
      notesTxtView.contentMode = .scaleAspectFit
    } else {
        notesTxtView.text = LocalizedStrings.noNotesAvailable.localized
      notesTxtView.textAlignment = .center
    }
    if photoFound{
      photoImageView.image = photo
      photoImageView.contentMode = .scaleAspectFit
      placeholderImageView.isHidden = true
      noImageLabl.isHidden = true
    } else {
        photoImageView.image = UIImage(named: ImageNames.noImage)
        noImageLabl.text = LocalizedStrings.noImageAvailable.localized
      placeholderImageView.isHidden = false
      photoImageView.contentMode = .scaleAspectFill
    }
  }
    
    //MARK: IB ACTIONS
  @IBAction func closeButtonAction(sender: UIButton){
      self.dismiss(animated: true)
  }
}
