//
//  TagCollectionViewCell.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는' 태그 컬렉션뷰셀
final class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    private var cellStatus: Bool = false {
        didSet {
            setBorderViewLayout(status: cellStatus)
        }
    }
    
    /// didTap 일어날 때마다 cellBackgroundView 레이아웃 바꿔주는 함수
    func setBorderViewLayout(status: Bool) {
        if status == false { // 선택 안함
            backView.setBorder(color: UIColor.init(white: 0.447, alpha: 0.4).cgColor,
                               borderWidth: 1)
            titleLabel.textColor = UIColor.init(white: 0, alpha: 0.4)
            
        } else { // 선택함
            let borderColor = UIColor.init(named: "tag")?.cgColor
            
            backView.setBorder(color: borderColor ?? UIColor.init(white: 0, alpha: 0.4).cgColor,
                               borderWidth: 1)
            titleLabel.textColor = UIColor.init(white: 0, alpha: 1)
            
        }
        backView.setCorner(cornerRadius: 5)
    }
    
    func setCellStatus(bool: Bool) {
        cellStatus = bool
    }
    func getCellStatus() -> Bool {
        return cellStatus
    }
    
    func setTitleLabel(titleString: String?) {
        if let titleString = titleString {
            titleLabel.text = "#\(titleString)"
        }
    }
    func getTitleLabel() -> UILabel {
        return titleLabel
    }
}
