//
//  UserViewModel.swift
//  03_Alomafire
//
//  Created by FTS on 24/10/2023.
//

import UIKit

class UserViewModel {
    
    var user: GitHubUser
    var onFetchImage: ((_ image: UIImage) -> Void)?
    var onShowError: ((_ msg: String) -> Void)?
    var onFetchFollowers: (([GitHubFollower]) -> ())?
    var formattedFollowerCount: NSAttributedString {
        let attributedText = NSMutableAttributedString(string: "\(user.name) has \(user.followers) followers")
        let range = (attributedText.string as NSString).range(of: String(user.followers))
        attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 16)], range: range)
        return attributedText
    }
    
    init(with user: GitHubUser) {
        self.user = user
    }
    
    func fetchImage() {
        ImageUtility.shared.loadImageFromURLAsync(user.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.onFetchImage?(image)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func fetchFollowers() {
        NetworkClient.sharedInstance.getFollowers(url: user.followersUrl) { result in
            switch result {
            case .success(let followers):
                self.onFetchFollowers?(followers)
            case .failure(let error):
                self.onShowError?(error.localizedDescription)
            }
        }
    }
}
