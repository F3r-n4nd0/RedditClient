//
//  PostListProtocols.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

protocol PostListViewProtocol: class {
    var presenter: PostListPresenterProtocol? { get set }
    func showPosts(with posts: [PostModel])
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol PostListRoutingProtocol: class {
    static func createPostListModule() -> UIViewController
    func presentPostDetailScreen(from view: PostListViewProtocol, forPost post: PostModel)
}

protocol PostListPresenterProtocol: class {
    var view: PostListViewProtocol? { get set }
    var interactor: PostListInteractorInputProtocol? { get set }
    var routing: PostListRoutingProtocol? { get set }
    func viewDidLoad()
    func loadMorePost()
    func showPostDetail(forPost post: PostModel)
    func dismissPost(_ post: PostModel)
    func dismissAll()
}

protocol PostListInteractorOutputProtocol: class {
    func didRetrievePosts(_ posts: [PostModel])
    func onError(_ error: Error)
}

protocol PostListInteractorInputProtocol: class {
    var presenter: PostListInteractorOutputProtocol? { get set }
    var remoteDatamanager: PostListRemoteDataManagerInputProtocol? { get set }
    var localDatamanager: PostListLocalDataManagerInputProtocol? { get set }
    func retrievePostList()
    func dismissPost(_ post: PostModel)
    func dismissAll()
    func markAsRead(_ post: PostModel)
}

protocol PostListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol? { get set }
    func retrievePostList()
    func retrievePostListFromLastPost(with id: String)
}

protocol PostListRemoteDataManagerOutputProtocol: class {
    func onPostsRetrieved(_ posts: [PostModel])
    func onError(_ error: RCErrorRemoteDataManager)
}

protocol PostListLocalDataManagerInputProtocol: class {
    func retrieveReadIdPosts() throws -> [String]
    func saveReadIdPosts(ids: [String]) throws
}
