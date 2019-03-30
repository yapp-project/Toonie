//
//  RecommendCollectionViewCell.swift
//  Toonie
//
//  Created by 박은비 on 21/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금나는
final class RecommendCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var recentToonImageView: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var bookMarkButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recentToonImageView.image = nil
        artistLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecommendCollectionViewCellProperties() {
        recentToonImageView.image = UIImage(named: "sample2")
        artistLabel.text = "임유끼"
    }
}
