//
//  ContainerViewModel.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 27/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ContainerViewModel {
    public let repoList: PublishSubject<[Repo]> = PublishSubject()
    public let followerList: PublishSubject<[FollowingUser]> = PublishSubject()
    public let userData: PublishSubject<User> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    func fetchData() {
        NetworkManager.shared.getRepoList { (repos) -> (Void) in
            guard let repos = repos else {
                return
            }
            self.repoList.onNext(repos)
        }
        
        NetworkManager.shared.getFollowingList { (followingUsers) -> (Void) in
            guard let followingUsers = followingUsers else {
                return
            }
            self.followerList.onNext(followingUsers)
        }
        
        NetworkManager.shared.getUserDetails { (user) -> (Void) in
            guard let user = user else {
                return
            }
            self.userData.onNext(user)
        }
    }
}
