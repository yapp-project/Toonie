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
  
  @IBOutlet weak var feedTableView: UITableView!
  
  // MARK: - Properties
  
  private let reuseIdentifiers = ["TagCell", "ForYouCell", "RecentCell", "FavoriteCell"]
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: reuseIdentifiers[indexPath.section],
                           for: indexPath) as? FeedTableViewCell
      else { return UITableViewCell() }
    
    return cell
    
  }
}

extension FeedViewController: UITableViewDelegate {
  
}

extension FeedViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView
      .dequeueReusableCell(withReuseIdentifier: reuseIdentifiers[indexPath.section],
                           for: indexPath) as? ForYouCollectionViewCell
      else {
        return UICollectionViewCell() }
    
    cell.setForYouCollectionViewCellProperties()
    return cell
  }

}

extension FeedViewController: UICollectionViewDelegate {
  
}
