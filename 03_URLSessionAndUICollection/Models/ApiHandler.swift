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
        let endpoint = "https://api.github.com/users/\(userName)"
        
        AF.request(endpoint).responseJSON { response in
            switch response.result {
            case .success:
                if let statusCode = response.response?.statusCode, statusCode == 200 {
                    if let data = response.data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        do {
                            let user = try decoder.decode(GitHubUser.self, from: data)
                            completion(.success(user))
                        } catch {
                            completion(.failure(GHError.invalidData))
                        }
                    } else {
                        completion(.failure(GHError.invalidData))
                    }
                } else {
                    let error = self.determineError(response.response?.statusCode)
                    completion(.failure(error))
                }
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

        AF.request(followerURL).validate().responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(GHError.invalidData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let followers = try decoder.decode([GitHubFollower].self, from: data)
                    completion(.success(followers))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func determineError(_ statusCode: Int?) -> GHError {
        if let statusCode = statusCode {
            switch statusCode {
            case 404: return GHError.resourceNotFound
            case 422: return GHError.validationFailed
            default: return GHError.invalidResponse
            }
        } else {
            return GHError.invalidResponse
        }
    }

    
}
