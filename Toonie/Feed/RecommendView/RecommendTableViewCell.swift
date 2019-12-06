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
    
    // MARK: - Properties
    private var titleString: String? = ""
    private var curationTagArray: [ToonInfoList]?
    private var isFavorite = false
    private var favoriteToons: [ToonList]?
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var recommentTitleLabel: UILabel!
    @IBOutlet private weak var recommendCollectionView: UICollectionView!
    
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
    private func setRecommendCollectionView() {
        recommendCollectionView.delegate = self
        recommendCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "RecommendCollectionViewCell", bundle: nil)
        recommendCollectionView.register(nibName,
                                         forCellWithReuseIdentifier: "RecommendCollectionViewCell")
    }
    
    func setRecommentTitleLabel(titleString: String?) {
        if let title = titleString {
            recommentTitleLabel.text = "#\(title)"
        }
        self.titleString = titleString
        setCurationTag()
    }
    
    private func setCurationTag() {
        if let string = titleString {
            CurationTagService.shared.getCurationTagList(tagName: string) { [weak self] result in
                guard let self = self else { return }
                if let curationTagArray = result {
                    self.curationTagArray = curationTagArray
                }
                
                self.recommendCollectionView.reloadData()
            }
        }
    }
    
    /// 찜한 툰 목록 요청
    private func loadFavoriteToon() {
        FavoriteService.shared.getFavoriteToon { [weak self] result in
            guard let self = self else { return }
            self.favoriteToons = result
        }
    }
    
    /// 찜한 상태인지 확인
    func checkFavoriteStatus(toonId: String) -> Bool {
        isFavorite = false
        guard let favoriteToons = favoriteToons else { return false }
        for index in 0..<favoriteToons.count
            where toonId == favoriteToons[index].toonID {
                isFavorite = true
                break
        }
        return isFavorite
    }
}

// MARK: - UICollectionViewDataSource

extension RecommendTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return curationTagArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "RecommendCollectionViewCell",
                                 for: indexPath) as? RecommendCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.setRecommendCollectionViewCellProperties(curationInfoList: curationTagArray?[indexPath.row])
        self.isFavorite = checkFavoriteStatus(toonId: self.curationTagArray?[indexPath.row].toonID ?? "")
        cell.setBookMarkButton(isSelected)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension RecommendTableViewCell: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "DetailToonView")
            as? DetailToonViewController {
            viewController.detailToonID = curationTagArray?[indexPath.row].toonID
            CommonUtility.shared
                .mainNavigationViewController?
                .pushViewController(viewController, animated: true)
        }
        
    }
} 
