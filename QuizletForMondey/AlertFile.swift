//
//  AlertFile.swift
//  QuizletForMondey
//
//  Created by Андрей  on 21.09.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func addAlertForNewItem(closure: @escaping (String) -> Void ) {
        let alert = UIAlertController(title: "Добавить новую задачу", message: "Пожалуйста,заполните поле", preferredStyle: .alert)
        var alertTextField: UITextField!
        alert.addTextField { textField in
            alertTextField = textField
            textField.placeholder = "Новая задача"
        }
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { action in
                guard alertTextField.text?.isEmpty == false else {
                    return
                }
                if(alert.textFields?[0].text != ""){
                    closure((alert.textFields?[0].text)!)
                }
                else{
                    return
                }
            }
                let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
                alert.addAction(cancelAction)
                alert.addAction(saveAction)
                present(alert, animated: true, completion: nil)
            }
}
