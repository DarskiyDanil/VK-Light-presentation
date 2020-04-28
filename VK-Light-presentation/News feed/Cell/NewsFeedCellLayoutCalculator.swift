//
//  NewsFeedCellLayoutCalculator.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 25.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import UIKit

protocol NewsFeedCellLayoutCalculatorProtocol {
    func sizes (postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModelProtocol], isFullSizedPost: Bool) -> FeedCellSizes
}

struct  Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var postTextButtonFrame: CGRect
    var attachmentFrame: CGRect
    var bottomViewFrame: CGRect
    var totalHeightCell: CGFloat
}

final class NewsFeedCellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
        self.screenWidth = screenWidth
    }
    
    func sizes (postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModelProtocol], isFullSizedPost: Bool) -> FeedCellSizes {
        
        var showTextButtonTogle = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        //        MARK: вычисление postLabelFrame
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top), size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.heidht(width: width, font: Constants.postLabelFont)
            
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minimumLinesCountPostLimit
            
            if !isFullSizedPost && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minimumLinesCountPostPresent
                showTextButtonTogle = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        //        MARK: вычисление postTextButtonFrame
        var postTextButtonSize = CGSize.zero
        
        if showTextButtonTogle {
            postTextButtonSize = Constants.postTextButtonSize
        }
        
        let postTextButtonPosition = CGPoint(x: Constants.postLabelInsets.left, y: postLabelFrame.maxY)
        
        let postTextButtonFrame = CGRect(origin: postTextButtonPosition, size: postTextButtonSize)
        
        //        MARK: вычисление attachmentFrame
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attachment = photoAttachments.first {
            let photoHeight: Float = Float(attachment.height)
            let photoWight: Float = Float(attachment.width)
            let ratio = CGFloat(photoHeight / photoWight)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                //                подсчёт Layout через RowLayout.rowHeightCounter
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superViewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!) //!
            }
        }
        
        //        MARK: вычисление bottomViewFrame
        let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop), size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
        
        //        MARK: вычисление totalHeightCell
        let totalHeightCell = bottomViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     postTextButtonFrame: postTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     bottomViewFrame: bottomViewFrame,
                     totalHeightCell: totalHeightCell)
    }
    
}
