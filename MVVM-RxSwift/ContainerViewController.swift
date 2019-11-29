//
//  ContainerViewController.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 27/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import UIKit
import RxSwift

class ContainerViewController: UIViewController {

    var followerVC: FollowersViewController?
    var repoListVC: RepoListViewController?
    
    var viewModel = ContainerViewModel()
    let disposeBag = DisposeBag()
    
    var userName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "repoListSegue" {
            self.repoListVC = (segue.destination as? RepoListViewController)
        } else if segue.identifier == "followerSegue" {
            self.followerVC = (segue.destination as? FollowersViewController)
        }
    }
}
