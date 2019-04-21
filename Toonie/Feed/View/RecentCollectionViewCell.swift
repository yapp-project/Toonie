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
    
    @IBOutlet weak var recentToonImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recentToonImageView.image = nil
        artistLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecentCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        if let url = URL(string: toonInfoList.instaThumnailUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                recentToonImageView.image = UIImage(data: data)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        artistLabel.text = toonInfoList.toonName
    }
}
