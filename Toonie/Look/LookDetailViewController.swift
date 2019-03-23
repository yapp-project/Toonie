//
//  LookDetailViewController.swift
//  Toonie
//
//  Created by ebpark on 06/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 상세 - LookViewController의 CollectionView의 didSelected시 이동되는 화면
final class LookDetailViewController: GestureViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
     
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
