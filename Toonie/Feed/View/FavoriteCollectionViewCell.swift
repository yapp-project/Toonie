//
//  FavoriteCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '즐겨찾는 작품' 네번째 컬렉션뷰셀
final class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var favoriteToonImageView: UIImageView!
    @IBOutlet weak var favoriteToonTitleLabel: UILabel!
    @IBOutlet private weak var favoriteToonTagLabel: UILabel!
    @IBOutlet private weak var bookMarkButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteToonImageView.image = nil
        favoriteToonTitleLabel.text = nil
        favoriteToonTagLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정 ((임시))
    func setFavoriteCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        prepareForReuse()
        DispatchQueue.main.async {
            self.favoriteToonImageView.imageFromUrl(toonInfoList.instaThumnailUrl,
                                                    defaultImgPath: "collectionAddLoading")
            self.favoriteToonImageView.setCorner(cornerRadius: 3)
            self.favoriteToonTitleLabel.text = toonInfoList.toonName
        }
        var tagList = ""
        if let toonTagList = toonInfoList.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            DispatchQueue.main.async {
                self.favoriteToonTagLabel.text = tagList
            }
        }
    }
    
}
