//
//  RCDataLoadingViewController.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class RCDataLoadingViewController: UIViewController {
  
  var containerView: UIView!
  
  func showloadingView() {
    containerView = UIView(frame: view.bounds)
    view.addSubview(containerView)
    containerView.backgroundColor = Color.baseColor
    containerView.alpha = 0
    UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
    ])
    activityIndicator.startAnimating()
  }
    
  func dismissLoadingView() {
    DispatchQueue.main.async {
      self.containerView.removeFromSuperview()
      self.containerView = nil
    }
  }
  
}
