//
//  FavoriteCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '즐겨찾는 작품' 네번째 컬렉션뷰셀
final class FavoriteCollectionViewCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var favoriteToonImageView: UIImageView!
  @IBOutlet weak var favoriteToonTitleLabel: UILabel!
  @IBOutlet weak var favoriteToonTagLabel: UILabel!
  @IBOutlet weak var bookMarkButton: UIButton!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    favoriteToonImageView.image = nil
    favoriteToonTitleLabel.text = nil
    favoriteToonTagLabel.text = nil
    bookMarkButton.isSelected  = false
  }
  
  // MARK: - Functions
  
  /// 컬렉션뷰셀 데이터 설정
  func setFavoriteCollectionViewCellProperties() {
    favoriteToonImageView.image = UIImage(named: "sample3")
    favoriteToonTitleLabel.text = "감자"
    favoriteToonTagLabel.text = "#직장인 #신혼"
  }
}
