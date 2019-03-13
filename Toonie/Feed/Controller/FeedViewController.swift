//
//  FeedViewController.swift
//  Toonie
//
//  Created by 박은비 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// 홈 화면
final class FeedViewController: UIViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet weak var forYouCollectionView: UICollectionView!
  @IBOutlet weak var recentCollectionView: UICollectionView!
  @IBOutlet weak var favoriteCollectionView: UICollectionView!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    if collectionView == forYouCollectionView {
      return 1
    } else if collectionView == recentCollectionView {
      return 1
    } else if collectionView == favoriteCollectionView {
      return 1
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
