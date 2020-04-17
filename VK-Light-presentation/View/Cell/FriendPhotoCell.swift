//
//  FriendPhotoCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit
import Kingfisher

class FriendPhotoCell: UICollectionViewCell {
    
    static let idCell = "FriendPhotoCell"
    
    func setupViews() {
        picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        picture.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        picture.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        picture.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    //    func configure(with friend: PhotoFriendParsedData) {
    //        let imageURL = URL(string: friend.sizes[0].url)
    ////        DispatchQueue.global(qos: .utility).async {
    //        self.picture.kf.setImage(with: imageURL, placeholder: nil)
    ////        }
    //    }
    
    func configure(with friend: UrlPhotoCoreData) {
        guard let url = friend.url else {return}
        let imageURL = URL(string: url)
        self.picture.kf.setImage(with: imageURL, placeholder: nil)
    }
    
    let picture: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(picture)
        DispatchQueue.main.async {
            self.setupViews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    
}
