//
//  CommunityCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 21/07/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class CommunityCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var recommendImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recommendImageView
            .setCorner(cornerRadius: recommendImageView.frame.width / 2)
    }
    
    override func prepareForReuse() {
        recommendImageView.image = nil
    }
    
    func setCommunityCollectionViewCellProperties(url: String,
                                                  indexPath: Int) {
        if indexPath == 0 {
            recommendImageView.image = UIImage(named: "image")
        } else {
            recommendImageView.imageFromUrl(url, defaultImgPath: "dum1")
        }
    }
}
