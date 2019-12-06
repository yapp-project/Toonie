//
//  LookDetailTopSelectCell.swift
//  Toonie
//
//  Created by ebpark on 29/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class LookDetailTopSelectCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var backView: UIView!
    
    private var cellStatus: Bool = false {
        didSet {
            setBorderViewLayout(status: cellStatus)
        }
    }
    
    /// didTap 일어날 때마다 cellBackgroundView 레이아웃 바꿔주는 함수
    func setBorderViewLayout(status: Bool) {
        if status == false { // 선택 안함
            backView.setBorder(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor,
                               borderWidth: 1)
            backView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4)
            
        } else { // 선택함
            backView.setBorder(color: UIColor.clear.cgColor,
                               borderWidth: 1)
            backView.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.2, blue: 0.003921568627, alpha: 1)
            titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        backView.setCorner(cornerRadius: 15)
    }
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    func setCellStatus(bool: Bool) {
        cellStatus = bool
    }
    
    func getCellStatus() -> Bool {
        return cellStatus
    }
}
