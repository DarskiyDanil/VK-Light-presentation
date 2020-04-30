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
                
                cellViewModel(from: feedItem, profileNewsFeed: feed.profiles, groupNewsFeed: feed.groups, openedPostIds: openedPostIds)
            }
            
//            надпись при загрузке предыдущих новостей
            let footerTitle = String.localizedStringWithFormat(NSLocalizedString("NewsFeed Cels Count", comment: ""), cells.count)
            let feedViewModel = FeedViewModel.init(cells: cells, footerTitle: footerTitle)
            
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
        case .presentUserPhoto(user: let user):
            let userViewModel = UserViewModel.init(photoUrlString: user?.photo100)
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayUser(userViewModel: userViewModel))
        
        case .presentFooterLoader:
            viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayFooterLoader)
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
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
        
        let postText = feedItem.text?.replacingOccurrences(of: "<br>", with: "\n")
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: postText,
                                       likes: formatCount(feedItem.likes?.count),
                                       comments: formatCount(feedItem.comments?.count),
                                       shares: formatCount(feedItem.reposts?.count),
                                       viewers: formatCount(feedItem.views?.count),
                                       photoAttachments: photoAttachments,
                                       sizes: sizes)
    }
    
    private func formatCount (_ count: Int?) -> String? {
        guard let counter = count, counter > 0 else {return nil}
        var counterString = String(counter)
        if 4...6 ~= counterString.count {
            let dropFirstLast = counterString
            
            switch counterString.count {
            case 6:
                counterString = String(counterString.dropLast(3)) + "," + dropFirstLast.dropFirst(3).dropLast(2) + "K"
            case 5:
                counterString = String(counterString.dropLast(3)) + "," + dropFirstLast.dropFirst(2).dropLast(2) + "K"
            case 4:
                counterString = String(counterString.dropLast(3)) + "," + dropFirstLast.dropFirst(1).dropLast(2) + "K"
            default: break
            }
            
        } else if counterString.count > 6 {
            counterString = String(counterString.dropLast(6)) + "M"
        }
        return counterString
    }
    
    private func profileSource(for sourceId: Int, profiles: [ProfileNewsFeed], groups: [GroupNewsFeed]) -> ProfilePresentable {
        let profilesOrGroup: [ProfilePresentable] = sourceId >= 0 ? profiles : groups
        let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
        let profilePresentable = profilesOrGroup.first { (MyProfilePresentable) -> Bool in
            MyProfilePresentable.id == normalSourceId
        }
        return profilePresentable ?? 0 as! ProfilePresentable
    }
    
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








