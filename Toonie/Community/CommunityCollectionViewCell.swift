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
}
