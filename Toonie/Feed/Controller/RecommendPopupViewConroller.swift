//
//  RecommendPopupViewConroller.swift
//  Toonie
//
//  Created by ebpark on 03/08/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class RecommendPopupViewConroller: UIViewController {
    
    // MARK: - Properties
    private var initalHeight: CGFloat!
    
    // MARK: - IBOutlets
    @IBOutlet private weak var buttonHeight: NSLayoutConstraint!

    // MARK: - Life Cycle 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        
        initalHeight = UIScreen.main.bounds.height
        if CommonUtility.deviceHeight <= initalHeight {
            initalHeight = initalHeight - 40
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.3) {
            self.buttonHeight.constant = self.initalHeight
            self.view.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - IBAction
    @IBAction private func closeButtonDidTap(_ sender: Any) {
        UIView.animate(withDuration: 0.3,
                       animations: {
                        self.buttonHeight.constant = self.initalHeight / 5
                        self.view.alpha = 0
                        self.view.layoutIfNeeded()
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }

}
