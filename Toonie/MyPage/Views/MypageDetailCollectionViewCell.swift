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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        detailImageView.image = nil
        detailTitleLabel.text = nil
    }
    
    /// 컬렉션뷰셀 데이터 설정
    func setMypageDetailCollectionViewCellProperties() {
        detailImageView.image = UIImage(named: "collectionAddLoading")
        detailTitleLabel.text = "작품 제목임"
    }
}
