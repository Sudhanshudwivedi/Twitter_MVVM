//
//  CaptionTextView.swift
//  TwitterClone
//
//  Created by Sudhanshu-Air on 11/07/20.
//  Copyright © 2020 Sudhanshu-Air. All rights reserved.
//

import Foundation
import UIKit
class CaptionTextView : UITextView{
    
    //MARK:-Properties
     let placeholderLabel :UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.text  = "what's happening?"
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    //MARK:-LifeCycle

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled  = false
        heightAnchor.constraint(equalToConstant: 300).isActive = true
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top:topAnchor,left: leftAnchor,paddingTop: 8,paddingLeft: 4)
        NotificationCenter.default.addObserver(self, selector: #selector(handleInputTextChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-Helper
    @objc func handleInputTextChange(){
        self.placeholderLabel.isHidden = !text.isEmpty
    }
    
}
