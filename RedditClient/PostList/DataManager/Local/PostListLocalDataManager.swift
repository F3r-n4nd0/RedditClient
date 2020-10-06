//
//  PostListLocalDataManager.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListLocalDataManager: PostListLocalDataManagerInputProtocol {
    
    enum Keys { static let postsIDs = "postsID" }
    
    func retrieveReadIdPosts() throws -> [String]  {
        guard let encodeData = UserDefaults.standard.object(forKey: Keys.postsIDs) as? Data else {
            throw RCPersistenceError.objectNotFound
        }
        do {
            let decoder = JSONDecoder()
            let postsIds = try decoder.decode([String].self, from: encodeData)
            return postsIds
        } catch {
            throw RCPersistenceError.objectNotFound
        }
    }
    
    func saveReadIdPosts(ids: [String]) throws {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(ids)
            UserDefaults.standard.setValue(encodedData, forKey: Keys.postsIDs)
            UserDefaults.standard.synchronize()
        } catch {
            throw RCPersistenceError.couldNotSaveObject
        }
    }
    
}
