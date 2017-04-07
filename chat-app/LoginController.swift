//
//  LoginController.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-04-03.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 151, b: 151)
        
        let inputViewController = UIView()
        inputViewController.backgroundColor = UIColor.white
        inputViewController.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(inputViewController)
        
        // Adds the constrains:
        // Sets the X, Y, width and height to be center of view
        inputViewController.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputViewController.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputViewController.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputViewController.heightAnchor.constraint(equalToConstant: 150).isActive = true
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
