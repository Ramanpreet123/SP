//
//  ResultTypeSelectionVCiPad.swift
//  SearchPoint
//
//  Created by Ramanpreet Singh on 08/05/25.
//

import Foundation
//MARK: CLASS
class ResultTypeSelectionVCiPad: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var animalView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: VARIABLES
    var delegate : ResultTypeSelectionDelegate?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        filterView.layer.cornerRadius = 18
        filterView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        filterView.layer.shadowOffset = CGSize(width: 0, height: 1)
        filterView.layer.shadowOpacity = 0.7
        filterView.layer.shadowRadius = 6
        
        animalView.layer.cornerRadius = 18
        animalView.layer.shadowColor = UIColor.black.withAlphaComponent(0.4).cgColor
        animalView.layer.shadowOffset = CGSize(width: 0, height: 1)
        animalView.layer.shadowOpacity = 0.7
        animalView.layer.shadowRadius = 6
    }
    
    //MARK: METHODS
    func resultSelection(){
        self.dismiss(animated: true)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdResultsVC) as! MyHerdResultsViewController
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func searchByAnimal(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.selectedIndex(index: sender.tag)
    }
    
    @IBAction func searchByFilter(_ sender: UIButton) {
        self.dismiss(animated: true)
        self.delegate?.selectedIndex(index: sender.tag)
    }
    
    
}
