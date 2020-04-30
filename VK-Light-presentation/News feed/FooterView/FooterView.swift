//
//  FooterView.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 30.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class FooterView: UIView {
    
    fileprivate var myLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate var loader: UIActivityIndicatorView = {
        var loader = UIActivityIndicatorView()
        loader.hidesWhenStopped = true
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(myLabel)
        addSubview(loader)
        
        myLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        myLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        myLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 8).isActive = true
    }
    
    func showLoader() {
        loader.startAnimating()
    }
    
    func setTitle(_ title: String?) {
        
        loader.stopAnimating()
        myLabel.text = title
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
