//
//  ForYouCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '당신을 위한 공감툰' 두번째 컬렉션뷰셀
final class ForYouCollectionViewCell: UICollectionViewCell {
  
  // MARK: - IBOutlets
  
  @IBOutlet weak var forYouToonImageView: UIImageView!
  @IBOutlet weak var forYouToonTitleLabel: UILabel!
  @IBOutlet weak var forYouToonTagLabel: UILabel!
  @IBOutlet weak var bookMarkButton: UIButton!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    forYouToonImageView.image = nil
    forYouToonTitleLabel.text = nil
    forYouToonTagLabel.text = nil
    bookMarkButton.isSelected  = false
  }
  
  /// 컬렉션뷰셀 데이터 설정
  func setForYouCollectionViewCellProperties() {
    forYouToonImageView.image = UIImage(named: "sampleImage")
    forYouToonTitleLabel.text = "고양이빵집_캣빵"
    forYouToonTagLabel.text = "#고양이 #인스타그램"
    
  }
  
  func setForYouToonImageView() {
     forYouToonImageView.layer.setBorder(color: .clear, width: 0.0, radius: 5.0)
  }
}
