//
//  Utilites.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 21/06/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import UIKit
class Utilites{
    
    func inputContainerView(withImage image: UIImage,textField: UITextField) -> UIView{
        let view = UIView()
        let imgView = UIImageView()
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imgView.image = image
        view.addSubview(imgView)
        
        imgView.anchor( left: view.leftAnchor, bottom: view.bottomAnchor,paddingLeft: 8, paddingBottom: 8, width: 24, height: 24)
        
        view.addSubview(textField)
        textField.anchor(left: imgView.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 8, paddingBottom: 8)
        let dividerView = UIView()
        dividerView.backgroundColor = .white
        view.addSubview(dividerView)
        dividerView.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor,height: 0.75)
        return view
        
    }
    
    func inputTextField(withPlaceholder placeholder:String) -> UITextField{
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .white
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        return textField
    }
    
    func attributedButton(_firstPart:String, _secondPart:String) -> UIButton{
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: _firstPart, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.white])
        
        
        attributedTitle.append(NSAttributedString(string: _secondPart, attributes: [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor : UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }
}
