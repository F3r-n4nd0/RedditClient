//
//  RCThumbnailImageView.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class RCThumbnailImageView: UIImageView {

    let placeholderImage = Image.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: URL) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }

}
