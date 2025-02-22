//
//  ViewController.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-04-03.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "new_message_icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewMessage))
        
        checkIfUserIsLoggedIn()
    }
    
    func handleNewMessage() {
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
    }

    func checkIfUserIsLoggedIn() {
        // User is not logged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
            handleLogout()
        } else {
            fetchUserAndSetupNavbarTitle()
        }
    }
    
    func fetchUserAndSetupNavbarTitle() {
        // No need for forceunwrapping
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        FIRDatabase.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
        if let dictionary = snapshot.value as? [String: Any] {
            let title = self.navigationItem.title
            self.navigationItem.title = dictionary["name"] as? String
            
//            let user = User()
//            user.setValuesForKeys(dictionary)
//            self.setupNavbarWithUser(user: user)
//            title.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showChatController)))

            
        }
            
        }, withCancel: nil)
    }

    func setupNavbarWithUser(user: User) {
        let titleView = UIView()

        self.navigationItem.titleView = titleView
        

    }
    
    func showChatController() {
        print(124)
//        let chatLogController = ChatLogController(collectionViewLayout: UICollectionViewFlowLayout())
//        navigationController?.pushViewController(chatLogController, animated: true)
    }

    func handleLogout() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutErr {
            print(logoutErr)
        }
        
        let loginController = LoginController()
        loginController.messageController = self
        present(loginController, animated: true, completion: nil)
        
    }
}

