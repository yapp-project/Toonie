//
//  MainViewController.swift
//  Toonie
//
//  Created by 이재은 on 24/02/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  // 100 Feed, 101 Look, 102 MyPage, 103 Setting
  @IBOutlet weak var feedContainerView: UIView!
  @IBOutlet weak var lookContainerView: UIView!
  @IBOutlet weak var myPageContainerView: UIView!
  @IBOutlet weak var settingContainerView: UIView!
 
  @IBAction func tabBarButtonDidTap(_ sender: UIButton) {
    self.hideContainerView(viewTag: sender.tag - 100)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
        self.view.viewWithTag(100)?.isHidden = false
  }
  
  /// 컨테이너뷰 태그값에 따라서 숨김
  func hideContainerView(viewTag: Int) {
    for index in 100..<104 {
      self.view.viewWithTag(index)?.isHidden = (viewTag != index ? true : false)
      
    }
  }
  
}
