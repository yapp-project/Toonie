//
//  MypagePopUpViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class MypagePopUpViewController: UIViewController {

    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var allEraseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //커스텀 팝업 켜기 애니메이션
        self.showAnimate()
        popupView.layer.cornerRadius = 5
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
        // 커스텀 팝업 끄기 애니메이션
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        // 커스텀 팝업 끄기 애니메이션
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    @IBAction func allEraseButtonAction(_ sender: Any) {
    }
    
}
