//
//  LookDetailCell.swift
//  Toonie
//
//  Created by 박은비 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 상세의 셀
final class LookDetailCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Function
    
    func setImageView(imageURL: String) {
        imageView.imageFromUrl(imageURL, defaultImgPath: "collectionAddLoading")
    }
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecentCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        if let url = URL(string: toonInfoList.instaThumnailUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                imageView.image = UIImage(data: data)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
    }
}
