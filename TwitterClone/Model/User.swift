//
//  User.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 11/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation

struct User {
    let fullName : String
    let email : String
    let userName : String
    var profileImageUrl : URL?
    let uid : String
    
    init(uid: String,dic: [String:Any]) {
        self.uid = uid
        self.fullName = dic["fullname"] as? String ?? ""
        self.email = dic["email"] as? String ?? ""
        self.userName = dic["username"] as? String ?? ""
        if let imageUrl = dic["profileImageUrl"] as? String{
            guard let url = URL(string: imageUrl) else { return }
            self.profileImageUrl = url
        }
     }
}
