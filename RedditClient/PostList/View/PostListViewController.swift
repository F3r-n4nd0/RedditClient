//
//  PostListViewController.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class PostListViewController: RCDataLoadingViewController {
    
    enum Section { case main }
    
    var presenter: PostListPresenterProtocol?
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, PostModel>!
    var posts: [PostModel] = []
    
    private let columnLayoutPortrait = UIHelper.createColumnFlowLayout(with: 1)
    private let columnLayoutLandscape = UIHelper.createColumnFlowLayout(with: 2)
    
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
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: columnLayoutPortrait)
        view.addSubview(collectionView)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = Color.baseColor
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseID)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
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
    
    private func updatePosts() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,PostModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.posts)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let self = self else { return }
            if UIDevice.current.orientation == .portrait {
                self.collectionView.collectionViewLayout = self.columnLayoutPortrait
            } else {
                self.collectionView.collectionViewLayout = self.columnLayoutLandscape
            }
        })
    }
    
}

extension PostListViewController: PostListViewProtocol {
    
    func showPosts(with posts: [PostModel]) {
        self.posts.append(contentsOf: posts)
        updatePosts()
    }
    
    func showError(message: String) {
        
    }
    
    func showLoading() {
        showloadingView()
    }
    
    func hideLoading() {
        dismissLoadingView()
    }
    
}

extension PostListViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            presenter?.loadMorePost()
        }
    }
    
}
