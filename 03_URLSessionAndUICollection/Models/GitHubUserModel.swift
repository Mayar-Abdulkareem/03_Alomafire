//
//  GitHubUserModel.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import Foundation

struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let name: String
    let bio: String
    let followers: Int
    let followersUrl: String
}
struct GitHubFollower: Codable {
    let login: String
    let avatarUrl: String
}
