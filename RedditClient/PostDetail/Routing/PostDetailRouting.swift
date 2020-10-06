//
//  PostDetailRouting.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/6/20.
//

import UIKit

class PostDetailRouting: PostDetailRoutingProtocol {
    
    class func createPostDetailModule(forPost post: PostModel) -> UIViewController {
        let viewController = PostDetailView()
        let presenter: PostDetailPresenterProtocol = PostDetailPresenter()
        let wireFrame: PostDetailRouting = PostDetailRouting()
        
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.post = post
        presenter.wireFrame = wireFrame
        return viewController
    }
    
}
