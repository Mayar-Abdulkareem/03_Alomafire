//
//  followerVC.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class FollowerVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    static var id = "followerVCID"
    var followers: [GitHubFollower]!
    var filteredFollowers: [GitHubFollower] = []
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }
    
}

extension FollowerVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var isSearching: Bool {
        return searchBar.text?.count ?? 0 != 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return !isSearching ? followers.count : filteredFollowers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCollectionViewCell.id, for: indexPath) as? FollowerCollectionViewCell
        if ((isSearching && indexPath.row >= filteredFollowers.count) || (!isSearching && indexPath.row >= followers.count)) {
            return UICollectionViewCell()
        }
        let follower = !isSearching ? followers[indexPath.row] : filteredFollowers[indexPath.row]
        let followerModel = FollowerCellModel(name: follower.login, avatarUrl: follower.avatarUrl)
        cell?.configureCell(model: followerModel)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.2, height: self.view.frame.width * 0.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)
    }
    
}

extension FollowerVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if (searchText.count == 0) {
            clearAndShowAllFollowers()
            return
        }
        filteredFollowers = followers.filter { follower in
            return follower.login.lowercased().contains(searchText.lowercased())
        }
        noResultsLabel.isHidden = !(filteredFollowers.count == 0)
        collectionView.isHidden = (filteredFollowers.count == 0)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        clearAndShowAllFollowers()
    }
    
    private func clearAndShowAllFollowers() {
        searchBar.showsCancelButton = false
        collectionView.isHidden = false
        noResultsLabel.isHidden = true
        searchBar.text = ""
        filteredFollowers.removeAll()
        collectionView.reloadData()
    }
    
}
