//
//  UserModel.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 28.10.22.
//

import Foundation

struct User: Codable {
    let firstName: String
    let secondName: String
    let phone: String
    let email: String
    let password: String
    let age: Date
}
