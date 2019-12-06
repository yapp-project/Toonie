//
//  LookDetailCell.swift
//  Toonie
//
//  Created by 박은비 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 상세의 셀
final class LookDetailCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Function
    
    func setImageView(imageURL: String) {
        imageView.imageFromUrl(imageURL, defaultImgPath: "dum2")
        imageView.image = imageView.image?
            .resizeToFit(newWidth: UIScreen.main.bounds.width / 3)
    }
}
