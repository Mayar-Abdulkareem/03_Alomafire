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
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindWithViewModel()
    }
    
    private func bindWithViewModel() {
        viewModel.onShowError = { [weak self] msg in
            DispatchQueue.main.async {
                self?.hideActivityIndicator()
                self?.showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the UserVC."))
            }
        }
        
        viewModel.onFetchUser = { [weak self] user in
            self?.navigateToUserVC(with: user)
            self?.hideActivityIndicator()
        }
    }
    
    private func navigateToUserVC(with user: GitHubUser) {
        let userVC = storyboard?.instantiateViewController(withIdentifier: UserVC.id) as? UserVC 
        if let navigationController = navigationController, let userVC = userVC {
            userVC.viewModel = UserViewModel(with: user)
            navigationController.pushViewController(userVC, animated: true)
        } else {
            showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the UserVC."))
        }
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
        viewModel.fetchUser(name: userName.text ?? "SAllen0400")
    }
}







