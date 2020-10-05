//
//  PostModel.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

struct PostModel {
    
    enum ReadStatus {
        case unknown
        case read
        case unreaded
    }
    
    enum Thumbnail  {
        case defaultImage
        case selfImage
        case image(url: URL)
    }
    
    let id: String
    let title: String
    let author: String
    let created: Date
    let thumbnail: Thumbnail
    let url: URL
    let numberComments: Int
    let readStatus: ReadStatus
    
    var createdTimeAgo: String {
        return created.relativeTime
    }
    
}

extension PostModel.Thumbnail: Hashable { }

extension PostModel: Hashable { }

extension PostModel: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case title = "title"
        case author = "author"
        case created = "created"
        case thumbnail = "thumbnail"
        case numberComments = "num_comments"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id =  try container.decode(String.self, forKey: .id)
        title =  try container.decode(String.self, forKey: .title)
        author =  try container.decode(String.self, forKey: .author)
        let entryUnixTime = try container.decode(Int.self, forKey: .created)
        created = Date(timeIntervalSince1970: TimeInterval(entryUnixTime))
        let urlString = try container.decode(String.self, forKey: .url)
        url = URL(string: urlString)!
        let thumbnailString = try container.decode(String.self, forKey: .thumbnail)
        switch thumbnailString {
        case "self":
            thumbnail = .selfImage
        case "default":
            thumbnail = .defaultImage
        default:
            thumbnail = .image(url: URL(string: thumbnailString)!)
        }
        numberComments = try container.decode(Int.self, forKey: .numberComments)
        readStatus = .unknown
    }
    
}
