//
//  NewsFeedCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 21.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

class NewsFeedCell: UITableViewCell {
    
    static let idCell = "NewsFeedCell"
    
    var icon: WebImageView = {
        var img = WebImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.layer.cornerRadius = 4
        img.backgroundColor = .orange
        return img
    }()
    
    var titleNameNews: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .yellow
        lbl.font = .systemFont(ofSize: 15)
        lbl.numberOfLines = 0
        return lbl
    }()
    var dateLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .green
        lbl.textColor = .systemBlue
        lbl.font = .systemFont(ofSize: 10)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    var postLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .yellow
        lbl.font = .systemFont(ofSize: 14)
        lbl.numberOfLines = 0
        return lbl
    }()
        
        var newsImage: WebImageView = {
            var img = WebImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.contentMode = .scaleAspectFit
            img.clipsToBounds = true
            img.backgroundColor = .red
            return img
        }()
    
    var likesLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .cyan
        lbl.font = .systemFont(ofSize: 11)
        return lbl
    }()
    
    var commentsLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .green
        lbl.font = .systemFont(ofSize: 11)
        return lbl
    }()
    
    var sharesLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .cyan
        lbl.font = .systemFont(ofSize: 11)
        return lbl
    }()
    
    var viewerLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.backgroundColor = .cyan
        lbl.font = .systemFont(ofSize: 11)
        return lbl
    }()
    
    var imageLikes: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .orange
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(systemName: "suit.heart")
        return img
    }()
    
    var imageComments: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .orange
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(systemName: "message")
        return img
    }()
    
    var imageShares: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .orange
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(systemName: "arrowshape.turn.up.right")
        return img
    }()
    
    var imageViewer: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = .orange
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
        img.image = UIImage(systemName: "eye")
        return img
    }()
    
    var topView: UIView = {
        var img = UIView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = #colorLiteral(red: 0.6470216513, green: 0.9037489295, blue: 0.9538292289, alpha: 1)
        img.clipsToBounds = true
        return img
    }()
    
var bottomView: UIView = {
    var img = UIView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    img.clipsToBounds = true
    return img
}()
    
    var cardView: UIView = {
        var img = UIView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = #colorLiteral(red: 0.9038797021, green: 0.765293777, blue: 0.8007944226, alpha: 1)
        img.clipsToBounds = true
        return img
    }()
    
    override func prepareForReuse() {
        icon.set(imageUrl: nil)
        newsImage.set(imageUrl: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
             anchorConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(viewModel: FeedCellViewModelProtocol) {
//        icon.set(imageUrl: viewModel.iconUrlString)
//        titleNameNews.text = viewModel.name
//        dateLabel.text = viewModel.date
//        postLabel.text = viewModel.text
//        likesLabel.text = viewModel.likes
//        commentsLabel.text = viewModel.comments
//        sharesLabel.text = viewModel.shares
//        viewerLabel.text = viewModel.viewers
//        
//        postLabel.frame = viewModel.sizes.postLabelFrame
//        newsImage.frame = viewModel.sizes.attachmentFrame
//        bottomView.frame = viewModel.sizes.bottomViewFrame
//        
//        if let photoAttachment = viewModel.photoAttachment {
//            self.newsImage.set(imageUrl: photoAttachment.photoUrlString)
//            self.newsImage.isHidden = false
//        } else {
//            self.newsImage.isHidden = true
//        }
    }
    
    //MARK: настройки ячейки
    private func anchorConstrains() {
        contentView.addSubview(cardView)
        
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        cardView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        cardView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        cardView.addSubview(topView)
        cardView.addSubview(icon)
        cardView.addSubview(titleNameNews)
        cardView.addSubview(dateLabel)
        cardView.addSubview(postLabel)
        cardView.addSubview(newsImage)
        
        cardView.addSubview(bottomView)
        cardView.addSubview(likesLabel)
        cardView.addSubview(commentsLabel)
        cardView.addSubview(sharesLabel)
        cardView.addSubview(viewerLabel)
        cardView.addSubview(imageLikes)
        cardView.addSubview(imageComments)
        cardView.addSubview(imageShares)
        cardView.addSubview(imageViewer)
        
        
        topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        topView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 4).isActive = true
        topView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -4).isActive = true
        topView.bottomAnchor.constraint(equalTo: postLabel.topAnchor, constant: -2).isActive = true
        
        icon.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        icon.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //текст
        titleNameNews.heightAnchor.constraint(equalToConstant: 25).isActive = true
        titleNameNews.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        titleNameNews.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5).isActive = true
        titleNameNews.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: titleNameNews.bottomAnchor, constant: 4).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 5).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
//        postLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 2).isActive = true
//        postLabel.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 4).isActive = true
//        postLabel.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -4).isActive = true
        
        newsImage.topAnchor.constraint(equalTo: postLabel.bottomAnchor, constant: 2).isActive = true
//        newsImage.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 4).isActive = true
//        newsImage.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -4).isActive = true
        newsImage.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -2).isActive = true
//        newsImage.centerXAnchor.constraint(equalTo: cardView.centerXAnchor, constant: 0).isActive = true
        
//        bottomView.topAnchor.constraint(equalTo: newsImage.bottomAnchor, constant: 2).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        bottomView.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 4).isActive = true
        bottomView.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -4).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor).isActive = true
        
        imageLikes.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageLikes.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageLikes.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 4).isActive = true
        imageLikes.centerYAnchor.constraint(equalTo: likesLabel.centerYAnchor, constant: 0).isActive = true
        
        likesLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        likesLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 4).isActive = true
        likesLabel.leftAnchor.constraint(equalTo: imageLikes.rightAnchor, constant: 1).isActive = true
        likesLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -4).isActive = true
        
        imageComments.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageComments.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageComments.leftAnchor.constraint(equalTo: likesLabel.rightAnchor, constant: 4).isActive = true
        imageComments.centerYAnchor.constraint(equalTo: commentsLabel.centerYAnchor, constant: 0).isActive = true
        
        commentsLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        commentsLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 4).isActive = true
        commentsLabel.leftAnchor.constraint(equalTo: imageComments.rightAnchor, constant: 1).isActive = true
        commentsLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -4).isActive = true
        
        imageShares.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageShares.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageShares.leftAnchor.constraint(equalTo: commentsLabel.rightAnchor, constant: 4).isActive = true
        imageShares.centerYAnchor.constraint(equalTo: sharesLabel.centerYAnchor, constant: 0).isActive = true
        
        sharesLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sharesLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 4).isActive = true
        sharesLabel.leftAnchor.constraint(equalTo: imageShares.rightAnchor, constant: 1).isActive = true
        sharesLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -4).isActive = true
        
        imageViewer.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageViewer.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageViewer.rightAnchor.constraint(equalTo: viewerLabel.leftAnchor, constant: -1).isActive = true
        imageViewer.centerYAnchor.constraint(equalTo: viewerLabel.centerYAnchor, constant: 0).isActive = true
        
        viewerLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        viewerLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 4).isActive = true
        viewerLabel.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -4).isActive = true
        viewerLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -4).isActive = true
    }
    
}
