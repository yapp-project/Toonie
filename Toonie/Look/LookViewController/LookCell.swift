//
//  LookCell.swift
//  Toonie
//
//  Created by ebpark on 06/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 메인 - LookViewController.mainCategoryCollectionView의 Cell
final class LookCell: UICollectionViewCell {
    @IBOutlet private weak var backgroundImageView: UIImageView!
    
    func setBackgroundImageView(image: UIImage?) {
        backgroundImageView.backgroundColor = UIColor.lightGray
        backgroundImageView.setCorner(cornerRadius: 3.0)
        
        guard image != nil else {
            return
        }
        backgroundImageView.image = image
    }
    
}
