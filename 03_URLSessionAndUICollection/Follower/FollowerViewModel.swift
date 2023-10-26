//
//  FollowerViewModel.swift
//  03_Alomafire
//
//  Created by FTS on 24/10/2023.
//

import UIKit

class FollowerViewModel {
    
    var followers: [GitHubFollower]

    init(with followers: [GitHubFollower]) {
        self.followers = followers
    }
}
