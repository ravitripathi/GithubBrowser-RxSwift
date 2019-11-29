//
//  ContainerViewController.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 27/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class ContainerViewController: UIViewController {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userHandle: UILabel!
    
    var followerVC: FollowingViewController?
    var repoListVC: RepoListViewController?
    public var userData: PublishSubject<User> = PublishSubject()
    var viewModel = ContainerViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBinding()
        self.viewModel.fetchData()
    }
    
    func setupBinding() {
        viewModel
            .userData
            .observeOn(MainScheduler.instance)
            .bind(to: self.userData)
            .disposed(by: disposeBag)
        
        self.userData.asObservable().bind { (user) in
            self.userName.text = user.name
            self.userHandle.text = user.bio
            if let urlS = user.avatar_url,  let url = URL(string: urlS) {
                self.userImageView.kf.setImage(with: url)
            }
        }.disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repoListSegue" {
            self.repoListVC = (segue.destination as? RepoListViewController)
            self.setupRepoBinding()
        } else if segue.identifier == "followerSegue" {
            self.followerVC = (segue.destination as? FollowingViewController)
            self.setupFollowingBinding()
        }
    }
    
    func setupFollowingBinding() {
        guard let followerVC = self.followerVC else {
            return
        }
        viewModel
            .followerList
            .observeOn(MainScheduler.instance)
            .bind(to: followerVC.followerList)
            .disposed(by: disposeBag)
    }
    
    func setupRepoBinding() {
        
    }
}
