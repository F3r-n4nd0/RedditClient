//
//  PostCollectionViewCell.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

protocol PostCollectionViewCellDelegate: class {
    func selectDismiss(cell: PostCollectionViewCell)
}

class PostCollectionViewCell: UICollectionViewCell {

    static let reuseID = "PostCollectionViewCell"
    
    private let padding: CGFloat = 8
  
    private let thumbnailImageView = RCThumbnailImageView(frame: .zero)
    private let titleLabel = RCTitleLabel(textAlignment: .left, fontSize: 16)
    private let infoLabel = RCInfoLabel(textAlignment: .left)
    private let numberCommentsLabel = RCInfoLabel(textAlignment: .left)
    private let unreadDismissButton =  RCFootNoteButton(title: "Dismiss")
    
    weak var delegate: PostCollectionViewCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureThumbnailImageView()
        configureNumberCommentsLabel()
        configureInfoLabel()
        configureTitleLabel()
        configureDismissButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func load(with post: PostModel) {
        titleLabel.text = post.title
        infoLabel.text = "Submitted \(post.createdTimeAgo) by \(post.author)"
        numberCommentsLabel.text = "\(post.numberComments) comments"
        switch post.thumbnail {
        case .defaultImage:
            thumbnailImageView.image = Image.link
        case .image(url: let url):
            thumbnailImageView.downloadImage(fromURL: url)
        case .selfImage:
            thumbnailImageView.image = Image.doc
        case .unknown:
            thumbnailImageView.image = Image.placeholder
        }
    }
    
    
    private func configureView() {
        backgroundColor = Color.baseColor
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 10
    }
    
    private func configureThumbnailImageView() {
        contentView.addSubview(thumbnailImageView)
        NSLayoutConstraint.activate([
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            thumbnailImageView.widthAnchor.constraint(equalTo: thumbnailImageView.heightAnchor)
        ])
    }

    private func configureNumberCommentsLabel() {
        contentView.addSubview(numberCommentsLabel)
        numberCommentsLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            numberCommentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            numberCommentsLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: padding),
            numberCommentsLabel.heightAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    private func configureInfoLabel() {
        contentView.addSubview(infoLabel)
        infoLabel.numberOfLines = 1
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: padding),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            infoLabel.bottomAnchor.constraint(equalTo: numberCommentsLabel.topAnchor, constant: -10),
            infoLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.numberOfLines = 3
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -10)
        ])
    }
    
    private func configureDismissButton() {
        contentView.addSubview(unreadDismissButton)
        unreadDismissButton.addTarget(self, action: #selector(touchUpInsideDismissButton), for: .touchUpInside)
        NSLayoutConstraint.activate([
            unreadDismissButton.leadingAnchor.constraint(equalTo: numberCommentsLabel.trailingAnchor, constant: 10),
            unreadDismissButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
            unreadDismissButton.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
    
    @objc private func touchUpInsideDismissButton() {
        self.delegate?.selectDismiss(cell: self)
    }

}

