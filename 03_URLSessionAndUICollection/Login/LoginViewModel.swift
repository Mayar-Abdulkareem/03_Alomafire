//
//  LoginViewModel.swift
//  03_Alomafire
//
//  Created by FTS on 24/10/2023.
//

import Foundation

class LoginViewModel {
    
    var onShowError: ((_ msg: String) -> Void)?
    var onFetchUser: ((GitHubUser) -> ())?
    
    func fetchUser(name: String) {
        NetworkClient.sharedInstance.getUser(userName: name) { result in
            switch result {
            case .success(let user):
                self.onFetchUser?(user)
            case .failure(let error):
                self.onShowError?(error.localizedDescription)
            }
        }
    }
}
