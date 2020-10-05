//
//  PostListViewController.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class PostListViewController: UIViewController {
    
    enum Section { case main }
    
    var presenter: PostListPresenterProtocol?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, PostModel>!
    var posts: [PostModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureViewController() {
        title = "Reddit - Top /all"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Color.baseColor
    }
    
    private func configureCollectionView() {
        let columnLayout = RCColumnFlowLayout(cellsPerRow: 1, minimumInteritemSpacing: 10, minimumLineSpacing: 10,
                                              sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: columnLayout)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Color.baseColor
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,PostModel>( collectionView: collectionView) { colletionView, indexPath, post -> UICollectionViewCell? in
            let cell = colletionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseID, for: indexPath) as! PostCollectionViewCell
            cell.load(with: post)
            return cell
        }
    }
    
    private func updatePosts(with posts: [PostModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,PostModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension PostListViewController: PostListViewProtocol {
    
    func showPosts(with posts: [PostModel]) {
        updatePosts(with: posts)
    }
    
    func showError(message: String) {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
}
