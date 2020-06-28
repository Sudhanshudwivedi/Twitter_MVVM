//
//  LoginController.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 21/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import UIKit

class LoginController:UIViewController{
    
    //MARK: Properties
    private let logoImageView:UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = #imageLiteral(resourceName: "TwitterLogo")
        return imgView
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
    
    private lazy var passwordTextField : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var emailTextField : UITextField = {
        let textField = Utilites().inputTextField(withPlaceholder: "Email")
        return textField
    }()
    
    private lazy var loginButton : UIButton = {
        let button  = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.twitterBlue, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(loginButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var donthaveAccountButton : UIButton = {
        let button = Utilites().attributedButton(_firstPart: "Don't have an account?", _secondPart: " Sign Up")
        button.addTarget(self, action: #selector(donthaveAccountTap), for: .touchUpInside)
        return button
    }()
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: Selectors
    
    @objc func loginButtonTap(){
        guard let email = emailTextField.text ,let password = passwordTextField.text else {return}
        AuthService.sharedInstance.loginUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                print("Debug : Error in login due to \(error.localizedDescription)")
                return
            }
            
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            guard let tab  = window?.rootViewController as? MainTabBarController else { return}
            
            tab.authenticateUserAndConfigureUI()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    @objc func donthaveAccountTap(){
        let viewController = SignupController()
        navigationController?.pushViewController(viewController, animated: true)
        print("Debug:LoginController - don't have account tap")
    }
    
    //MARK: Helpers
    
    func configureUI(){
        view.backgroundColor = .twitterBlue
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stack = UIStackView(arrangedSubviews: [emailContainerView,passwordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor,right: view.rightAnchor,paddingLeft: 32,paddingRight: 32)
        view.addSubview(donthaveAccountButton)
        donthaveAccountButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
    }
}
