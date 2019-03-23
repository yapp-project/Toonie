//
//  UIImageView+imageFromUrl.swift
//  Toonie
//
//  Created by 양어진 on 08/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
import Kingfisher

extension UIView {
    //이미지뷰 조금 둥글게 설정
    func setCorner( view: inout UIView,
                    cornerRadius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    
    ///border corner 설정하는 메서드
    func setBorder(view: inout UIView,
                   color: CGColor = UIColor.black.cgColor,
                   borderWidth: CGFloat = 1.0) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = color
    }
}

extension UIImageView {
    //Kingfisher를 이용해 url로부터 이미지를 가져옴
    func imageFromUrl(_ urlString: String?,
                      defaultImgPath : String) {
        let defaultImg = UIImage(named: defaultImgPath)
        if let url = urlString {
            if url.isEmpty {
                self.image = defaultImg
            } else {
                self.kf.setImage(with: URL(string: url),
                                 placeholder: defaultImg,
                                 options: [.transition(ImageTransition.fade(0.5))])
            }
        } else {
            self.image = defaultImg
        }
    }
}
