//
//  PostDetailProtocols.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/6/20.
//

import UIKit

protocol PostDetailRoutingProtocol: class {
    static func createPostDetailModule(forPost post: PostModel) -> UIViewController
}

protocol PostDetailViewProtocol: class {
    var presenter: PostDetailPresenterProtocol? { get set }
    func showPostDetail(forPost post: PostModel)
}

protocol PostDetailPresenterProtocol: class {
    var view: PostDetailViewProtocol? { get set }
    var wireFrame: PostDetailRoutingProtocol? { get set }
    var post: PostModel? { get set }
    func viewDidLoad()
}
