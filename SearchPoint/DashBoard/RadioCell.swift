//
//  RadioCell.swift
//  RadioButtonDemo
//
//  Created by Roland Leth on 19.10.2016.
//  Copyright © 2016 Roland Leth. All rights reserved.
//

import UIKit

//MARK: RADIO TABLEVIEW CELL
class RadioCell: UITableViewCell {
    
    //MARK: IB OUTLETS
    @IBOutlet weak var filter2Lbl: UILabel!
    @IBOutlet weak var radioButton2: UIButton!
    @IBOutlet weak var radioButton1: UIButton!
    @IBOutlet weak var filter1Lbl: UILabel!
    
    //MARK: VARIABLES
    var delegate: CustomTableViewCellDelegate?
}

