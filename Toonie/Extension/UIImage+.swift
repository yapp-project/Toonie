//
//  UIImage+.swift
//  Toonie
//
//  Created by 이재은 on 22/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension UIImage {
    // 이미지 크기 변경.
    func resize(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
