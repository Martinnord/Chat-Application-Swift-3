//
//  LoginController+Handlers.swift
//  chat-app
//
//  Created by Martin Nordström on 2017-05-08.
//  Copyright © 2017 Martin Nordström. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil {
                print(error as Any)
                return
            }
            guard let uid = user?.uid else {
                return
            }
            
            // Successfully authenticated user
            let imageName = UUID().uuidString // unique string
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            // No force unwrapp
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) { // Shitty quality lets goo
            
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        return
                    }

                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)
                    
                    }
                })
            }
        })
    }
    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: Any]) {
        // Successfully authenticated user
        let ref = FIRDatabase.database().reference(fromURL: "https://chat-app-575b3.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err as Any)
                return
            }
            self.messageController?.fetchUserAndSetupNavbarTitle()
//            self.messageController?.navigationItem.title = values["names"] as? String
//            let user = User()
            
            // If keys don't match it will crash
//            user.setValuesForKeys(values)
//            self.messageController?.setupNavbarWithUser(user: user)
            
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    // User picks a profile picture
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
        
            selectedImageFromPicker = editedImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
        
            selectedImageFromPicker = originalImage
            
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)

        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        print("canceled")
    }
    
}
