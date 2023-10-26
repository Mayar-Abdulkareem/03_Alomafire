//
//  userVC.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class UserVC: UIViewController {
    
    @IBOutlet weak var avatarImage: RoundedImageView!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    static let id = "userVCID"
    var viewModel: UserViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindWithViewModel()
        configureUILabel()
    }
    
    private func bindWithViewModel() {
        viewModel?.onFetchImage = { [weak self] image in
            self?.avatarImage.image = image
        }
        
        viewModel?.onShowError = { [weak self] msg in
            DispatchQueue.main.async {
                self?.showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the UserVC."))
            }
        }
        
        viewModel?.onFetchFollowers = { [weak self] followers in
            self?.navigateToFollowerVC(with: followers)
        }
    }
    
    private func navigateToFollowerVC(with followers: [GitHubFollower]) {
        let followerVC = storyboard?.instantiateViewController(withIdentifier: FollowerVC.id) as? FollowerVC
        if let navigationController = navigationController, let followerVC = followerVC {
            followerVC.viewModel = FollowerViewModel(with: followers)
            navigationController.pushViewController(followerVC, animated: true)
        } else {
            showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the followerVC."))
        }
    }
    
    private func configureUILabel() {
        loginName.text = viewModel?.user.name
        bioLabel.text = viewModel?.user.bio
        countLabel.attributedText = viewModel?.formattedFollowerCount
        viewModel?.fetchImage()
    }
    
    @IBAction func getFollowersBtnTapped(_ sender: Any) {
        viewModel?.fetchFollowers()
    }
}
