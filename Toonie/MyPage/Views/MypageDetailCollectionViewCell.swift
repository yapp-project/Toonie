//
//  MypageDetailCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    /// 컬렉션뷰셀 데이터 설정
    func setMypageDetailCollectionViewCellProperties() {
        detailImageView.image = UIImage(named: "collectionAddLoading")
        detailImageView.setCornerRadius()
        detailTitleLabel.text = "테슷흐임당"
    }
}
