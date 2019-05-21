//
//  FavoriteCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '찜한 작품과 연관된' 네번째 컬렉션뷰셀
final class FavoriteCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var favoriteToonImageView: UIImageView!
    @IBOutlet weak var favoriteToonTitleLabel: UILabel!
    @IBOutlet private weak var favoriteToonTagLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet private weak var toonIdLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favoriteToonImageView.image = nil
        favoriteToonTitleLabel.text = nil
        favoriteToonTagLabel.text = nil
        toonIdLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - IBAction
    
    /// 찜한 작품 등록 & 취소 기능
    @IBAction func addFavoriteToon(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let body = [
            "workListName": "default",
            "workListInfo": "찜한 목록",
            "toonId": toonIdLabel.text
        ]
        
        FavoriteService.shared
            .postFavoriteToon(params: body as [String: Any],
                              completion: {
                                if sender.isSelected == true {
                                    print("Success to add favorite toon")
                                } else {
                                    print("Success to delete favorite toon")
                                }
            })
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정 ((임시))
    func setFavoriteCollectionViewCellProperties(_ toonList: ToonList) {
        prepareForReuse()
        DispatchQueue.main.async {
            self.favoriteToonImageView.imageFromUrl(toonList.instaThumnailUrl,
                                                    defaultImgPath: "dum2")
            self.favoriteToonImageView.setCorner(cornerRadius: 4)
            self.favoriteToonImageView.image = self.favoriteToonImageView.image?
                .resize(newWidth: UIScreen.main.bounds.width)
            self.favoriteToonTitleLabel.text = toonList.toonName
            self.toonIdLabel.text = toonList.toonID
        }
        var tagList = ""
        if let toonTagList = toonList.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            DispatchQueue.main.async {
                self.favoriteToonTagLabel.text = tagList
            }
        }
    }
    
}
