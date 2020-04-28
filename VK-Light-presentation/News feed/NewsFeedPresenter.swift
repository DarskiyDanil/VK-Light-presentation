//
//  NewsFeedPresenter.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 21.04.2020.
//  Copyright (c) 2020  Данил Дарский. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol NewsFeedPresentationLogic {
    func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
    weak var viewController: NewsFeedDisplayLogic?
    //    выбирается меньшее расстояние между
    var cellLayoutCalculator: NewsFeedCellLayoutCalculatorProtocol = NewsFeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "d MMM 'в' HH:mm"
        return dateFormatter
    }()
    
    
    // MARK: Do present
    
    func presentData(response: NewsFeed.Model.Response.ResponseType) {
        
        switch response {
            
        case .presentNewsFeed(feed: let feed, let openedPostIds):
            let cells = feed.items.map { (feedItem) in
                //                cellViewModel(from: feedItem)
                cellViewModel(from: feedItem, profileNewsFeed: feed.profiles, groupNewsFeed: feed.groups, openedPostIds: openedPostIds)
            }
            
            let feedViewModel = FeedViewModel.init(cells: cells)
            
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        }
    }
    
    private func cellViewModel(from feedItem: ItemNewsFeed, profileNewsFeed: [ProfileNewsFeed], groupNewsFeed: [GroupNewsFeed], openedPostIds: [Int]) -> FeedViewModel.Cell {
        
        let profile = self.profileSource(for: feedItem.sourceId, profiles: profileNewsFeed, groups: groupNewsFeed)

        let photoAttachments =  self.photoAttachments(feedItem: feedItem)
        
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = openedPostIds.contains { (postId) -> Bool in
            postId == feedItem.postId
        }
        
        //        let isFullSized = openedPostIds.contains(feedItem.postId)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shares: String(feedItem.reposts?.count ?? 0),
                                       viewers: String(feedItem.views?.count ?? 0),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    private func profileSource(for sourceId: Int, profiles: [ProfileNewsFeed], groups: [GroupNewsFeed]) -> ProfilePresentable {
        let profilesOrGroup: [ProfilePresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profilePresentable = profilesOrGroup.first { (MyProfilePresentable) -> Bool in
            MyProfilePresentable.id == normalSourceId
        }
        //        guard profilePresentable != nil else {return 0 as! ProfilePresentable}
        return profilePresentable ?? 0 as! ProfilePresentable
    }
    
    //    private func photoAttachment (feedItem: ItemNewsFeed) -> FeedViewModel.FeedCellPhotoAttachment? {
    //        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
    //            attachment.photo
    //        }), let firstPhoto = photos.first else {
    //            return nil
    //        }
    //        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBig,
    //                                                          width: firstPhoto.width,
    //                                                          height: firstPhoto.height)
    //    }
    
    private func photoAttachments (feedItem: ItemNewsFeed) -> [FeedViewModel.FeedCellPhotoAttachment] {
        guard let attachments = feedItem.attachments else {return []}
        
        return attachments.compactMap { (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
            guard let photo = attachment.photo else {return nil}
            return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: photo.srcBig,
                                                              width: photo.width,
                                                              height: photo.height)
        }
    }
    
    
}







