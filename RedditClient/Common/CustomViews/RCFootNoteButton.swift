//
//  RCFootNoteButton.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class RCFootNoteButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.preferredFont(forTextStyle: .footnote),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributeString = NSAttributedString(string: title, attributes:yourAttributes)
        setAttributedTitle(attributeString, for: .normal)
    }
    
    private func configure() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
