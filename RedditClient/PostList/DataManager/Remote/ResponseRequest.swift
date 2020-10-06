//
//  ResponseRequest.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

struct ResponseRequest: Decodable {
    let data: DataRequest
}

struct DataRequest: Decodable {
    let children: [Children]
}

struct Children: Decodable {
    let data: PostModel
}
