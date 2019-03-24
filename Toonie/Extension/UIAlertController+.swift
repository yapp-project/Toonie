//
//  UIAlertController+.swift
//  Toonie
//
//  Created by 이재은 on 24/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

extension UIAlertController {
  
  /// `UIAlertController` Helper.
  static func alert(title: String?,
                    message: String?,
                    style: UIAlertController.Style = .alert) -> UIAlertController {
    let alert = UIAlertController(title: title, message: message, preferredStyle: style)
    return alert
  }
  
  /// `UIAlertAction` Helper.
  @discardableResult
  func action(title: String?,
              style: UIAlertAction.Style = .default,
              completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
    let action = UIAlertAction(title: title, style: style) { completion?($0) }
    addAction(action)
    return self
  }
  
  /// 빌더 패턴을 통해 만들어진 `UIAlertController` present.
  func present(to viewController: UIViewController?,
               animated: Bool = true,
               completion: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      if !(viewController?.presentedViewController is UIAlertController) {
        viewController?.present(self, animated: animated, completion: completion)
      }
    }
  }
}
