//
//  NewMessageController.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-04-28.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit

class NewMessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        
        
        
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
