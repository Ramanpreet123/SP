//
//  InheritQuestionaireController.swift
//  SearchPoint
//
//  Created by "" on 16/03/2020.
//

import UIKit

// MARK: - INHERIT QUESTIONNAIRE CONTROLLER
class InheritQuestionaireController: UIViewController {
    
    // MARK: - IB OUTLETS
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var tertiaryLabel: UILabel!
    @IBOutlet weak var primaryButton: UIButton!
    @IBOutlet weak var secondaryButton: UIButton!
    @IBOutlet weak var tertiaryButton: UIButton!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var doneBTnOutlet: UIButton!
    
    // MARK: - VARIABLES AND CONSTANTS
    let inheritQuestionaireModel = InheritQuestionaireModel()
    weak var delegate: InheritQuestionaireControllerDelegate?
    var langId = UserDefaults.standard.value(forKey: keyValue.lngId.rawValue) as? Int
    
    // MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.inheritQuestionaireModel.setSelectedBreedQuesionnaire()
        doneBTnOutlet.setTitle(NSLocalizedString(LocalizedStrings.doneStr.localized, comment: ""), for: .normal)
        self.configureUI()
        self.configureTableView()
    }
    
    // MARK: - UI METHODS AND FUNCTIONS
    func configureUI() {
        self.titleLabel.text = NSLocalizedString(ButtonTitles.selectBreedHerdText, comment: "")
        self.inheritQuestionaireModel.currentActiveBreedType = .primary
        self.tableView.reloadData()    }
    
    func handlingBreedSelection_PreviousNext() {
        
        if let currentActiveBreedType = BreedType(rawValue: self.inheritQuestionaireModel.currentActiveBreedTypeIntValue) {
            switch currentActiveBreedType {
            case .primary:
                self.inheritQuestionaireModel.currentActiveBreedType = .primary
                self.primaryButton.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                previousButton.isUserInteractionEnabled = false
                previousButton.backgroundColor = .lightGray
                nextButton.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                
            case .secondary:
                self.inheritQuestionaireModel.currentActiveBreedType = .secondary
                self.secondaryButton.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                previousButton.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                nextButton.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                
            case .tertiary:
                self.inheritQuestionaireModel.currentActiveBreedType = .tertiary
                self.tertiaryButton.layer.borderColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1).cgColor
                nextButton.isUserInteractionEnabled = false
                previousButton.backgroundColor = UIColor(red: 10/255, green: 137/255, blue: 157/255, alpha: 1)
                nextButton.backgroundColor = .lightGray
            }
        }
        self.tableView.reloadData()
    }
    
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight =  40
        self.tableView.separatorStyle = .none
        self.tableView.register(QuestionaireViewCell.nib, forCellReuseIdentifier: QuestionaireViewCell.identifier)
        self.tableView.register(UINib(nibName: ClassIdentifiers.questionaireHeaderViewNib, bundle: nil), forHeaderFooterViewReuseIdentifier: ClassIdentifiers.questionaireHeaderViewNib)
    }
    
    // MARK: - IB ACTIONS
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func primaryButtonPressed(_ sender: UIButton) {
        self.inheritQuestionaireModel.currentActiveBreedType = .primary
        self.inheritQuestionaireModel.currentActiveBreedTypeIntValue = 0
        self.handlingBreedSelection_PreviousNext()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        let selectedPrimarBreed = self.inheritQuestionaireModel.primaryHerdBreed.filter { $0.isSelected }
        guard selectedPrimarBreed.count > 0 else {
            CommonClass.showAlertMessage(self, titleStr: NSLocalizedString(AlertMessagesStrings.alertString, comment: ""), messageStr: NSLocalizedString(AlertMessagesStrings.selectPrimaryHerdBreed, comment: ""))
            return
        }
        self.inheritQuestionaireModel.saveSelectedBreedQuestionaire()
        InheritQuestionaireManager.shared.inheritQuestionaireModel = nil
        InheritQuestionaireManager.shared.inheritQuestionaireModel = inheritQuestionaireModel
        self.dismiss(animated: false, completion: nil)
        self.delegate?.inheritQuestionaireControllerDismissed()
    }
}


// MARK: - TABLEVIEW DATASOURCE AND DELEGATES
extension InheritQuestionaireController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.inheritQuestionaireModel.primaryHerdBreed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if UIDevice().userInterfaceIdiom == .pad{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionaireViewCelliPad", for: indexPath) as! QuestionaireViewCell
            cell.questionlabel.text = self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].title
            if self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].isSelected  {
                cell.radioButton.setImage(UIImage(named: ImageNames.radioSelectedBtn), for: .normal)
            } else{
                cell.radioButton.setImage(UIImage(named: ImageNames.radioBtn), for: .normal)
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ClassIdentifiers.questionaireViewCellId, for: indexPath) as! QuestionaireViewCell
        cell.questionlabel.text = self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].title
        if self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].isSelected  {
            cell.radioButton.setImage(UIImage(named: "radioSelectediPhone"), for: .normal)
        } else{
            cell.radioButton.setImage(UIImage(named: "radioUnselectediPhone"), for: .normal)
        }
        return cell
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isSelected = self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].isSelected
        
        for breed in self.inheritQuestionaireModel.primaryHerdBreed {
            breed.isSelected = false
        }
        self.inheritQuestionaireModel.primaryHerdBreed[indexPath.row].isSelected = !isSelected
        
        UIView.performWithoutAnimation {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice().userInterfaceIdiom == .phone {
            return 40
        }
        return 60
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
