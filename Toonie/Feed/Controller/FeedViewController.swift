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

//Feed의 NavigationController
final class FeedNavigationController: UINavigationController {
  override init(rootViewController: UIViewController) {
    super.init(rootViewController: rootViewController)
  }
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    CommonUtility.sharedInstance.feedNavigationViewController = self
  }
}

// 홈 화면
final class FeedViewController: GestureViewController {
  
  // MARK: - IBOutlet
  
  @IBOutlet private weak var tagView: UIView!
  @IBOutlet private weak var forYouCollectionView: UICollectionView!
  @IBOutlet private weak var recentCollectionView: UICollectionView!
  @IBOutlet private weak var favoriteCollectionView: UICollectionView!
  
  // MARK: - Property
  
  private var tagAnimationView: AnimationView?
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setTagAnimationView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  // MARK: - IBAction
  
  ///피드>피드상세 이동
  @IBAction func moveFeedDetailDidTap(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Feed", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendViewController")
    self.navigationController?.pushViewController(viewController, animated: true)
    
  }
  
  // MARK: - Function
  
  /// tagAnimationView 세팅
  func setTagAnimationView() {
    tagAnimationView = AnimationView(name: "tag")
    if let tagAnimationView = tagAnimationView {
      tagAnimationView.contentMode = .scaleAspectFit
      tagView.addSubview(tagAnimationView)
      tagAnimationView.snp.makeConstraints { (make) -> Void in
        make.width.equalTo(tagView.bounds.width)
        make.height.equalTo(tagView.bounds.height)
        make.center.equalTo(tagView)
      }
      tagAnimationView.play()
    }
  }
  
  /// 인스타툰 상세정보 화면으로 이동
  func moveDetailToon() {
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "DetailToonView")
    CommonUtility.sharedInstance.mainNavigationViewController?.pushViewController(viewController, animated: true)
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
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    moveDetailToon()
  }
}
