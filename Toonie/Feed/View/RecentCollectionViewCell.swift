//
//  RecentCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '최근 본 작품과 연관된' 세번째 컬렉션뷰셀
final class RecentCollectionViewCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var recentToonImageView: UIImageView!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var bookMarkButton: UIButton!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    recentToonImageView.image = nil
    artistLabel.text = nil
    bookMarkButton.isSelected  = false
  }
  
  // MARK: - Functions
  
  /// 컬렉션뷰셀 데이터 설정
  func setRecentCollectionViewCellProperties() {
    recentToonImageView.image = UIImage(named: "sample2")
    artistLabel.text = "임유끼"
    
  }
  
  /// 이미지 모서리 둥글게 처리
  func setRecentToonImageView() {
    recentToonImageView.layer.setBorder(color: .clear, width: 0.0, radius: 5.0)
  }
}
