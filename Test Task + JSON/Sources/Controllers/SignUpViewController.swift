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

    private lazy var elementsStackView = UIStackView(arrangeSubview: [firstNameTextField,
                                                                      firstNameValidLabel,
                                                                      secondNameTextField,
                                                                      secondNameValidLabel,
                                                                      datePicker,
                                                                      ageValidLabel,
                                                                      phoneNumberTextField,
                                                                      phoneNumberValidLabel,
                                                                      emailTextField,
                                                                      emailValidLabel,
                                                                      passwordTextField,
                                                                      passwordValidLabel],
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

    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupHierarchy()
        setupLayout()
        registerKeyboardNotificatuion()
    }

    deinit {
        removeKeyboardNotification()
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
            registrationLabel.topAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.topAnchor, constant: 170),

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
        let firstNameText = firstNameTextField.text ?? ""
        let secondNameText = secondNameTextField.text ?? ""
        let emailText = emailTextField.text ?? ""
        let passwordText = passwordTextField.text ?? ""
        let phoneText = phoneNumberTextField.text ?? ""

        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 18
            && ageIsValid() == true {
            DataBase.shared.saveUser(firstName: firstNameText,
                                     secondName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: datePicker.date)
            registrationLabel.text = "Registration complete"
        } else {
            registrationLabel.text = "Registration"
            alertOk(title: "Error", message: "Fill in all the filds")
        }
    }
}

// MARK: - Keyboard Show Hide

extension SignUpViewController {

    private func registerKeyboardNotificatuion() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notofocation: Notification) {
        let userInfo = notofocation.userInfo
        let keyboardHeight = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardHeight.height / 2)
    }

    @objc private func keyboardWillHide(notofocation: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }

    private func setTextField(textField: UITextField, label: UILabel, valipType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {

        let text = (textField.text ?? "") + string
        let result: String

        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        textField.text = result

        if result.isValid(validType: valipType) {
            label.text = validMessage
            label.textColor = .green
        } else {
            label.text = wrongMessage
            label.textColor = .red
        }
    }

    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex

        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }

        if result.count == 18 {
            phoneNumberValidLabel.text = "Phine is valid"
            phoneNumberValidLabel.textColor = .green
        } else {
            phoneNumberValidLabel.text = "Phine is not valid"
            phoneNumberValidLabel.textColor = .red
        }
        return result
    }

    private func ageIsValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date

        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else { return false }
        return (ageUser < 18 ? false : true)

    }
}

extension SignUpViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        switch textField {
        case firstNameTextField: setTextField(textField: firstNameTextField,
                                              label: firstNameValidLabel,
                                              valipType: nameValidType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters, min 1 character",
                                              string: string,
                                              range: range)
        case secondNameTextField: setTextField(textField: secondNameTextField,
                                               label: secondNameValidLabel,
                                               valipType: nameValidType,
                                               validMessage: "Name is valid",
                                               wrongMessage: "Only A-Z characters, min 1 character",
                                               string: string,
                                               range: range)
        case emailTextField: setTextField(textField: emailTextField,
                                               label: emailValidLabel,
                                               valipType: emailValidType,
                                               validMessage: "Email is valid",
                                               wrongMessage: "Email is not valid",
                                               string: string,
                                               range: range)
        case passwordTextField: setTextField(textField: passwordTextField,
                                               label: passwordValidLabel,
                                               valipType: passwordValidType,
                                               validMessage: "Password is valid",
                                               wrongMessage: "Password is not valid",
                                               string: string,
                                               range: range)
        case phoneNumberTextField: phoneNumberTextField.text = setPhoneNumberMask(textField: phoneNumberTextField,
                                                                                  mask: "+X (XXX) XXX-XX-XX",
                                                                                  string: string,
                                                                                  range: range)
        default:
            break
        }

        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameTextField.resignFirstResponder()
        secondNameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        return true
    }
}
