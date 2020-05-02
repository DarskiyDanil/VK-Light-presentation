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
    
    let picture: WebImageView = {
        var imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func configure(with friend: UrlPhotoCoreData) {
        guard let url = friend.url else {return}
        self.picture.set(imageUrl: url)   
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(picture)
        picture.fillSuperview()
    }
    
    
}
