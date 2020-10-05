//
//  RCInfoLabel.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class RCInfoLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.textColor = .secondaryLabel
    }
    
    private func configure() {
        font = UIFont.preferredFont(forTextStyle: .footnote)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
