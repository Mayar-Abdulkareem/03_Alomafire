//
//  ApiHandler.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 10/10/2023.
//

import Foundation
import UIKit
import Alamofire

class ApiHandler {
    
    static let sharedInstance = ApiHandler()
    
    func loadImageFromURLAsync(_ urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                if let image = UIImage(data: data), response.response?.statusCode == 200 {
                    completion(.success(image))
                } else {
                    completion(.failure(ImageError.invalidImageData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUser(userName: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {
        guard let endpoint = URL(string: "https://api.github.com/users/\(userName)") else {
            completion(.failure(GHError.invalidURL))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(endpoint)
            .validate(statusCode: Set([200]))
            .responseDecodable(of: GitHubUser.self, decoder: decoder) { response in
                switch response.result {
                case .success(let user):
                    completion(.success(user))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
        
    func getFollowers(url: String, completion: @escaping (Result<[GitHubFollower], Error>) -> Void) {
        guard let followerURL = URL(string: url) else {
            completion(.failure(GHError.invalidURL))
            return
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        AF.request(followerURL)
            .validate(statusCode: Set([200]))
            .responseDecodable(of: [GitHubFollower].self, decoder: decoder) { response in
                switch response.result {
                case .success(let followers):
                    completion(.success(followers))
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
