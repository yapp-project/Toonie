//
//  CommunityTableViewCell.swift
//  Toonie
//
//  Created by 양어진 on 21/07/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class CommunityTableViewCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var modifyButton: UIButton!
    @IBOutlet private weak var dayAndTimeButton: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var recommendCollectionView: UICollectionView!
    @IBOutlet weak var recommendButton: UIButton!
    @IBOutlet weak var recommendViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        recommendCollectionView.dataSource = self
        recommendCollectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let padding = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        bounds = bounds.inset(by: padding)
    }

}

// MARK: - UICollectionViewDataSource

extension CommunityTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "CommunityCollectionViewCell",
                                 for: indexPath) as? CommunityCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        cell.setCommunityCollectionViewCellProperties(url: "url",
                                                      indexPath: indexPath.row)
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate

extension CommunityTableViewCell: UICollectionViewDelegate {
    
}
