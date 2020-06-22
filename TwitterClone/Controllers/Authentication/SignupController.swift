//
//  SignupController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 21/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit
import Firebase

class SignupController : UIViewController{
    //MARK:Properties
    
    private let imagePicker = UIImagePickerController()
    private var profileImage: UIImage?
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.addTarget(self, action: #selector(plusPhotoButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var emailContainerView : UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilites().inputContainerView(withImage: image, textField: emailTextField)
        return view
    }()
    
    private lazy var passwordContainerView :UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilites().inputContainerView(withImage: image, textField: passwordTextField)
        return view
    }()
    
    private lazy var fullNameContainerView :UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilites().inputContainerView(withImage: image, textField: fullNameTextfield)
        return view
    }()
    
    private lazy var userNameContainerView :UIView = {
        let image = #imageLiteral(resourceName: "ic_person_outline_white_2x")
        let view = Utilites().inputContainerView(withImage: image, textField: userNameTextfield)
        return view
    }()
    
    private lazy var passwordTextField : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Email")
        return textField
    }()
    
    private lazy var fullNameTextfield : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Full Name")
        return textField
    }()
    
    private lazy var userNameTextfield : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Username")
        return textField
    }()
    
    
    
    private lazy var registrationButton : UIButton = {
        let button  = UIButton(type: .system)
        button.setTitle("SignUp", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(registrationButtonTap), for: .touchUpInside)
        return button
    }()
    
    
    
    private lazy var donthaveAccountButton : UIButton = {
        let button = Utilites().attributedButton(_firstPart: "Already have an account?", _secondPart: " Login In")
        button.addTarget(self, action: #selector(donthaveAccountTap), for: .touchUpInside)
        return button
    }()
    
    //MARK:LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    //MARK:Selectors
    
    @objc func donthaveAccountTap(){
        print("Debug:SignupController - donthaveAccountTap")
        navigationController?.popViewController(animated: true)
    }
    
    @objc func registrationButtonTap(){
        guard let profileImage = profileImage else {return}
        guard let email = emailTextField.text else { return}
        guard let password = passwordTextField.text else {return}
        guard let username = userNameTextfield.text else {return}
        guard let fullname = fullNameTextfield.text else {return}
        
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
                    
                    REF_USER.child(uid).updateChildValues(values) { (error, ref) in
                        
                        print("Debug:Sucessfully registered")
                        
                    }
                }

            }
        }
        
    }
    
    @objc func plusPhotoButtonTap(){
        present(imagePicker,animated: true)
    }
    
    //MARK:Helpers
    func configureUI(){
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        view.backgroundColor  = .twitterBlue
        view.addSubview(donthaveAccountButton)
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView:view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        donthaveAccountButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 35)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullNameContainerView,userNameContainerView,registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
    }
}

extension SignupController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else{return}
        self.profileImage = profileImage
        plusPhotoButton.layer.cornerRadius = 128/2
        plusPhotoButton.layer.masksToBounds  = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
