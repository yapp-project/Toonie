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
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecommendCollectionViewCellProperties(curationInfoList: ToonInfoList?) {
        prepareForReuse()
        
        if let info = curationInfoList { 
            DispatchQueue.main.async {
                self.recentToonImageView.imageFromUrl(info.instaThumnailUrl,
                                                      defaultImgPath: "")
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
            instaLatestPostUrl = info.instaLatestPostUrl ?? ""
            
        }
    }
}
