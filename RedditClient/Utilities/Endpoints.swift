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
        case fetchAllAfter(limit: Int, afterKey: String)
        
        public var path: String {
            switch self {
            case .fetchAll(let limit):
                return "/r/all/top/.json?t=all&limit=\(limit)"
            case .fetchAllAfter(let limit, let afterKey):
                return "/r/all/top/.json?t=all&limit=\(limit)&after=\(afterKey)"
            }
        }
        
        public var url: String {
            switch self {
            case .fetchAll,.fetchAllAfter:
                return "\(API.baseUrl)\(path)"
            }
        }
        
    }
    
}
