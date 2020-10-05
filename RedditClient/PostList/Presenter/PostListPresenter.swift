//
//  PostListPresenter.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import Foundation

class PostListPresenter: PostListPresenterProtocol {
    
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var routing: PostListRoutingProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrievePostList()
    }
    
    func showPostDetail(forPost post: PostModel) {
        routing?.presentPostDetailScreen(from: view!, forPost: post)
    }
    
}

extension PostListPresenter: PostListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [PostModel]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
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
