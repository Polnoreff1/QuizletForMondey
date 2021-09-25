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
    var closure: (() -> ())?
    var closureForSwitch: (() -> ())?
    var tempState: Bool = false
    
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
    }
    
    @IBAction func secondSwitchAction(_ sender: Any) {
        closureForSwitch?()
    }
}

extension DescriptionViewController {
    
    func setupUI() {
        mainSwitch.setOn(tempState, animated: true)
        taskTextView.text = taskStr
        taskTextView.layer.borderWidth = 1
        switch tempState {
        case true:
            taskTextView.layer.borderColor = UIColor.green.cgColor
        case false:
            taskTextView.layer.borderColor = UIColor.red.cgColor
        }
        taskTextView.clipsToBounds = false
        taskTextView.layer.shadowOpacity = 0.4
        taskTextView.layer.shadowOffset = CGSize(width: 6, height: 6)
    }
    
    internal override func viewDidLayoutSubviews() {
        taskTextView.layer.cornerRadius = 15
    }
    
    func saveFiles(s: String) {
        UserSettings.task.append([s : false])
    }
    
}
