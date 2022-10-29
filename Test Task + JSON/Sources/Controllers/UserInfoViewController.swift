//
//  UserInfoViewController.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 27.10.22.
//

import UIKit

class UserInfoViewController: UIViewController {

    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var seconNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var stackView = UIStackView(arrangeSubview: [firstNameLabel,
                                                             seconNameLabel,
                                                             ageLabel,
                                                             phoneLabel,
                                                             emailLabel,
                                                             passwordLabel],
                                             axis: .vertical,
                                             spacing: 10,
                                             distribution: .fillProportionally)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Active User"
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        setModel()
    }

    private func setupHierarchy() {
        view.addSubview(stackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }

    private func setModel() {
        guard let activeUser = DataBase.shared.activeUser else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: activeUser.age)

        firstNameLabel.text = activeUser.firstName
        seconNameLabel.text = activeUser.secondName
        phoneLabel.text = activeUser.phone
        emailLabel.text = activeUser.email
        passwordLabel.text = activeUser.password
        ageLabel.text = dateString
    }
}
