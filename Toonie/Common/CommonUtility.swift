//
//  CommonUtility.swift
//  Toonie
//
//  Created by ebpark on 11/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///애플리케이션에 필요한 잡다한 도구 모음
final class CommonUtility: NSObject {
  //디자인 가이드 기준 Xs
  
  static let deviceWidth: CGFloat  = 375
  static let deviceHeight: CGFloat = 812
//    static let userToken = UserDefaults.standard.string(forKey: "token")
    static let userToken = "7777777777777777777777" //임시
  
  var mainNavigationViewController: MainNavigationController?
  var feedNavigationViewController: FeedNavigationController?
  var lookNavigationViewController: LookNavigationController?
  var myPageNavigationViewController: MyPageNavigationController?
  
  //싱글톤
  static let sharedInstance: CommonUtility = {
    let instance = CommonUtility()
    return instance
  } ()
  
//  static let shared = CommonUtility()
  
  ///아이폰Xs 해상도 기준으로 타 디바이스 비율을 가져오는 메서드
  static func getDeviceRatioWidth() -> CGFloat {
    //        print("-->현재 디바이스 크기 \(UIScreen.main.bounds.width)")
    return (CGFloat)(UIScreen.main.bounds.width / deviceWidth)
  }
  static func getDeviceRatioHieght() -> CGFloat {
    //        print("-->현재 디바이스 크기 \(UIScreen.main.bounds.height)")
    // XMax : 812 -> 디바이스 크기 Xs 기준으로 나오고 있음
    return (CGFloat)(UIScreen.main.bounds.height / deviceHeight)
  }
}
