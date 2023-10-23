//
//  UIViewControllerExtension .swift
//  03_Alomafire
//
//  Created by FTS on 23/10/2023.
//

import Foundation
import UIKit

struct AlertModel {
    let title: String
    let msg: String
}

extension UIViewController {
    func showAlert(alertModel: AlertModel) {
        let alertController = UIAlertController(title: alertModel.title, message: alertModel.msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
