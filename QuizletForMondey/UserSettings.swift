//
//  UserSettings.swift
//  QuizletForMondey
//
//  Created by Андрей  on 21.09.2021.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case task
    }

    static var task: [Dictionary<String, Bool>]! {
        get {
            return UserDefaults.standard.array(forKey: SettingsKeys.task.rawValue) as? [Dictionary<String, Bool>]
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.task.rawValue
            if let task = newValue {
                defaults.set(task, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
}
