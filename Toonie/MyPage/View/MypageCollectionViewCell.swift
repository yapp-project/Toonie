//
//  MypageCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 16/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mypageToonLabel: UILabel!
    @IBOutlet weak var mypageToonImageView: UIImageView!
    @IBOutlet weak var mypageCollectionImageView: UIImageView!
    
    /// 컬렉션뷰셀 데이터 설정
    func setMypageCollectionViewCellProperties() {
        mypageToonLabel.text = "히사시부링링"
        mypageToonImageView.image = UIImage(named: "myRecentlyLoadingImg")
        mypageToonImageView.setCornerRadius()
        mypageCollectionImageView.image = UIImage(named: "myCollectionPlus")
    }
}
