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
    var user: GitHubUser!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        configureUILabel()
    }
    
    private func fetchImage() {
        ImageUtility.shared.loadImageFromURLAsync(user.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.avatarImage.image = image
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func configureUILabel() {
        loginName.text = user.name
        bioLabel.text = user.bio

        let attributedText = NSMutableAttributedString(string: "\(user.name) has \(user.followers) followers")
        let range = (attributedText.string as NSString).range(of: String(user.followers))
        attributedText.addAttributes([.font: UIFont.boldSystemFont(ofSize: 16)], range: range)
        countLabel.attributedText = attributedText
    }
    
    @IBAction func getFollowersBtnTapped(_ sender: Any) {
        NetworkClient.sharedInstance.getFollowers(url: user.followersUrl) { result in
            switch result {
            case .success(let followers):
                let destVC = self.storyboard?.instantiateViewController(withIdentifier: FollowerVC.id) as? FollowerVC
                destVC?.followers = followers
                if let navigationController = self.navigationController, let followerVC = destVC {
                    navigationController.pushViewController(followerVC, animated: true)
                } else {
                    self.showAlert(alertModel: AlertModel(title: "Failure", msg: "Failed to push the followerVC."))
                }
            case .failure(let error):
                self.showAlert(alertModel: AlertModel(title: "Failure", msg: "\(error)"))
            }
        }
    }
}
