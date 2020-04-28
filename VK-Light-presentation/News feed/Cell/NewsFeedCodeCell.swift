//
//  NewsFeedCodeCell.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 25.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

protocol FeedCellViewModelProtocol {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var viewers: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModelProtocol] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var bottomViewFrame: CGRect { get }
    var totalHeightCell : CGFloat { get }
    var postTextButtonFrame : CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModelProtocol {
    var photoUrlString: String? { get }
    var width: Int { get }
    var height: Int { get }
}

protocol NewsFeedCodeCellDelegate: class {
    func openPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let idCell = "NewsFeedCodeCell"
    weak var delegate: NewsFeedCodeCellDelegate?
    //    первый слой
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //    второй слой
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = Constants.postLabelFont
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let postButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("раскрыть текст...", for: .normal)
        return button
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let newsImage: WebImageView = {
        let image = WebImageView()
        return image
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    //     третий слой на topView
    let icon: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = Constants.topVewHeight / 2
        return image
    }()
    
    let titleNameNews: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 15, weight: .medium)
        lbl.numberOfLines = 0
        return lbl
    }()
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        lbl.font = .systemFont(ofSize: 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    //       третий слой на bottomView
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //       четвёртый слой на bottomView
    let likesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "suit.heart")
        image.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return image
    }()
    
    let commentsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "message")
        image.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return image
    }()
    
    let sharesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "arrowshape.turn.up.right")
        image.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return image
    }()
    
    let viewerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "eye")
        image.tintColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        return image
    }()
    
    var likesLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    var commentsLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    var sharesLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    var viewerLabel: UILabel = {
        var lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.lineBreakMode = .byClipping
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        postButton.addTarget(self, action: #selector(postButtonTouch), for: .touchUpInside)
        
        overlayFirstLayer()  // первый слой
        overlaySecondLayer() // второй слой
        overlayThirdLayerOnTopView() // третий слой на topView
        overlayThirdLayerOnbottomView() // третий слой на bottomView
        overlayFourthLayerOnbottomView() // четвёртый слой на bottomView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        icon.set(imageUrl: nil)
        newsImage.set(imageUrl: nil)
    }
    
    @objc func postButtonTouch() {
        delegate?.openPost(for: self)
    }
    
    func set(viewModel: FeedCellViewModelProtocol) {
        icon.set(imageUrl: viewModel.iconUrlString)
        titleNameNews.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewerLabel.text = viewModel.viewers
        
        postLabel.frame = viewModel.sizes.postLabelFrame
        
        bottomView.frame = viewModel.sizes.bottomViewFrame
        postButton.frame = viewModel.sizes.postTextButtonFrame
        
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            newsImage.set(imageUrl: photoAttachment.photoUrlString)
            newsImage.isHidden = false
            galleryCollectionView.isHidden = true
            newsImage.frame = viewModel.sizes.attachmentFrame
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            newsImage.isHidden = true
            galleryCollectionView.isHidden = false
            galleryCollectionView.set(photos: viewModel.photoAttachments)
        } else {
            newsImage.isHidden = true
            galleryCollectionView.isHidden = true
        }
        
    }
    
    //MARK: constraints
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(topView)
        cardView.addSubview(postLabel)
        cardView.addSubview(postButton)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(newsImage)
        cardView.addSubview(bottomView)
        
        //        topView constraints
        topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 4).isActive = true
        topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -4).isActive = true
        topView.topAnchor.constraint(equalTo: cardView.topAnchor,constant: 4).isActive = true
        topView.heightAnchor.constraint(equalToConstant: Constants.topVewHeight).isActive = true
        //        postLabel constraints динамически
        //        postLabel constraints
        
        
        //        newsImage constraints динамически
        //        bottomView constraints динамически
    }
    
    private func overlayThirdLayerOnTopView() {
        topView.addSubview(icon)
        topView.addSubview(titleNameNews)
        topView.addSubview(dateLabel)
        
        //        icon constraints
        icon.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0).isActive = true
        icon.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 0).isActive = true
        icon.widthAnchor.constraint(equalToConstant: Constants.topVewHeight).isActive = true
        icon.heightAnchor.constraint(equalToConstant: Constants.topVewHeight).isActive = true
        
        //        titleNameNews constraints
        titleNameNews.heightAnchor.constraint(equalToConstant: Constants.topVewHeight / 2 - 2).isActive = true
        titleNameNews.topAnchor.constraint(equalTo: topView.topAnchor, constant: 2).isActive = true
        titleNameNews.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4).isActive = true
        titleNameNews.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -4).isActive = true
        
        //        dateLabel constraints
        dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -2).isActive = true
    }
    
    private func overlayThirdLayerOnbottomView() {
        
        bottomView.addSubview(likesView)
        bottomView.addSubview(commentsView)
        bottomView.addSubview(sharesView)
        bottomView.addSubview(viewersView)
        
        //        likesView constraints
        likesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        likesView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 6).isActive = true
        likesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
        likesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        
        //        commentsView constraints
        commentsView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        commentsView.leadingAnchor.constraint(equalTo: likesView.trailingAnchor).isActive = true
        commentsView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
        commentsView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        
        //        sharesView constraints
        sharesView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        sharesView.leadingAnchor.constraint(equalTo: commentsView.trailingAnchor).isActive = true
        sharesView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
        sharesView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        
        //        viewersView constraints
        viewersView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        viewersView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -6).isActive = true
        viewersView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewWidth).isActive = true
        viewersView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight).isActive = true
        
    }
    
    private func overlayFourthLayerOnbottomView() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)
        
        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)
        
        viewersView.addSubview(viewerImage)
        viewersView.addSubview(viewerLabel)
        
        //        likesView constraints
        helpingFourthLayer(view: likesView, imageView: likesImage, label: likesLabel)
        //        commentsView constraints
        helpingFourthLayer(view: commentsView, imageView: commentsImage, label: commentsLabel)
        //        sharesView constraints
        helpingFourthLayer(view: sharesView, imageView: sharesImage, label: sharesLabel)
        //        viewersView constraints
        helpingFourthLayer(view: viewersView, imageView: viewerImage, label: viewerLabel)
        
    }
    
    private func helpingFourthLayer(view: UIView, imageView: UIImageView, label: UILabel) {
        //        imageView constraints
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
        
        //        label constraints
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 2).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2).isActive = true
    }
    
    
    
    
}
