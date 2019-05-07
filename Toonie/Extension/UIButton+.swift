//
//  UIButton+.swift
//  Toonie
//
//  Created by ebpark on 07/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension UIButton {
    func centerImageAndButton(_ gap: CGFloat, imageOnTop: Bool) {
        
        guard let imageView = self.imageView,
            let titleLabel = self.titleLabel else { return }
        
        let sign: CGFloat = imageOnTop ? 1 : -1
        let imageSize = imageView.frame.size
        self.titleEdgeInsets = UIEdgeInsets.init(top: (imageSize.height+gap)*sign,
                                                 left: -imageSize.width,
                                                 bottom: 0,
                                                 right: 0)
        
        let titleSize = titleLabel.bounds.size
        self.imageEdgeInsets = UIEdgeInsets.init(top: -(titleSize.height+gap)*sign,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: -titleSize.width)
    }
}
