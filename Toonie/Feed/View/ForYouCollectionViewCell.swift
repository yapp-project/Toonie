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
    
    @IBOutlet weak var forYouToonImageView: UIImageView!
    @IBOutlet weak var forYouToonTitleLabel: UILabel!
    @IBOutlet weak var forYouToonTagLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        forYouToonImageView.image = nil
        forYouToonTitleLabel.text = nil
        forYouToonTagLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정  ((임시))
    func setForYouCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        if let url = URL(string: toonInfoList.instaThumnailUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                forYouToonImageView.image = UIImage(data: data)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        forYouToonTitleLabel.text = toonInfoList.toonID
        var tagList = ""
        if let toonTagList = toonInfoList.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            forYouToonTagLabel.text = tagList
        }
    }
}
