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
    static let userToken = UserDefaults.standard.string(forKey: "token")
    
    var mainNavigationViewController: MainNavigationController?
    var feedNavigationViewController: FeedNavigationController?
    var lookNavigationViewController: LookNavigationController?
    var myPageNavigationViewController: MyPageNavigationController?
    
    //싱글톤
    static let sharedInstance = CommonUtility()
    
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
    
    ///키워드에 쓰일 문자열, 문자열에 대한 이미지 매핑
    static func tagImage(name: String) -> String {
        switch name {
        case "반려동물":
            return "LookCategoryImg_1"
        case "직업":
            return "LookCategoryImg_2"
        case "음식":
            return "LookCategoryImg_3"
        case "자취생활":
            return "LookCategoryImg_4"
        case "해외":
            return "LookCategoryImg_5"
        case "페미니즘":
            return "LookCategoryImg_6"
        case "심리 감정":
            return "LookCategoryImg_7"
        case "여행":
            return "LookCategoryImg_8"
        case "학교생활":
            return "LookCategoryImg_9"
        case "가족":
            return "LookCategoryImg_10"
        case "자기계발":
            return "LookCategoryImg_11"
        case "사랑 연애":
            return "LookCategoryImg_12"
        default:
            return ""
        }
    }
    
    static func compareToVersion(newVersion: String) -> Int {
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
    
}
