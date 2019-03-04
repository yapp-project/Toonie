//
//  FeedFirstUIView.swift
//  Toonie
//
//  Created by ebpark on 25/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class FeedFirstUIView: UIView {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var gradientViewWidth: NSLayoutConstraint!
    @IBOutlet weak var gradientBackView: UIView!
    @IBOutlet weak var gradientBackViewRight: NSLayoutConstraint!
    @IBOutlet weak var shapLabel: UILabel!

    override func awakeFromNib() {
        setGradient()
        startAnimation()
    }

    ///그라데이션 배경 설정
    func setGradient() {
        let gradientIv = CAGradientLayer()

        gradientIv.startPoint = CGPoint(x: 0, y: 0.5)
        gradientIv.endPoint = CGPoint(x: 1, y: 0.5)

        gradientIv.colors = [
            UIColor(red: 246/255, green: 166/255, blue: 81/255, alpha: 1).cgColor,
            UIColor(red: 244/255, green: 115/255, blue: 56/255, alpha: 1).cgColor,
            UIColor(red: 252/255, green: 175/255, blue: 69/255, alpha: 1).cgColor,
            UIColor(red: 255/255, green: 220/255, blue: 128/255, alpha: 1).cgColor
        ]

        gradientIv.frame = CGRect.init(origin: CGPoint.zero, size: gradientView.bounds.size)
        gradientBackView.layer.addSublayer(gradientIv)
    }

    ///애니메이션 실행
    func startAnimation() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.3,
                       options: [],
                       animations: {
             self.gradientBackViewRight.constant = self.gradientViewWidth.constant * (-1)
            self.gradientView.layoutIfNeeded()
        }) { (_) in
            self.shapLabel.textColor = UIColor.white
        }

    }

}
