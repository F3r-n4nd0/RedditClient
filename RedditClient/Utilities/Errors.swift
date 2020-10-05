//
//  Errors.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation


enum RCErrorRemoteDataManager: Error {
    case badURL
    case networkConnection
    case invalidResponse
    case invalidData
}
