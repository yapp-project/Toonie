//
//  CommunityTableViewCell.swift
//  Toonie
//
//  Created by 양어진 on 21/07/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class CommunityTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var modifyButton: UIButton!
    @IBOutlet private weak var dayAndTimeButton: UILabel!
    @IBOutlet private weak var contentsLabel: UILabel!
    @IBOutlet private weak var recommendView: UIView!
    @IBOutlet private weak var recommendCollectionView: UICollectionView!
    @IBOutlet private weak var recommendButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
