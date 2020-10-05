//
//  Endpoints.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

struct API {
    static let baseUrl = "https://www.reddit.com"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Posts: Endpoint {
        case fetchAll(limit: Int)
        public var path: String {
            switch self {
            case .fetchAll(let limit):
                return "/r/all/top/.json?t=all&limit=\(limit)"
            }
        }
        public var url: String {
            switch self {
            case .fetchAll:
                return "\(API.baseUrl)\(path)"
            }
        }
    }
    
}
