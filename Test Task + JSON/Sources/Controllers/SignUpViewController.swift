//
//  SignUpViewController.swift
//  Test Task + JSON
//
//  Created by Артем Галай on 25.10.22.
//

import UIKit

class SignUpViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func makeTextField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }

    private func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.gray.cgColor
        datePicker.layer.cornerRadius = 5
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.tintColor = .black
        return datePicker
    }()

    private lazy var firstNameTextField = makeTextField(placeholder: "First Name")
    private lazy var secondNameTextField = makeTextField(placeholder: "Second Name")
    private lazy var phoneNumberTextField = makeTextField(placeholder: "Phone")
    private lazy var emailTextField = makeTextField(placeholder: "E-mail")
    private lazy var passwordTextField = makeTextField(placeholder: "Password")

    private lazy var firstNameValidLabel = makeLabel(text: "Required field")
    private lazy var secondNameValidLabel = makeLabel(text: "Required field")
    private lazy var ageValidLabel = makeLabel(text: "Required field")
    private lazy var phoneNumberValidLabel = makeLabel(text: "Required field")
    private lazy var emailValidLabel = makeLabel(text: "Required field")
    private lazy var passwordValidLabel = makeLabel(text: "Required field")

    private lazy var elementsStackView = UIStackView(arrangeSubview: [firstNameTextField, firstNameValidLabel, secondNameTextField, secondNameValidLabel, datePicker, ageValidLabel, phoneNumberTextField, phoneNumberValidLabel, emailTextField, emailValidLabel, passwordTextField, passwordValidLabel],
                                                     axis: .vertical,
                                                     spacing: 10,
                                                     distribution: .fillProportionally)

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "signUp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
    }


    private func setupHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(registrationLabel)
        backgroundView.addSubview(elementsStackView)
        backgroundView.addSubview(signUpButton)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([

            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),

            registrationLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            registrationLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 40),

            elementsStackView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 20),
            elementsStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementsStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementsStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20),

            signUpButton.topAnchor.constraint(equalTo: elementsStackView.bottomAnchor, constant: 10),
            signUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 120),
            signUpButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }

    @objc func signUpTapped() {
        print("Hello")

    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
