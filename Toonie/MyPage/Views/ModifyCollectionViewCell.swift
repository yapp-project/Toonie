//
//  ModifyCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class ModifyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var toonImageView: UIImageView!
    @IBOutlet weak var toonTitleLabel: UILabel!
    
    /// 컬렉션뷰셀 데이터 설정
    func setModifyCollectionViewCellProperties() {
        toonImageView.image = UIImage(named: "collectionAddLoading")
        toonImageView.setCorner(cornerRadius: 5)
        toonTitleLabel.text = "AddToonView"
    }
}
