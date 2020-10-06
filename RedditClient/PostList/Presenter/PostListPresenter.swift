//
//  PostListPresenter.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListPresenter: PostListPresenterProtocol {
  
    private var lastPostID: String?
    
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var routing: PostListRoutingProtocol?
    
    var posts: [PostModel] = []
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrievePostList()
    }
    
    func loadMorePost() {
        view?.showLoading()
        guard let lastPostID = lastPostID else {
            interactor?.retrievePostList()
            return
        }
        interactor?.retrievePostListFromLastPost(with: lastPostID)
    }
    
    func dismissPost(_ post: PostModel) {
        guard let index = posts.firstIndex(of: post)  else { return }
        posts.remove(at: index)
        view?.showPosts(with: self.posts)
    }
    
    func showPostDetail(forPost post: PostModel) {
        routing?.presentPostDetailScreen(from: view!, forPost: post)
    }
    
}

extension PostListPresenter: PostListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [PostModel]) {
        self.posts.append(contentsOf: posts)
        lastPostID = posts.last?.id
        view?.hideLoading()
        view?.showPosts(with: self.posts)
    }
    
    func onError(_ error: Error) {
        view?.hideLoading()
        switch error {
        case is RCErrorRemoteDataManager:
            view?.showError(message: "Invalid responce from the server. Please try again.")
        default:
            view?.showError(message: "Please try again")
        }
    }
    
}
