//
//  PostListRemoteDataManager.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListRemoteDataManager:PostListRemoteDataManagerInputProtocol {

    private let limit = 10
    
    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        let endPoint = Endpoints.Posts.fetchAll(limit: limit)
        processRequest(with: endPoint.url)
    }
    
    func retrievePostListFromLastPost(with id: String) {
        let endPoint = Endpoints.Posts.fetchAllAfter(limit: limit, afterKey: id)
        processRequest(with: endPoint.url)
    }
    
    private func processRequest(with stringURL: String) {
        guard let urlRequest = URL(string: stringURL) else {
            remoteRequestHandler?.onError(.badURL)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let self = self else { return }
            if let _ = error {
                self.remoteRequestHandler?.onError(.networkConnection)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                self.remoteRequestHandler?.onError(.invalidResponse)
                return
            }
            guard let data = data else {
                self.remoteRequestHandler?.onError(.invalidData)
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(ResponseRequest.self, from: data)
                let posts = response.data.children.map{ $0.data }
                self.remoteRequestHandler?.onPostsRetrieved(posts)
            } catch {
                self.remoteRequestHandler?.onError(.invalidData)
            }
        }
        task.resume()
    }
    
}
