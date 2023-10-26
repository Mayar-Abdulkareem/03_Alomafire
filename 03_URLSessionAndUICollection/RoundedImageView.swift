//
//  RoundedImageView.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit
import Alamofire

class RoundedImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = min(bounds.width, bounds.height) / 2.0
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
