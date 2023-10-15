//
//  ViewController.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var userName: UITextField!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped =  true
        view.addSubview(activityIndicator)
    }
    
    private func activateActivityIndicator(isActive: Bool) {
        if isActive {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    @IBAction func submitBtnTapped(_ sender: Any) {
        configureActivityIndicator()
        activateActivityIndicator(isActive: true)
        ApiHandler.sharedInstance.getUser(userName: userName.text ?? "SAllen0400") { result in
            switch result {
            case .success(let user):
                let destVC = self.storyboard?.instantiateViewController(withIdentifier: UserVC.id) as! UserVC
                destVC.user = user
                self.navigationController?.pushViewController(destVC, animated: true)
            case .failure(let error):
                self.showAlert(alertModel: AlertModel(title: "Failure", msg: "\(error)"))
            }
        }
        activateActivityIndicator(isActive: false)
    }
}





