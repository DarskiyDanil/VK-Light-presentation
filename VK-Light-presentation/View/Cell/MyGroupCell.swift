//
//  MyGroupCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class MyGroupCell: UITableViewCell {
    
    static let idCell = "AllGroupsCell"
    
    var icon: WebImageView = {
        var img = WebImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 6
        return img
    }()
    
    var titleNameFriends: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func prepareForReuse() {
        self.icon.set(imageUrl: nil)
    }
    
    func configure(with friend: AllGroupCoreData) {
        guard let imageUrl = friend.imageUrl else {return}
        self.titleNameFriends.text = friend.name
        self.icon.set(imageUrl: imageUrl)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        DispatchQueue.main.async {
            self.anchorConstrains()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func anchorConstrains() {
        addSubview(icon)
        addSubview(titleNameFriends)
        
        icon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //текст
        titleNameFriends.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        titleNameFriends.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleNameFriends.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        titleNameFriends.rightAnchor.constraint(equalTo: rightAnchor, constant: -15).isActive = true
    }
    
}
