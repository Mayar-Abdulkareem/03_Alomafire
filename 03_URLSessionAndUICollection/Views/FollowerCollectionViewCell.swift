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
    
    @IBOutlet weak var followerImg: UIImageView!
    @IBOutlet weak var followerName: UILabel!
    
    @IBOutlet weak var imgHeight: NSLayoutConstraint!
    @IBOutlet weak var imgWidth: NSLayoutConstraint!
    
    static var id = "followerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        followerImg.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.55).isActive = true
        followerImg.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.55).isActive = true
    }
    
    func configureCell(model: FollowerCellModel) {
        followerName.text = model.name
        
        ApiHandler.sharedInstance.loadImageFromURLAsync(model.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.followerImg.image = image
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
}
