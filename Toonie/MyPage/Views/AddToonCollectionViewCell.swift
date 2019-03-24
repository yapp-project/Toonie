//
//  AddToonCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class AddToonCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toonImageView: UIImageView!
    @IBOutlet weak var toonTitleLabel: UILabel!
    
    /// 컬렉션뷰셀 데이터 설정
    func setAddToonCollectionViewCellProperties() {
        toonImageView.image = UIImage(named: "collectionAddLoading")
        toonImageView.setCorner(cornerRadius: 5)
        toonTitleLabel.text = "AddToonView"
    }
}
