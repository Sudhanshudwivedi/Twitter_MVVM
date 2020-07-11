//
//  UsersService.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 28/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import Firebase
struct UsersService {
    static let shared = UsersService()
    
    func fetchUser(completion : @escaping(User)->Void){
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        REF_USER.child(uid).observeSingleEvent(of: .value) { (snapshot) in
            print("DEBUG : Snapshot is \(snapshot)")
            
            guard let userInfo = snapshot.value as? [String : Any] else { return}
            let user = User(uid: uid, dic: userInfo)
            
            completion(user)
        }
    }
}
