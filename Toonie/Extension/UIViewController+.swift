//
//  Animation+.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension UIViewController {
    //커스텀 팝업 띄우기 애니메이션
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3,
                                                y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0,
                                                    y: 1.0)
        })
    }
    
    //커스텀 팝업 끄기 애니메이션
    func removeAnimate() {
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3,
                                                    y: 1.3)
            self.view.alpha = 0.0},
                       completion: { (_) in
            self.view.removeFromSuperview()
        })
    }
}
