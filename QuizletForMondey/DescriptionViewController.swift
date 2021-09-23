//
//  FullDescriptionOfTaskViewController.swift
//  QuizletForMondey
//
//  Created by Андрей  on 20.09.2021.
//

import UIKit

class DescriptionViewController: UIViewController {

    //MARK: - IBOutlet
    @IBOutlet var taskTextView: UITextView!
    @IBOutlet var mainSwitch: UISwitch!
    
    //MARK: - Property
    var taskStr: String = ""
    var tempArray: [String: Bool] = [:]
    var closure: (() -> ())?
    var closureForSwitch: (() -> ())?
    var tempState = false
    //MARK: - LyfeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        closure?()
    }

    
    
    
    //MARK: - IBAction
    @IBAction func addNewFromSecondVC(_ sender: Any) {
        addAlertForNewItem { text in
            self.saveFiles(s: text)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func secondSwitchAction(_ sender: Any) {
        closureForSwitch?()
    }
    
    
    
}

private extension DescriptionViewController {
    
    func setupUI() {
        mainSwitch.setOn(tempState, animated: true)
        taskTextView.text = taskStr
        taskTextView.layer.borderWidth = 1
        taskTextView.layer.borderColor = UIColor.green.cgColor
        taskTextView.clipsToBounds = false
        taskTextView.layer.shadowOpacity = 0.4
        taskTextView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    func saveFiles(s: String) {
        UserSettings.task.append([s : false])
    }
    
}

