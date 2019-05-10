//
//  MypageCollectionViewCell.swift
//  Toonie
//
//  Created by 양어진 on 22/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mypageToonLabel: UILabel!
    @IBOutlet private weak var mypageToonImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mypageToonImageView.image = nil
        mypageToonLabel.text = nil
    }
    
    /// Toon 컬렉션뷰셀 데이터 설정
    func setMypageCollectionViewToonCellProperties(labelText: String, imageViewURL: String) {
        
        mypageToonLabel.isHidden = false
        mypageToonLabel.text = labelText
        mypageToonImageView.imageFromUrl(imageViewURL, defaultImgPath: "")
        mypageToonImageView.setCorner(cornerRadius: mypageToonImageView.frame.size.height/2)
    }
    
    /// Tag 컬렉션뷰셀 데이터 설정
    func setMypageCollectionViewTagCellProperties(tagName: String) {
        
        mypageToonLabel.isHidden = false
        mypageToonLabel.text = "#" + tagName
        mypageToonImageView.image = UIImage(named: CommonUtility.tagImage(name: tagName))
        mypageToonImageView.setCorner(cornerRadius: 5)
    }
}
