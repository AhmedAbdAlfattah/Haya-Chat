//
//  LoginController.swift
//  Haya Chat
//
//  Created by Ahmed on 11/9/18.
//  Copyright © 2018 Neon. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
class LoginController: UIViewController {
    let inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    let nameTextField: UITextField = {
        let textF = UITextField()
        textF.placeholder = "Name"
        textF.translatesAutoresizingMaskIntoConstraints = false
        return textF
    }()
    let nameSperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let emailTextField: UITextField = {
        let textF = UITextField()
        textF.placeholder = "Email"
        textF.translatesAutoresizingMaskIntoConstraints = false
        return textF
    }()
    let emailSperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let passwordTextField: UITextField = {
        let textF = UITextField()
        textF.isSecureTextEntry = true
        textF.placeholder = "Password"
        textF.translatesAutoresizingMaskIntoConstraints = false
        return textF
    }()
    let passwordSperatorView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    let profileImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "angryBird")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.tintColor = .white
        return image
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        setupInputContainer()
        setupLoginRegisterButton()
        setupProfileImageView()
    }
    func setupProfileImageView() {
        // x, y, width and height constaints
        profileImageView.centerXAnchor.constraintEqualToSystemSpacingAfter(view.centerXAnchor, multiplier: 1).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    @objc func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Email or password are not correct")
            return}
        Auth.auth().createUser(withEmail: email, password: password) { (user: AuthDataResult?, error) in
                if error != nil {
                    print(error)
                    return
                }
            guard let uid = user?.user.uid else {return}
                // user authenticated
            print("user authenticated")
            let ref = Database.database().reference()
            let usersRef = ref.child("users").child(uid)
            let values: [String: Any] = ["name": name, "email": email]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print(err)
                    return
                }
                print("User inserted in Database")
            })
        }
    }
    func setupInputContainer() {
        // x, y, width and height constaints
        inputContainerView.centerXAnchor.constraintEqualToSystemSpacingAfter(view.centerXAnchor, multiplier: 1).isActive = true
        inputContainerView.centerYAnchor.constraintEqualToSystemSpacingBelow(view.centerYAnchor, multiplier: 1).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -24).isActive = true
        inputContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        // add subviews
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSperatorView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSperatorView)
        inputContainerView.addSubview(passwordTextField)
        inputContainerView.addSubview(passwordSperatorView)
        // x, y, width and height constaints for name
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        // add separator
        nameSperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        nameSperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        nameSperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        // x, y, width and height constaints for email
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameSperatorView.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        // add separator
        emailSperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        emailSperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        emailSperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        // x, y, width and height constaints for password
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSperatorView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1/3).isActive = true
        // add separator
        passwordSperatorView.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor).isActive = true
        passwordSperatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        passwordSperatorView.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
    }
    func setupLoginRegisterButton() {
        // x, y, width and height constaints
        loginRegisterButton.centerXAnchor.constraintEqualToSystemSpacingAfter(view.centerXAnchor, multiplier: 1).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: self.inputContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension UIColor {
    convenience init(r:CGFloat , g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
