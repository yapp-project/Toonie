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
    
    // MARK: - Properties
    var toonID: String = ""
    var toonName: String = ""
    var instaID: String = ""
    var instaUrl: String = ""
    var instaThumnailUrl: String = ""
    var instafollowerCnt: String = ""
    var instaLatestPostUrl: String = ""
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var recentToonImageView: UIImageView!
    @IBOutlet private weak var toonNameTitle: UILabel!
    @IBOutlet private weak var bookMarkButton: UIButton!
    @IBOutlet weak var curationTagList: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recentToonImageView.image = nil
        toonNameTitle.text = nil
        bookMarkButton.isSelected  = false
        
        recentToonImageView.setCorner(cornerRadius: 4.0)
    }
    
    // MARK: - IBAction
    
    /// 찜한 작품 등록 & 취소 기능
    @IBAction func addFavoriteToon(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let body = [
            "workListName": "default",
            "workListInfo": "찜한 목록",
            "toonId": toonID
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
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecommendCollectionViewCellProperties(curationInfoList: ToonInfoList?) {
        prepareForReuse()
        
        if let info = curationInfoList { 
            DispatchQueue.main.async {
                self.recentToonImageView.image = self.recentToonImageView.image?
                    .resize(newWidth: UIScreen.main.bounds.width / 2)
                self.recentToonImageView.imageFromUrl(info.instaThumnailUrl,
                                                      defaultImgPath: "dum2")
            }
            if let nameString = info.toonName {
                toonNameTitle.text = nameString
            }
            
            var tagList = ""
            if let toonTagList = info.toonTagList {
                for index in 0..<toonTagList.count {
                    tagList += "#" + toonTagList[index] + " "
                }
                curationTagList.text = tagList
            }
            
            toonID = info.toonID ?? ""
            toonName = info.toonName ?? ""
            instaID = info.instaID ?? ""
            instaUrl = info.instaUrl ?? ""
            instaThumnailUrl = info.instaThumnailUrl ?? ""
            instafollowerCnt = info.instafollowerCount ?? ""
            
        }
    }
    
    /// 북마크 버튼 상태 설정
    func setBookMarkButton(_ isFavorite: Bool) {
//        prepareForReuse()
        DispatchQueue.main.async {
            self.bookMarkButton.isSelected = isFavorite
        }
    }

}
