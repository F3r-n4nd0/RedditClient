//
//  PostDetailView.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/6/20.
//

import UIKit
import WebKit

class PostDetailView: UIViewController {
    
    var presenter: PostDetailPresenterProtocol?
    
    private let padding: CGFloat = 20
    private var webView: WKWebView!
    private let titleLabel = RCTitleLabel(textAlignment: .center, fontSize: 16)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureViewController()
        configureTitleLabel()
        configureWebView()
    }
    
    private func configureViewController() {
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.backgroundColor = Color.baseColor
        view.clipsToBounds = true
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 6
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 145)
        ])
    }
    
    private func configureWebView() {
        webView = WKWebView()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.layer.cornerRadius = 10
        webView.layer.borderWidth = 0.5
        webView.layer.borderColor = UIColor.label.cgColor
        webView.clipsToBounds = true
        webView.navigationDelegate = self
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }
    
}

extension PostDetailView: PostDetailViewProtocol {
    
    func showPostDetail(forPost post: PostModel) {
        DispatchQueue.main.async {
            self.titleLabel.text = post.title
            self.webView.load(URLRequest(url: post.url))
        }
    }
    
}

extension PostDetailView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        guard navigationAction.navigationType == .other || navigationAction.navigationType == .reload  else {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
    
}
