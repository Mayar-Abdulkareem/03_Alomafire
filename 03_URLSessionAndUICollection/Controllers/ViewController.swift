//
//  ViewController.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        configureActivityIndicator()
        showActivityIndicator()
        NetworkClient.sharedInstance.getUser(userName: userName.text ?? "SAllen0400") { result in
            switch result {
            case .success(let user):
                let destVC = self.storyboard?.instantiateViewController(withIdentifier: UserVC.id) as? UserVC
                destVC?.user = user
                if let navigationController = self.navigationController, let userVC = destVC {
                    navigationController.pushViewController(userVC, animated: true)
                } else {
                    self.showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the UserVC."))
                }
            case .failure(let error):
                self.showAlert(alertModel: AlertModel(title: "Failure", msg: "\(error)"))
            }
        }
        hideActivityIndicator()
    }
}







