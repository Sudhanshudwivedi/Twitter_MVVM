//
//  AuthService.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 28/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct AuthCredentials{
    let email : String
    let password : String
    let fullname : String
    let username : String
    let profileImage : UIImage
}
struct AuthService {
    static let sharedInstance = AuthService()
    
    
    func loginUser(withEmail email : String,password : String ,completion : AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    func registerUser(credentials : AuthCredentials,completion : @escaping(Error?,DatabaseReference) -> Void){
        let email = credentials.email
        let password = credentials.password
        let fullname = credentials.fullname
        let username = credentials.username
        let profileImage = credentials.profileImage
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        let fileName = NSUUID().uuidString
        
        let storage_Ref = STORAGE_PROFILE_IMAGE.child(fileName)
        
        storage_Ref.putData(imageData, metadata: nil) { (data, error) in
            storage_Ref.downloadURL { (URL, error) in
                guard let profileImageUrl = URL?.absoluteString else { return }
                
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if let error = error{
                        print("Debug:\(error.localizedDescription)")
                        return
                    }
                    
                    guard let uid = result?.user.uid else {return}
                    let values = ["email":email,"username":username,"fullname":fullname,"profileImageUrl":profileImageUrl]
                    
                    REF_USER.child(uid).updateChildValues(values, withCompletionBlock: completion)

                }

            }
        }
    }
}
