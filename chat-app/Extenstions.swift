//
//  Extenstions.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-05-20.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadingImageUsingCacheWithUrlString(urlString: String) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            // If error, return out
            if error != nil {
                print(error!)
                return
            }
            
            // Success!
            DispatchQueue.main.async() {
                self.image = UIImage(data: data!)
            }
            
        }).resume()
    }
}
