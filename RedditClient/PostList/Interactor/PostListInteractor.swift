//
//  PostListInteractor.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListInteractor: PostListInteractorInputProtocol {
    
    private var lastPostID: String?
    private var posts: [PostModel] = []
    
    weak var presenter: PostListInteractorOutputProtocol?
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol?
    var localDatamanager: PostListLocalDataManagerInputProtocol?
    
    func retrievePostList() {
        guard let lastPostID = lastPostID else {
            remoteDatamanager?.retrievePostList()
            return
        }
        remoteDatamanager?.retrievePostListFromLastPost(with: lastPostID)
    }
    
    func dismissPost(_ post: PostModel) {
        guard let index = posts.firstIndex(of: post)  else { return }
        posts.remove(at: index)
        presenter?.didRetrievePosts(posts)
    }
    
    func dismissAll() {
        posts = []
        presenter?.didRetrievePosts(posts)
    }
    
}

extension PostListInteractor: PostListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [PostModel]) {
        lastPostID = posts.last?.id
        self.posts.append(contentsOf: posts)
        presenter?.didRetrievePosts(self.posts)
    }
    
    func onError(_ error: RCErrorRemoteDataManager) {
        presenter?.onError(error)
    }
    
}
