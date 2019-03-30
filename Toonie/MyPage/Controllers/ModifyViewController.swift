//
//  ModifyViewController.swift
//  Toonie
//
//  Created by 양어진 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class ModifyViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet private weak var selectAllButton: UIButton!
    @IBOutlet private weak var modifyCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modifyCollectionView.delegate = self
        modifyCollectionView.dataSource = self
    }
    
    // MARK: - IBAction

    @IBAction func completeButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func selectAllButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDataSource

extension ModifyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "ModifyCollectionViewCell",
                                 for: indexPath) as? ModifyCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.setModifyCollectionViewCellProperties()
        
        cell.toonImageView.image = UIImage(named: "collectionAddLoading")
        cell.toonTitleLabel.text = "작품 제목임"
        
        return cell
        
    }
    
}

// MARK: - UICollectionViewDelegate

extension ModifyViewController: UICollectionViewDelegate {
    
}
