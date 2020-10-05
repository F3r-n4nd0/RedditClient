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
    
    func showPostDetail(forPost post: PostModel) {
        routing?.presentPostDetailScreen(from: view!, forPost: post)
    }
    
}

extension PostListPresenter: PostListInteractorOutputProtocol {
    
    func didRetrievePosts(_ posts: [PostModel]) {
        view?.hideLoading()
        view?.showPosts(with: posts)
        lastPostID = posts.last?.id
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
