//
//  Constant.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 22/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import Firebase

let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_image")

let DEB_REF = Database.database().reference()
let REF_USER = DEB_REF.child("users")
