//
//  ForYouCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '당신을 위한 공감툰' 두번째 컬렉션뷰셀
final class ForYouCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var forYouToonImageView: UIImageView!
    @IBOutlet weak var forYouToonTitleLabel: UILabel!
    @IBOutlet private weak var forYouToonTagLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet private weak var toonIdLabel: UILabel!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        forYouToonImageView.image = nil
        forYouToonTitleLabel.text = nil
        forYouToonTagLabel.text = nil
        toonIdLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setForYouCollectionViewCellProperties(_ toonList: ToonList) {
        prepareForReuse()
        
        DispatchQueue.main.async {
            self.forYouToonImageView.imageFromUrl(toonList.instaThumnailUrl,
                                                  defaultImgPath: "dum2")
            self.forYouToonImageView.setCorner(cornerRadius: 4)
            self.forYouToonImageView.image = self.forYouToonImageView.image?
                .resize(newWidth: UIScreen.main.bounds.width)
            self.forYouToonTitleLabel.text = toonList.toonName
            self.toonIdLabel.text = toonList.toonID
        }
        var tagList = ""
        if let toonTagList = toonList.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            DispatchQueue.main.async {
                self.forYouToonTagLabel.text = tagList
            }
        }
    }
    
    /// 북마크 버튼 상태 설정
    func setBookMarkButton(_ isFavorite: Bool) {
        DispatchQueue.main.async {
            self.bookMarkButton.isSelected = isFavorite
        }
    }
}
