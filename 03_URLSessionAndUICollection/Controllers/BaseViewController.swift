//
//  BaseViewController.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 10/10/2023.
//

import UIKit

struct AlertModel {
    let title: String
    let msg: String
}

class BaseViewController: UIViewController {
    func showAlert(alertModel: AlertModel) {
        let alertController = UIAlertController(title: alertModel.title, message: alertModel.msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
