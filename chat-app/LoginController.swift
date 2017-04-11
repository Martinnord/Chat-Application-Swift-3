//
//  LoginController.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-04-03.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 65, g: 67, b: 103)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    func handleRegister() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text, let name = nameTextfield.text else{
            print("Form not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // SUCCESS
            var ref: FIRDatabaseReference!
            ref = FIRDatabase.database().reference(fromURL: "https://chat-app-575b3.firebaseio.com/")
            let usersRef = ref.child("users").child(uid)
            let values = ["name": name, "email": email]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err)
                    return
                }
                
                print("Saved user into Firebase DB")
            })

            
            
        })
        
        print(123)
    }
    
    let nameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let nameSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 200)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let emailTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailSeparator: UIView = {
        let separator = UIView()
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 200)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    let passwordTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    // TODO: ADD A LOGO
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 36, g: 41, b: 80)
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        
        setupContainerView()
        setupLoginRegisterButton()
    }

    func setupContainerView() {
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        inputsContainerView.addSubview(nameTextfield)
        inputsContainerView.addSubview(nameSeparator)
        inputsContainerView.addSubview(emailTextfield)
        inputsContainerView.addSubview(emailSeparator)
        inputsContainerView.addSubview(passwordTextfield)
        
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        nameTextfield.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextfield.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextfield.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextfield.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        nameSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeparator.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive = true
        nameSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        emailTextfield.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextfield.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor).isActive = true
        emailTextfield.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextfield.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        emailSeparator.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparator.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive = true
        emailSeparator.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        passwordTextfield.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextfield.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        
    }
    
    func setupLoginRegisterButton() {
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// No need to divide it with 255 anymore
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
