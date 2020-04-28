//
//  FriendPhotoCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 02.01.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class FriendPhotoCell: UICollectionViewCell {
    
    static let idCell = "FriendPhotoCell"
    
    
    func configure(with friend: UrlPhotoCoreData) {
        guard let url = friend.url else {return}
        self.picture.set(imageUrl: url)
    }
    
    let picture: WebImageView = {
        var imageView = WebImageView()
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
    
    override func prepareForReuse() {
        self.picture.set(imageUrl: nil)
    }
    
    func setupViews() {
        picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        picture.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        picture.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        picture.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        picture.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
    }
    
    
}
