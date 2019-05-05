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
    @IBOutlet private weak var bookMarkButton: UIButton!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        recentToonImageView.image = nil
        recentToonTitleLabel.text = nil
        bookMarkButton.isSelected  = false
    }
    
    // MARK: - Functions
    
    /// 컬렉션뷰셀 데이터 설정
    func setRecentCollectionViewCellProperties(_ toonInfoList: ToonInfoList) {
        prepareForReuse()
        
        if let url = URL(string: toonInfoList.instaThumnailUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.recentToonImageView.image = UIImage(data: data)
                    self.recentToonImageView.setCorner(cornerRadius: 3)
                }
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        DispatchQueue.main.async {
            self.recentToonTitleLabel.text = toonInfoList.toonName
        }
    }
}
