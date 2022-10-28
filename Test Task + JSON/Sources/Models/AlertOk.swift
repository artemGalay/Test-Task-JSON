//
//  AlertOk.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 28.10.22.
//

import UIKit

extension UIViewController {
    func alertOk(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)

        alert.addAction(ok)

        present(alert, animated: true)
    }
}
