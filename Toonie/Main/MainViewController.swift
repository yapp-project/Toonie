//
//  MainViewController.swift
//  Toonie
//
//  Created by 이재은 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
  // 100 Feed, 101 Look, 102 MyPage
  @IBOutlet weak var feedContainerView: UIView!
  @IBOutlet weak var lookContainerView: UIView!
  @IBOutlet weak var myPageContainerView: UIView!
  @IBOutlet weak var homeButton: UIButton!
  @IBOutlet weak var searchButton: UIButton!
  @IBOutlet weak var myButton: UIButton!
  
  @IBAction func tabBarButtonDidTap(_ sender: UIButton) {
    hideContainerView(viewTag: sender.tag - 100)
    changeTabbarButtonState(viewTag: sender.tag)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.viewWithTag(100)?.isHidden = false
    homeButton.isSelected = true
  }

  /// 컨테이너뷰 태그값에 따라서 숨김
  func hideContainerView(viewTag: Int) {
    for index in 100..<103 {
      self.view.viewWithTag(index)?.isHidden = (viewTag != index ? true : false)
    }
  }
  
  /// 태그값에 따라서 버튼 상태 변경
  func changeTabbarButtonState(viewTag: Int) {
    homeButton.isSelected = false
    searchButton.isSelected = false
    myButton.isSelected = false
    switch viewTag {
    case 200:
      homeButton.isSelected = true
    case 201:
      searchButton.isSelected = true
    case 202:
      myButton.isSelected = true
    default:
      break
    }
  }
}
