//
//  UIImageView+imageFromUrl.swift
//  Toonie
//
//  Created by 양어진 on 08/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    //이미지뷰 동그랗게 설정
    func setCornerRadius() {
        self.layer.setBorder(color: .clear, width: 0.0, radius: 5.0)
    }
    
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
