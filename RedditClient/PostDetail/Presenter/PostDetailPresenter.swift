//
//  PostDetailPresenter.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/6/20.
//

import Foundation

class PostDetailPresenter: PostDetailPresenterProtocol {
    
    weak var view: PostDetailViewProtocol?
    var wireFrame: PostDetailRoutingProtocol?
    var post: PostModel?
    
    func viewDidLoad() {
        view?.showPostDetail(forPost: post!)
    }
    
}
