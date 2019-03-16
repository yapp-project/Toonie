//
//  FeedViewController.swift
//  Toonie
//
//  Created by 박은비 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

// 홈 화면
final class FeedViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var tagView: UIView!
  @IBOutlet weak var forYouCollectionView: UICollectionView!
  @IBOutlet weak var recentCollectionView: UICollectionView!
  @IBOutlet weak var favoriteCollectionView: UICollectionView!
  
  // MARK: - Property
  
  private var tagAnimationView: LOTAnimationView?
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    setTagAnimationView()
  }
  
  // MARK: - Function
  
  ///tagAnimationView 세팅
  func setTagAnimationView() {
    tagAnimationView = LOTAnimationView(name: "tag")
    if let tagAnimationView = tagAnimationView {
      tagAnimationView.contentMode = .scaleAspectFill
      tagView.addSubview(tagAnimationView)
      tagAnimationView.snp.makeConstraints { (make) -> Void in
        make.width.equalTo(tagView.bounds.width)
        make.height.equalTo(tagView.bounds.height)
        make.center.equalTo(tagView)
      }
      tagAnimationView.play()
    }
  }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == forYouCollectionView {
      return 3
    } else if collectionView == recentCollectionView {
      return 3
    } else if collectionView == favoriteCollectionView {
      return 3
    } else {
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if collectionView == forYouCollectionView {
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "forYouCell",
                             for: indexPath) as? ForYouCollectionViewCell
        else { return UICollectionViewCell() }
      cell.setForYouCollectionViewCellProperties()
      return cell
      
    } else if collectionView == recentCollectionView {
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "recentCell",
                             for: indexPath) as? RecentCollectionViewCell
        else { return UICollectionViewCell() }
      cell.setRecentCollectionViewCellProperties()
      return cell
    } else if collectionView == favoriteCollectionView {
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: "favoriteCell",
                             for: indexPath) as? FavoriteCollectionViewCell
        else { return UICollectionViewCell() }
      cell.setFavoriteCollectionViewCellProperties()
      return cell
    }
    return UICollectionViewCell()
  }
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
  
}
