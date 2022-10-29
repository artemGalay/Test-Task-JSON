//
//  AuthViewController.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 25.10.22.
//

import UIKit

class AuthViewController: UIViewController {

    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "signIn")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "signUp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var textFieldStackView = UIStackView(arrangeSubview: [emailTextField, passwordTextField],
                                                      axis: .vertical,
                                                      spacing: 10,
                                                      distribution: .fillProportionally)

    private lazy var buttonsStackView = UIStackView(arrangeSubview: [signInButton, signUpButton],
                                                    axis: .horizontal,
                                                    spacing: 10,
                                                    distribution: .fillEqually)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }

    private func setupHierarchy() {
        view.addSubview(loginLabel)
        view.addSubview(textFieldStackView)
        view.addSubview(buttonsStackView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),

            textFieldStackView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 10),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            signInButton.heightAnchor.constraint(equalToConstant: 120),
            signUpButton.heightAnchor.constraint(equalToConstant: 120),

            buttonsStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 10),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }

    @objc func signInTapped() {

        let mail = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let user = findUserDataBase(mail: mail)

        if user == nil {
            loginLabel.text = "User not found"
            loginLabel.textColor = .red
        } else if user?.password == password {
            let navigationViewController = UINavigationController(rootViewController: AlbumsViewController())
            navigationViewController.modalPresentationStyle = .fullScreen
            present(navigationViewController, animated: true)

            guard let activeUser = user else { return }
            DataBase.shared.saveActiveUser(user: activeUser )
        } else {
            loginLabel.text = "Wrong password"
            loginLabel.textColor = .red

        }
    }

    @objc func signUpTapped() {
        let viewController = SignUpViewController()
        present(viewController, animated: true)
    }

    private func findUserDataBase(mail: String) -> User? {
        let dataBase = DataBase.shared.users
        print(dataBase)

        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        return nil
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
