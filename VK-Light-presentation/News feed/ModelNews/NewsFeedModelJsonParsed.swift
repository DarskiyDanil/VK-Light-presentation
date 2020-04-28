//
//  NewsFeedModelJsonParsed.swift
//  VK-Light-presentation
//
//  Created by  Данил Дарский on 20.04.2020.
//  Copyright © 2020  Данил Дарский. All rights reserved.
//

import Foundation

// MARK: - NewsFeedModelJsonParsed
struct NewsFeedModelJsonParsed: Codable {
    let response: ResponseNews
}

// MARK: - Response
struct ResponseNews: Codable {
    let items: [ItemNewsFeed]
    let profiles: [ProfileNewsFeed]
    let groups: [GroupNewsFeed]
    //    let nextFrom: String
    
    //    enum CodingKeys: String, CodingKey {
    //        case items
    
    //        case profiles
    //        case groups
    //        case nextFrom = "next_from"
    //    }
}

// MARK: - ItemNewsFeed
struct ItemNewsFeed: Codable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: Comments?
    let likes: Comments?
    let reposts: Comments?
    let views: Comments?
    let attachments: [AttachmentItem]?
    
    //    let canDoubtCategory, canSetCategory: Bool?
    //    let type: PostTypeEnum?
    //    let postType: PostTypeEnum?
    //    let markedAsAds: Int
    //
    //    let postSource: ItemPostSource?
    //    let copyright: Copyright?
    //    let isFavorite: Bool
    //    let copyHistory: [CopyHistory]?
    //    let topicID, signerID: Int?
    
    //    enum CodingKeys: String, CodingKey {
    //        case sourceId = "source_id"
    //        case date
    //         case text
    //        case comments
    //        case likes
    //        case reposts
    //        case views
    //        case postId = "post_id"
    
    //        case canDoubtCategory = "can_doubt_category"
    //        case canSetCategory = "can_set_category"
    //        case type
    //        case postType = "post_type"
    //        case markedAsAds = "marked_as_ads"
    //        case attachments
    //        case postSource = "post_source"
    //        case copyright
    //        case isFavorite = "is_favorite"
    //        case copyHistory = "copy_history"
    //        case topicID = "topic_id"
    //        case signerID = "signer_id"
    //    }
}

// MARK: Comments
struct Comments: Codable {
    let count: Int
    //    let canPost: Int
    //    let groupsCanPost: Bool?
    
    //    enum CodingKeys: String, CodingKey {
    //        case count
    
    //        case canPost = "can_post"
    //        case groupsCanPost = "groups_can_post"
    //    }
}

protocol ProfilePresentable {
    var id: Int { get }
    var name: String { get }
    var photo: String { get }
}

// MARK: - ProfileNewsFeed
struct ProfileNewsFeed: Codable, ProfilePresentable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo100: String
    var name: String { return firstName + "  " + lastName }
    var photo: String { photo100 }
    //    let isClosed: Bool?
    //    let canAccessClosed: Bool?
    //    let sex: Int
    //    let screenName: String?
    //    let photo50: String
    //    let online: Int
    //    let onlineInfo: OnlineInfo
    //    let onlineApp: Int?
    //    let onlineMobile: Int?
    //    let deactivated: String?
    
}

// MARK: - GroupNewsFeed
struct GroupNewsFeed: Codable, ProfilePresentable {
    let id: Int
    let name: String
    let photo100: String
    var photo: String { return photo100 }
    //    let screenName: String
    //    let isClosed: Int
    //    let type: GroupType
    //    let isAdmin, isMember, isAdvertiser: Int
    //    let photo200: String
}

// MARK: - AttachmentItem
struct AttachmentItem: Codable {
    //    let type: AttachmentType
    //    let video: AttachmentVideo?
    let photo: PhotoAttachment?
    //    let audio: Audio?
    //    let link: Link?
    //    let doc: Doc?
}

// MARK: - PhotoAttachment
struct PhotoAttachment: Codable {
    //    let id: Int
    let sizes: [PhotoSizes]
    var width: Int {
        return getPropperSize().width
    }
    var height: Int {
        return getPropperSize().height
    }
    var srcBig: String {
        return getPropperSize().url
    }
    
    private func getPropperSize() -> PhotoSizes {
        if let sizeX = sizes.first(where: {$0.type == "x"}) {
            return sizeX
        } else if let fallBackSize = sizes.last {
            return fallBackSize
        } else {
            return PhotoSizes(type: "нет картинки", url: "нет картинки", width: 0, height: 0)
        }
    }
    //    let albumID: Int
    //    let ownerID: Int
    //    let userID: Int
    //    let text: String
    //    let date: Int
    //    let postID: Int?
    //    let accessKey: String
}

// MARK: - PhotoSizes
struct PhotoSizes: Codable {
    let type: String
    let url: String
    let width: Int
    let height: Int
    //    let fileSize: Int?
    //    let withPadding: Int?
}

// MARK: - Audio
struct Audio: Codable {
    let artist: String
    let id, ownerID: Int
    let title: String
    let duration: Int
    let trackCode: String
    let url: String
    let date, albumID: Int
    let mainArtists: [MainArtist]?
    let lyricsID, genreID, noSearch: Int?
    
