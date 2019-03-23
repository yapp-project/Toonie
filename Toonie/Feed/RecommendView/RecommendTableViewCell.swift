//
//  RecommendTableViewCell.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는'  테이블뷰 셀 - storyboard에서 collectionView 소스분리가 되지않아 xib로 분리.
final class RecommendTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var recommentTitleLabel: UILabel!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setRecommendCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Function
    
    ///delegate세팅 및 xib(nib) 세팅
    func setRecommendCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
        recommendCollectionView.register(nibName, forCellWithReuseIdentifier: "RecommendCollectionViewCell")
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell",
                                                            for: indexPath) as? RecommendCollectionViewCell else {
                                                                return UICollectionViewCell()
        }
        cell.setRecommendCollectionViewCellProperties()
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension RecommendTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("선택 \(indexPath.row)")
    }
} 
