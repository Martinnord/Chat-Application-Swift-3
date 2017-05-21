//
//  Extenstions.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-05-20.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit

// Cache
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadingImageUsingCacheWithUrlString(urlString: String) {
        
        // Blank out the images
        self.image = nil
        
        // checking for cached images
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // Otherwise
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            // If error, return out
            if error != nil {
                print(error!)
                return
            }
            
            // Success!
            DispatchQueue.main.async() {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                }
                
                
            }
            
        }).resume()
    }
}
