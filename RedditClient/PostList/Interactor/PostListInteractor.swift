//
//  PostListInteractor.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListInteractor: PostListInteractorInputProtocol {

    weak var presenter: PostListInteractorOutputProtocol?
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol?
    
    func retrievePostList() {
        remoteDatamanager?.retrievePostList()
    }
    
    func retrievePostListFromLastPost(with id: String) {
        remoteDatamanager?.retrievePostListFromLastPost(with: id)
    }
    
}

extension PostListInteractor: PostListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [PostModel]) {
        presenter?.didRetrievePosts(posts)
    }
    
    func onError(_ error: RCErrorRemoteDataManager) {
        presenter?.onError(error)
    }
    
}
