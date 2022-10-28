//
//  UserDefaultsManager.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 28.10.22.
//

import Foundation

class DataBase {

    static let shared = DataBase()

    enum SettingKeys: String {
        case users
    }

    let defaults = UserDefaults.standard
    let userKey = SettingKeys.users.rawValue

    var users: [User] {
        get {
            if let data = defaults.value(forKey: userKey) as? Data {
                return try! PropertyListDecoder().decode([User].self, from: data)
            } else {
                return [User]()
            }
        }
        set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                defaults.set(data, forKey: userKey)            }
        }
    }

    func saveUser(firstName: String, secondName: String, phone: String, email: String, password: String, age: Date) {

        let user = User(firstName: firstName, secondName: secondName, phone: phone, email: email, password: password, age: age)
        users.insert(user, at: 0)
    }
}
