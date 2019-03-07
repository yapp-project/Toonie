//
//  CALayer+.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension CALayer {
  
  /// 경계선 관련 설정.
  func setBorder(color borderColor: UIColor = .black,
                 width borderWidth: CGFloat = 0,
                 radius cornerRadius: CGFloat = 0) {
    masksToBounds = true
    self.borderColor = borderColor.cgColor
    self.borderWidth = borderWidth
    self.cornerRadius = cornerRadius
  }
}
