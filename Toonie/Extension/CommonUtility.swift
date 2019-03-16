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
    
    //싱글톤
    static let sharedInstance: CommonUtility = {
        let instance = CommonUtility()
        return instance
    } ()
    
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
    /***/
    
    ///border corner 설정하는 메서드
    func setBorder(view: inout UIView, color: CGColor = UIColor.black.cgColor, borderWidth: CGFloat = 1.0) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = color
        
    }
    func setCorner( view: inout UIView, cornerRadius: CGFloat) {
        view.layer.masksToBounds = true
        view.layer.cornerRadius = cornerRadius
    }
    /***/
    
    ///AppleSDGothicNeo가져옴
    enum AppleSDOption {
        case thin, ultraLight, semiBold, medium, regular, bold, light
    }
    public static func getAppleSDGothicNeo(option: AppleSDOption, size: CGFloat) -> UIFont {
        switch option {
        case .thin:
            return UIFont.init(name: "AppleSDGothicNeo-Thin", size: size) ?? UIFont.systemFont(ofSize: size)
        case .ultraLight:
            return UIFont.init(name: "AppleSDGothicNeo-UltraLight", size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBold:
            return UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium:
            return UIFont.init(name: "AppleSDGothicNeo-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont.init(name: "AppleSDGothicNeo-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont.init(name: "AppleSDGothicNeo-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
        case .light:
            return UIFont.init(name: "AppleSDGothicNeo-Light", size: size) ?? UIFont.systemFont(ofSize: size) 
        }
    }
    /***/
}
