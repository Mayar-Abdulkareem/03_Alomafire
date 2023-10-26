//
//  FollowerCollectionViewCellViewModel.swift
//  03_Alomafire
//
//  Created by FTS on 24/10/2023.
//

import UIKit

struct FollowerCellModel {
    let name: String
    let avatarUrl: String
}

class FollowerCellViewModel {
    var model: FollowerCellModel?
    var onFetchImage: ((_ image: UIImage) -> Void)?
    
    func fetchImage() {
        guard let model = model else {return}
        ImageUtility.shared.loadImageFromURLAsync(model.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.onFetchImage?(image)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
