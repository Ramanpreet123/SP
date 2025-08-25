//
//  ResultTypeSelectionViewController.swift
//  SearchPoint
//
//  Created by Rajni Raswant on 16/08/23.
//

import UIKit

//MARK: CLASS
class ResultTypeSelectionViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: VARIABLES
    var delegate : ResultTypeSelectionDelegate?
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    //MARK: METHODS
    func resultSelection(){
        self.dismiss(animated: true)
        let vc = self.storyboard!.instantiateViewController(withIdentifier: ClassIdentifiers.myHerdResultsVC) as! MyHerdResultsViewController
        self.navigationController?.present(vc, animated: false, completion: nil)
    }
}

//MARK: TABLEVIEW DATASOURCE AND DELEGATES
extension ResultTypeSelectionViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 251
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ResultByCell
        if indexPath.row == 0 {
            cell.animalImage.image = UIImage.init(named: ImageNames.cowImg)
            cell.titleLbl.text = ButtonTitles.byAnimalText.localized
            cell.lineLbl.isHidden = false
        } else if indexPath.row == 1 {
            cell.animalImage.image = UIImage.init(named: ImageNames.resultFilterImg)
            cell.titleLbl.text = ButtonTitles.byFilterText.localized
            cell.lineLbl.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true)
        self.delegate?.selectedIndex(index: indexPath.row)
    }
}
