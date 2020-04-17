//
//  AllFriendCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import Kingfisher

class AllFriendCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static let idCell = "AllFriendCell"
    
    var cachedDataSorce: NSCache<AnyObject, UIImage> = {
        let cache = NSCache<AnyObject, UIImage>()
        return cache
    }()
    
    func configure(with friend: AllFriendCoreData) {
        guard let imageUrl = friend.imageUrl else {return}
        guard let firstName = friend.firstName else {return}
        guard let lastName = friend.lastName else {return}
        self.titleNameFriends.text = "\(firstName)  \(lastName)"
        let imageURL = URL(string: imageUrl)
        self.icon.kf.setImage(with: imageURL, placeholder: nil)
    }
    
    var icon: UIImageView = {
        var img = UIImageView()
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
        contentView.addSubview(icon)
        contentView.addSubview(titleNameFriends)
        DispatchQueue.main.async {
            self.anchorConstrains()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: настройки ячейки
    private func anchorConstrains() {
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
