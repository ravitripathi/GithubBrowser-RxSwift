//
//  FollowingViewController.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 27/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FollowingViewController: UIViewController {
    
    @IBOutlet weak var followingCollectionView: UICollectionView!
    public var followerList: PublishSubject<[FollowingUser]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let flowLayout = UICollectionViewFlowLayout()
        let size = (followingCollectionView.frame.width/3 - 8.0)
        flowLayout.itemSize = CGSize(width: size, height: size)
        followingCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        self.setupBinding()
    }
    
    func setupBinding() {
        
        followingCollectionView.register(UINib(nibName: "FollowingUserCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: FollowingUserCollectionViewCell.self))
        
        followerList.bind(to: followingCollectionView.rx.items(cellIdentifier: "FollowingUserCollectionViewCell", cellType: FollowingUserCollectionViewCell.self)) { (row, follower, cell) in
            cell.userHandle.text = follower.login
            if let urlS = follower.avatar_url, let url = URL(string: urlS) {
                cell.userImage.kf.setImage(with: url)
            }
        }.disposed(by: disposeBag)
    }
}
