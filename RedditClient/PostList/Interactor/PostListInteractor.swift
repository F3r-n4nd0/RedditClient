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
    private var readPostsID: [String] = []
    
    weak var presenter: PostListInteractorOutputProtocol?
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol?
    var localDatamanager: PostListLocalDataManagerInputProtocol?
    
    func retrievePostList() {
        guard let lastPostID = lastPostID else {
            loadFirstTime()
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
    
    func markAsRead(_ post: PostModel) {
        guard let index = posts.firstIndex(of: post)  else { return }
        readPostsID.append(post.id)
        posts[index].readStatus = .read
        presenter?.didRetrievePosts(posts)
    }
    
    private func loadFirstTime() {
        remoteDatamanager?.retrievePostList()
        do {
            guard let postdIds = try localDatamanager?.retrieveReadIdPosts() else { return }
            readPostsID = postdIds
        } catch {
            print(error)
        }
    }
    
}

extension PostListInteractor: PostListRemoteDataManagerOutputProtocol {
    
    func onPostsRetrieved(_ posts: [PostModel]) {
        lastPostID = posts.last?.id
        for var post in posts {
            post.readStatus = readPostsID.contains(post.id) ? .read : .unread
            self.posts.append(post)
        }
        presenter?.didRetrievePosts(self.posts)
    }
    
    func onError(_ error: RCErrorRemoteDataManager) {
        presenter?.onError(error)
    }
    
}
