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
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, PostModel>!
    
    private let columnLayoutPortrait = UIHelper.createColumnFlowLayout(with: 1)
    private let columnLayoutLandscape = UIHelper.createColumnFlowLayout(with: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureViewController()
        configureCollectionView()
        configureDataSource()
    }
    
    @objc private func selectButtonDismissAll() {
        presenter?.dismissAll()
    }
    
    private func configureViewController() {
        title = "Reddit - Top /all"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = Color.baseColor
        let dismissAllButton = UIBarButtonItem(title: "Dismiss All", style: .plain, target: self, action: #selector(selectButtonDismissAll))
        navigationItem.rightBarButtonItem = dismissAllButton
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
            cell.delegate = self
            return cell
        }
    }
    
    private func updateDataSource(with posts:[PostModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section,PostModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(posts)
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
        updateDataSource(with: posts)
    }
    
    func showError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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

extension PostListViewController: PostCollectionViewCellDelegate {
    
    func selectDismiss(cell: PostCollectionViewCell) {
        guard  let indexPath = collectionView.indexPath(for: cell),
               let post: PostModel = dataSource.itemIdentifier(for: indexPath) else { return }
        presenter?.dismissPost(post)
    }
    
}
