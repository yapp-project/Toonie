//
//  CommonUtility.swift
//  Toonie
//
//  Created by ebpark on 11/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import Firebase
import StoreKit

///애플리케이션에 필요한 잡다한 도구 모음
final class CommonUtility: NSObject {
    
    //개발, 배포용 구분 true: 개발 false: 배포
    static let devSwitch: Bool = true
    
    //디자인 가이드 기준 Xs
    static let deviceWidth: CGFloat  = 375
    static let deviceHeight: CGFloat = 812
    
    weak var mainNavigationViewController: MainNavigationController?
    weak var feedNavigationViewController: FeedNavigationController?
    weak var lookNavigationViewController: LookNavigationController?
    weak var myPageNavigationViewController: MyPageNavigationController?
    
    //싱글톤
    static let sharedInstance = CommonUtility()
    
    ///userToken 가져옴
    static func getUserToken() -> String? {
        return UserDefaults.standard.string(forKey: "token")
    }
    
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
    
    static func analytics(eventName: String, param: [String: Any]?) {
        var replaceEventName = eventName.replacingOccurrences(of: "Toonie.", with: "")
        replaceEventName = devSwitch ? "dev"+replaceEventName : replaceEventName
        Analytics.logEvent(replaceEventName,
                           parameters: param)
    }
    
    ///키워드에 쓰일 문자열, 문자열에 대한 이미지 매핑
    func tagImage(name: String, storyboardName: String) -> String {
        switch name {
        case "반려동물":
            return storyboardName == "Look" ? "LookCategoryImg_1" : "tagPet"
        case "직업":
            return storyboardName == "Look" ? "LookCategoryImg_2" : "tagCareer"
        case "음식":
            return storyboardName == "Look" ? "LookCategoryImg_3" : "tagFood"
        case "자취생활":
            return storyboardName == "Look" ? "LookCategoryImg_4" : "tagLivealone"
        case "해외":
            return storyboardName == "Look" ? "LookCategoryImg_5" : "tagAbroad"
        case "페미니즘":
            return storyboardName == "Look" ? "LookCategoryImg_6" : "tagFeminism"
        case "심리 감정":
            return storyboardName == "Look" ? "LookCategoryImg_7" : "dum2"
        case "여행":
            return storyboardName == "Look" ? "LookCategoryImg_8" : "dum2"
        case "학교생활":
            return storyboardName == "Look" ? "LookCategoryImg_9" : "tagCampus"
        case "가족":
            return storyboardName == "Look" ? "LookCategoryImg_10" : "tagFamily"
        case "자기계발":
            return storyboardName == "Look" ? "LookCategoryImg_11" : "dum2"
        case "사랑 연애":
            return storyboardName == "Look" ? "LookCategoryImg_12" : "dum2"
        default:
            return "dum2"
        }
    }
    
    func compareToVersion(newVersion: String) -> Int {
        var curVersion = ""
        if let bundleVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            curVersion = bundleVersion
        }
        
        if newVersion == "" {
            return 1
        }
        
        if curVersion == "" {
            return 0
        }
        
        let curArray = curVersion.components(separatedBy: ".")
        let newArray = newVersion.components(separatedBy: ".")
        
        let maxLength: Int = curArray.count >= newArray.count ? curArray.count : newArray.count
        
        for index in 0..<maxLength {
            var cur = 0
            if index < curArray.count {
                //                cur = curArray.index(after: index) as Int
                
                cur = Int(curArray[index]) ?? 0
            }
            
            var newInt = 0
            if index < newArray.count {
                newInt = Int(newArray[index]) ?? 0
            }
            
            if cur < newInt {
                return -1 // 들어온 버전이 더 큼
            }
            
            if cur > newInt {
                return 1 // 현재 버전이 더 큼
            }
        }
        return 0 
    }
  
    ///앱 3번 실행마다 앱리뷰 요청
    func showStoreReview() {
        let detailEnterCnt = UserDefaults.standard.integer(forKey: "appStartCount")
        
            if 3 <= detailEnterCnt {
                SKStoreReviewController.requestReview()
                UserDefaults.standard.set(0, forKey: "appStartCount")
            }
    }
}
