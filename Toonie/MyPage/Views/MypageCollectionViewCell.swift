//
//  MypageCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 22/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mypageToonLabel: UILabel!
    @IBOutlet weak var mypageToonImageView: UIImageView!
    
    /// 컬렉션뷰셀 데이터 설정
    func setMypageCollectionViewCellProperties() {
        mypageToonLabel.isHidden = false
        mypageToonLabel.text = "히사시부링링"
        mypageToonImageView.image = UIImage(named: "myRecentlyLoadingImg")
        mypageToonImageView.setCorner(cornerRadius: mypageToonImageView.frame.size.height/2)
    }
}
