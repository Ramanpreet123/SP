//
//  ContactSupportCell.swift
//  SearchPoint
//
//  Created by "" on 11/11/2019.
//  ""
//

import UIKit

//MARK: CONTACT SUPPORT CELL
class ContactSupportCell: UITableViewCell {

    //MARK: OUTLETS
    @IBOutlet weak var flagImgView: UIImageView!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var clockImg: UIImageView!
    @IBOutlet weak var emailImg: UIImageView!
    @IBOutlet weak var phoneImg: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneNoLbl: UILabel!
    @IBOutlet weak var textLbl: UILabel!
    @IBOutlet weak var emailBttnClick: UIButton!
    @IBOutlet weak var phoneNoBttnClick: UIButton!
    @IBOutlet weak var textBttnClick: UIButton!
    @IBOutlet weak var labelContactWebsite: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    @IBOutlet weak var countryBtn: customButton!
    @IBOutlet weak var hoursOpertionLbl: UILabel!
    @IBOutlet weak var additionalResourceView: UIView!
    
    //MARK: INITIAL UI METHODS
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
