//
//  PostListRouting.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class PostListRouting: PostListRoutingProtocol {
    
    class func createPostListModule() -> UIViewController {
        let viewController = PostListViewController()
        
        let presenter: PostListPresenterProtocol & PostListInteractorOutputProtocol = PostListPresenter()
        let interactor: PostListInteractorInputProtocol & PostListRemoteDataManagerOutputProtocol = PostListInteractor()
        let remoteDataManager: PostListRemoteDataManagerInputProtocol = PostListRemoteDataManager()
        let localDataManager: PostListLocalDataManagerInputProtocol = PostListLocalDataManager()
        let routing: PostListRoutingProtocol = PostListRouting()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.routing = routing
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        interactor.localDatamanager = localDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return viewController
    }
    
    func presentPostDetailScreen(from view: PostListViewProtocol, forPost post: PostModel) {
        let postDetailViewController = PostDetailRouting.createPostDetailModule(forPost: post)
        if let sourceView = view as? UIViewController {
            sourceView.present(postDetailViewController, animated: true)
        }
    }
    
}
