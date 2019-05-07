//
//  RecentCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 07/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '최근 본 작품과 연관된' 세번째 컬렉션뷰셀
final class RecentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var recentToonImageView: UIImageView!
    @IBOutlet weak var recentToonTitleLabel: UILabel!
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
        recentToonImageView.image = nil
        recentToonTitleLabel.text = nil
        toonIdLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecentCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        prepareForReuse()
        DispatchQueue.main.async {
            self.recentToonImageView.imageFromUrl(toonInfoList.instaThumnailUrl,
                                                  defaultImgPath: "collectionAddLoading")
            self.recentToonImageView.setCorner(cornerRadius: 4)
            self.recentToonTitleLabel.text = toonInfoList.toonName
            self.toonIdLabel.text = toonInfoList.toonID
        }
    }
}
