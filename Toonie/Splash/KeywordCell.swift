//
//  KeywordCell.swift
//  Toonie
//
//  Created by 박은비 on 28/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class KeywordCell: UICollectionViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Property

    var cellStatus: Bool = false {
        didSet {
            setBorderViewLayout(status: cellStatus)
        }
    }

    // MARK: - Function
    
    ///didTap 일어날때마다 cellBackgroundView 레이아웃 바꿔주는 함수
    func setBorderViewLayout(status: Bool) {
        if status == false { //선택안함
            backView.setBorder(color: UIColor.init(white: 0, alpha: 0.4).cgColor,
                               borderWidth: 1)
            titleLabel.textColor = UIColor.init(white: 0, alpha: 0.4)
            backView.backgroundColor = UIColor.white
            titleLabel.font = UIFont.getAppleSDGothicNeo(option: .regular,
                                                                   size: titleLabel.font.pointSize)
        } else {//선택함
            backView.setBorder(color: UIColor.init(white: 0, alpha: 0).cgColor,
                                                   borderWidth: 1)
            backView.backgroundColor = UIColor.init(named: "main")
            titleLabel.textColor = UIColor.init(white: 1, alpha: 1)
            titleLabel.font = UIFont.getAppleSDGothicNeo(option: .bold,
                                                         size: titleLabel.font.pointSize)
        }
        backView.setCorner(cornerRadius: 23.5)
    }
    
}
