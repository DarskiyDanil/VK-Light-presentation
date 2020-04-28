//
//  AllFriendCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class AllFriendCell: UITableViewCell {
    
override func prepareForReuse() {
    self.icon.set(imageUrl: nil)
}
    
    static let idCell = "AllFriendCell"
    
    func configure(with friend: AllFriendCoreData) {
        guard let imageUrl = friend.imageUrl else {return}
        guard let firstName = friend.firstName else {return}
        guard let lastName = friend.lastName else {return}
        self.titleNameFriends.text = "\(firstName)  \(lastName)"
        self.icon.set(imageUrl: imageUrl)
    }
    
    var icon: WebImageView = {
        var img = WebImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 4
        return img
    }()
    
    var titleNameFriends: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        //        lbl.text = "Имя Фамилия"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        DispatchQueue.main.async {
            self.anchorConstrains()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: настройки ячейки
    private func anchorConstrains() {
        
        contentView.addSubview(icon)
        contentView.addSubview(titleNameFriends)
        
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 1).isActive = true
        icon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        //текст
        titleNameFriends.centerYAnchor.constraint(equalTo: icon.centerYAnchor).isActive = true
        titleNameFriends.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 15).isActive = true
        titleNameFriends.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
    }
    
}
