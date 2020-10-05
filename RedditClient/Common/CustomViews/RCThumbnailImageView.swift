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
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 0.5
        clipsToBounds = true
        image = placeholderImage
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }

}
