//
//  MypageDetailViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageDetailViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var detailCollectionView: UICollectionView!
    @IBOutlet weak var detailTitleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    // MARK: - IBAction
    
    @IBAction func exitButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension MypageDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MypageDetailCollectionViewCell",
                                 for: indexPath) as? MypageDetailCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.setMypageDetailCollectionViewCellProperties()
        
        if indexPath.row == 0 {
            cell.detailImageView.image = UIImage(named: "collectionAddPlus")
            cell.detailTitleLabel.text = "작품 추가하기"
        } else {
            cell.detailImageView.image = UIImage(named: "collectionAddLoading")
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MypageDetailViewController: UICollectionViewDelegate {
    
}
