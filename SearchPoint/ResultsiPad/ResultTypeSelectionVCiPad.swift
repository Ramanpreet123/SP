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



//MARK: TABLEVIEW DATASOURCE AND DELEGATES
//extension ResultTypeSelectionVCiPad : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 251
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ResultByCell
//        if indexPath.row == 0 {
//            cell.animalImage.image = UIImage.init(named: ImageNames.cowImg)
//            cell.titleLbl.text = ButtonTitles.byAnimalText.localized
//            cell.lineLbl.isHidden = false
//        } else if indexPath.row == 1 {
//            cell.animalImage.image = UIImage.init(named: ImageNames.resultFilterImg)
//            cell.titleLbl.text = ButtonTitles.byFilterText.localized
//            cell.lineLbl.isHidden = true
//        }
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.dismiss(animated: true)
//        self.delegate?.selectedIndex(index: indexPath.row)
//    }
//}
