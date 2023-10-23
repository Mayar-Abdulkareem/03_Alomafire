//
//  ApiHandler.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 10/10/2023.
//

import Foundation
import UIKit
import Alamofire

class NetworkClient {
    
    static let sharedInstance = NetworkClient()
    private let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    private func fetchData<T: Decodable>(from url: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let endpoint = URL(string: url) else {
            completion(.failure(Errors.invalidURL))
            return
        }
        
        AF.request(endpoint)
            .validate(statusCode: Set([200]))
            .responseDecodable(of: T.self, decoder: self.decoder) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getUser(userName: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {
        let endpoint = Constants.UrlBasePoint.gitHubUsersUrl + userName
        fetchData(from: endpoint, responseType: GitHubUser.self, completion: completion)
    }
        
    func getFollowers(url: String, completion: @escaping (Result<[GitHubFollower], Error>) -> Void) {
        fetchData(from: url, responseType: [GitHubFollower].self, completion: completion)
    }
}
