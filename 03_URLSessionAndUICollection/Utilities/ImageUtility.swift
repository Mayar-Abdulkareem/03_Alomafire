//
//  ImageUtility.swift
//  03_Alomafire
//
//  Created by FTS on 23/10/2023.
//

import Foundation
import UIKit
import Alamofire

class ImageUtility {
    static let shared = ImageUtility()
    
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
}
