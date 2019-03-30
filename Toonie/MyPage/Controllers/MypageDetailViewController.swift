//
//  MypageDetailViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageDetailViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var detailCollectionView: UICollectionView!
    @IBOutlet private weak var detailTitleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailCollectionView.dataSource = self
        detailCollectionView.delegate = self
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func editButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ModifyViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func plusButtonDidTap(_ sender: Any) {
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
        
        cell.detailImageView.image = UIImage(named: "collectionAddLoading")
        cell.detailTitleLabel.text = "작품 제목임"
    
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MypageDetailViewController: UICollectionViewDelegate {
    
}
