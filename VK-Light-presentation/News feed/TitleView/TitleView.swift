//
//  TitleView.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 28.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit


protocol titleViewModelProtocol {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var textField = InsertableTextField()
    
    private var myAvatarView: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
//        image.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(myAvatarView)
        addSubview(textField)
        addConstraints()
    }
    
    func set(userViewModel: titleViewModelProtocol) {
        myAvatarView.set(imageUrl: userViewModel.photoUrlString)
    }
    
    func addConstraints() {
        //        myAvatarView constraints
        myAvatarView.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        myAvatarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4).isActive = true
        myAvatarView.heightAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        myAvatarView.widthAnchor.constraint(equalTo: textField.heightAnchor, multiplier: 1).isActive = true
        
        //        textField constraints
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        textField.trailingAnchor.constraint(equalTo: myAvatarView.leadingAnchor, constant: -8).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myAvatarView.layer.masksToBounds = true
        myAvatarView.layer.cornerRadius = myAvatarView.frame.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
