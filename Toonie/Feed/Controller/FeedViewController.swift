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
  
  private let tableViewCellReuseIdentifiers = ["tagTableCell",
                                               "forYouTableCell",
                                               "recentTableCell",
                                               "favoriteTableCell"]
  private let collectionViewCellReuseIdentifiers = ["forYouCell",
                                                    "recentCell",
                                                    "favoriteCell"]
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    feedTableView.reloadData()
//    feedTableView.reloadSections(sectionToReload, with: .none)
  }
  
  // MARK: - Function
  
  func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
//    collectionView.delegate = dataSourceDelegate
//    collectionView.dataSource = dataSourceDelegate
//    collectionView.tag = row
//    collectionView.reloadData()
  }
}

// MARK: - UITableViewDataSource

extension FeedViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    print(section)
    return 1
  }
  
  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print(indexPath)
    guard let cell = tableView
      .dequeueReusableCell(withIdentifier: tableViewCellReuseIdentifiers[indexPath.section],
                           for: indexPath) as? TagTableViewCell
      else { return UITableViewCell() }
    cell.setLabel()
    print(cell)
    return cell
    
  }
}

extension FeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView,
                 heightForRowAt indexPath: IndexPath) -> CGFloat {
//    if indexPath.section == 0 {
      return UIScreen.main.bounds.height / 2
//    }
//    return UITableView.automaticDimension
  }
}

extension FeedViewController: UICollectionViewDataSource {
//  func numberOfSections(in collectionView: UICollectionView) -> Int {
//    return 3
//  }
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    print(section)
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print(indexPath)
    switch indexPath.section {
    case 0:
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseIdentifiers[indexPath.section],
                             for: indexPath) as? ForYouCollectionViewCell
        else { return UICollectionViewCell() }
          cell.setForYouCollectionViewCellProperties()
      return cell
    case 1:
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseIdentifiers[indexPath.section],
                             for: indexPath) as? RecentCollectionViewCell
        else { return UICollectionViewCell() }
//      cell.setForYouCollectionViewCellProperties()
      return cell
    case 2:
      guard let cell = collectionView
        .dequeueReusableCell(withReuseIdentifier: collectionViewCellReuseIdentifiers[indexPath.section],
                             for: indexPath) as? FavoriteCollectionViewCell
        else { return UICollectionViewCell() }
//      cell.setForYouCollectionViewCellProperties()
      return cell
      
    default:
      return UICollectionViewCell()
    }

//    guard let favoritecell = collectionView
//      .dequeueReusableCell(withReuseIdentifier: "favoriteCell",
//                           for: indexPath) as? FavoriteCollectionViewCell
    //      else { return UICollectionViewCell() }
//    return cell
  }
}

extension FeedViewController: UICollectionViewDelegate {
  
}
