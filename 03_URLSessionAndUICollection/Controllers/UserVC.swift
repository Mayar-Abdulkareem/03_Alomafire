//
//  userVC.swift
//  03_URLSessionAndUICollection
//
//  Created by FTS on 02/10/2023.
//

import UIKit

class UserVC: UIViewController {
    
    static let id = "userVCID"
    var user: GitHubUser!
    var followersCount: Int = 0
    var followers: [GitHubFollower] = []
    
    @IBOutlet weak var avatarImage: RoundedImageView!
    @IBOutlet weak var loginName: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImage()
        configureUI()
    }
    
    private func fetchImage() {
        ApiHandler.sharedInstance.loadImageFromURLAsync(user.avatarUrl) { result in
            switch result {
            case .success(let image):
                self.avatarImage.image = image
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func configureUI() {
        loginName.text = user.name
        bioLabel.text = user.bio
        countLabel.text = "\(user.name) has \(user.followers) followers"
    }
    
    @IBAction func getFollowersBtnTapped(_ sender: Any) {
        ApiHandler.sharedInstance.getFollowers(url: user.followersUrl) { result in
            switch result {
            case .success(let followers):
                let destVC = self.storyboard?.instantiateViewController(withIdentifier: FollowerVC.id) as! FollowerVC
                destVC.followers = followers
                self.navigationController?.pushViewController(destVC, animated: true)
            case .failure(let error):
                self.showAlert(alertModel: AlertModel(title: "Failure", msg: "\(error)"))
            }
        }
    }
    
}
