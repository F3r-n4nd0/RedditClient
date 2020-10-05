//
//  PostListRemoteDataManager.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListRemoteDataManager:PostListRemoteDataManagerInputProtocol {

    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        let endPoint = Endpoints.Posts.fetchAll(limit: 10)
        guard let urlRequest = URL(string: endPoint.url) else {
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
