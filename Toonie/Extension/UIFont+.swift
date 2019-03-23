//
//  UIFont+.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    ///AppleSDGothicNeo가져옴
    public enum AppleSDOption {
        case thin, ultraLight, semiBold, medium, regular, bold, light
    }
    
    public static func getAppleSDGothicNeo(option: AppleSDOption,
                                           size: CGFloat) -> UIFont {
        switch option {
        case .thin:
            return UIFont.init(name: "AppleSDGothicNeo-Thin",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .ultraLight:
            return UIFont.init(name: "AppleSDGothicNeo-UltraLight",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .semiBold:
            return UIFont.init(name: "AppleSDGothicNeo-SemiBold",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .medium:
            return UIFont.init(name: "AppleSDGothicNeo-Medium",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .regular:
            return UIFont.init(name: "AppleSDGothicNeo-Regular",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .bold:
            return UIFont.init(name: "AppleSDGothicNeo-Bold",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        case .light:
            return UIFont.init(name: "AppleSDGothicNeo-Light",
                               size: size) ?? UIFont.systemFont(ofSize: size)
        }
    }
}
