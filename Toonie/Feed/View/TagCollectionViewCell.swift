//
//  TagCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는' 태그 컬렉션뷰셀
final class TagCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var backView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  
  var cellStatus: Bool = false {
    didSet {
      setBorderViewLayout(status: cellStatus)
    }
  }
  
  /// didTap 일어날 때마다 cellBackgroundView 레이아웃 바꿔주는 함수
  func setBorderViewLayout(status: Bool) {
    if status == false { // 선택 안함
      CommonUtility.sharedInstance.setBorder(view: &backView,
                                             color: UIColor.init(white: 0, alpha: 0.4).cgColor,
                                             borderWidth: 1)
      titleLabel.textColor = UIColor.init(white: 0, alpha: 0.4)
      backView.backgroundColor = UIColor.white
      titleLabel.font = CommonUtility
        .getAppleSDGothicNeo(option: CommonUtility.AppleSDOption.regular,
                             size: titleLabel.font.pointSize)
    } else { // 선택함
      CommonUtility.sharedInstance
        .setBorder(view: &backView,
                   color: UIColor.init(white: 0, alpha: 0).cgColor,
                   borderWidth: 1)
      backView.backgroundColor = UIColor.init(named: "main")
      titleLabel.textColor = UIColor.init(white: 1, alpha: 1)
      titleLabel.font = CommonUtility
        .getAppleSDGothicNeo(option: CommonUtility.AppleSDOption.bold,
                             size: titleLabel.font.pointSize)
    }
    CommonUtility.sharedInstance.setCorner(view: &backView,
                                           cornerRadius: 23.5)
  }
}