    enum CodingKeys: String, CodingKey {
        case artist, id
        case ownerID = "owner_id"
        case title, duration
        case trackCode = "track_code"
        case url, date
        case albumID = "album_id"
        case mainArtists = "main_artists"
        case lyricsID = "lyrics_id"
        case genreID = "genre_id"
        case noSearch = "no_search"
    }
}

// MARK: - MainArtist
struct MainArtist: Codable {
    let name: String
    let domain: String
    let id: String
}

// MARK: - Doc
struct Doc: Codable {
    let id, ownerID: Int
    let title: String
    let size: Int
    let ext: String
    let url: String
    let date, type: Int
    let preview: Preview
    let accessKey: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title, size, ext, url, date, type, preview
        case accessKey = "access_key"
    }
}

// MARK: - Preview
struct Preview: Codable {
    let photo: PreviewPhoto
    let video: PhotoSizes
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Codable {
    let sizes: [PhotoSizes]
}

enum SizeType: String, Codable {
    case d = "d"
    case i = "i"
    case k = "k"
    case l = "l"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Link
struct Link: Codable {
    let url: String
    let title, linkDescription: String
    let target: String?
    let previewArticle: PreviewArticle?
    let photo: LinkPhoto?
    let isFavorite: Bool
    let caption: String?
    let button: Button?
    
    enum CodingKeys: String, CodingKey {
        case url, title
        case linkDescription = "description"
        case target
        case previewArticle = "preview_article"
        case photo
        case isFavorite = "is_favorite"
        case caption, button
    }
}

// MARK: - Button
struct Button: Codable {
    let title: String
    let action: Action
}

// MARK: - Action
struct Action: Codable {
    let type: String
    let url: String
}

// MARK: - LinkPhoto
struct LinkPhoto: Codable {
    let id, albumID, ownerID: Int
    let sizes: [PhotoSizes]
    let text: String
    let date: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case albumID = "album_id"
        case ownerID = "owner_id"
        case sizes, text, date
    }
}

// MARK: - PreviewArticle
struct PreviewArticle: Codable {
    let id, ownerID: Int
    let ownerName: String
    let ownerPhoto: String
    let state: String
    let canReport: Bool
    let title, subtitle: String
    let views, shares: Int
    let isFavorite: Bool
    let url, viewURL: String
    let noFooter: Bool
    let accessKey: String
    let publishedDate: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case ownerName = "owner_name"
        case ownerPhoto = "owner_photo"
        case state
        case canReport = "can_report"
        case title, subtitle, views, shares
        case isFavorite = "is_favorite"
        case url
        case viewURL = "view_url"
        case noFooter = "no_footer"
        case accessKey = "access_key"
        case publishedDate = "published_date"
    }
}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case video = "video"
}

// MARK: - AttachmentVideo
struct AttachmentVideo: Codable {
    let accessKey: String
    let canComment, canLike, canRepost, canSubscribe: Int
    let canAddToFaves, canAdd, date: Int
    let videoDescription: String
    let duration: Int
    let image: [PhotoSizes]
    let firstFrame: [PhotoSizes]?
    let width, height, id, ownerID: Int
    let title, trackCode: String
    let type: AttachmentType
    let views: Int
    let comments, isPrivate, userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case canComment = "can_comment"
        case canLike = "can_like"
        case canRepost = "can_repost"
        case canSubscribe = "can_subscribe"
        case canAddToFaves = "can_add_to_faves"
        case canAdd = "can_add"
        case date
        case videoDescription = "description"
        case duration, image
        case firstFrame = "first_frame"
        case width, height, id
        case ownerID = "owner_id"
        case title
        case trackCode = "track_code"
        case type, views, comments
        case isPrivate = "is_private"
        case userID = "user_id"
    }
}

// MARK: - CopyHistory
struct CopyHistory: Codable {
    let id, ownerID, fromID, date: Int
    let postType: PostTypeEnum
    let text: String
    let attachments: [CopyHistoryAttachment]
    let postSource: CopyHistoryPostSource
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case fromID = "from_id"
        case date
        case postType = "post_type"
        case text, attachments
        case postSource = "post_source"
    }
}

// MARK: - CopyHistoryAttachment
struct CopyHistoryAttachment: Codable {
    let type: AttachmentType
    let link: Link?
    let photo: PhotoAttachment?
}

// MARK: - CopyHistoryPostSource
struct CopyHistoryPostSource: Codable {
    let type: PostSourceType
}

enum PostSourceType: String, Codable {
    case api = "api"
    case vk = "vk"
}

enum PostTypeEnum: String, Codable {
    case post = "post"
}

// MARK: - Copyright
struct Copyright: Codable {
    let id: Int
    let link: String
    let type, name: String
}

// MARK: - Likes
struct Likes: Codable {
    let count, userLikes, canLike, canPublish: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}

// MARK: - ItemPostSource
struct ItemPostSource: Codable {
    let type: PostSourceType
    let platform: String?
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}






