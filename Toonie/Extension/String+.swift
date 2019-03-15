//
//  String+.swift
//  Toonie
//
//  Created by ebpark on 15/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension String {
    
    ///입력받은 text의 width를 계산
    func widthWithConstrainedHeight(height: CGFloat,
                                    font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude,
                                    height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin,
                                                      .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
}
