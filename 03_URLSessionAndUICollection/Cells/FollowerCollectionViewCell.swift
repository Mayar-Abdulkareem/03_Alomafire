//
//  followerCollectionViewCell.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 03/10/2023.
//

import UIKit

class FollowerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var followerImg: RoundedImageView!
    @IBOutlet weak var followerName: UILabel!
    private var viewModel = FollowerCellViewModel()
    
    static var id = "followerCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bindWithViewModel()
    }
    
    private func bindWithViewModel() {
        viewModel.onFetchImage = { [weak self] image in
            self?.followerImg.image = image
        }
    }
    
    func configureCell(model: FollowerCellModel) {
        viewModel.model = model
        followerName.text = viewModel.model?.name
        viewModel.fetchImage()
    }
}
