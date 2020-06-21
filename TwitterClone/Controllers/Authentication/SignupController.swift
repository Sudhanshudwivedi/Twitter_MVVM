//
//  SignupController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 21/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class SignupController : UIViewController{
    //MARK:Properties
    
    
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
        print("Debug:SignupController - registrationButtontap")
    }
    
    @objc func plusPhotoButtonTap(){
        print("Debug:SignupController - plusPhotoButtonTap")
    }
    
    //MARK:Helpers
    func configureUI(){
        
        view.backgroundColor  = .twitterBlue
        view.addSubview(donthaveAccountButton)
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView:view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        donthaveAccountButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.bottomAnchor, paddingBottom: 40)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,fullNameContainerView,userNameContainerView,registrationButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
    }
}
