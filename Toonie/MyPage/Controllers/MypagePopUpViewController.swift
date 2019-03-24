//
//  MypagePopUpViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypagePopUpViewController: GestureViewController {

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
    
    @IBAction func okButtonDidTap(_ sender: Any) {
        // 커스텀 팝업 끄기 애니메이션
        self.removeAnimate()
        self.view.removeFromSuperview()
        
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "AddToonViewController") as? AddToonViewController
            else {
                return
        }
        navigationController?.present(viewController, animated: true)
    }
    
    @IBAction func cancelButtonDidTap(_ sender: Any) {
        // 커스텀 팝업 끄기 애니메이션
        self.removeAnimate()
        self.view.removeFromSuperview()
    }
    
    @IBAction func allEraseButtonDidTap(_ sender: Any) {
    }
    
}
