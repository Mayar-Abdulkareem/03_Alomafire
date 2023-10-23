//
//  followerCollectionViewCell.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 03/10/2023.
//

import UIKit

struct FollowerCellModel {
    let name: String
    let avatarUrl: String
}

class FollowerCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var followerImg: RoundedImageView!
    @IBOutlet weak var followerName: UILabel!
    
    static var id = "followerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model: FollowerCellModel) {
        followerName.text = model.name
        
        ImageUtility.shared.loadImageFromURLAsync(model.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.followerImg.image = image
            case .failure(let error):
                print("\(error)")
            }
        }
    }
}
