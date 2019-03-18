//
//  SplashViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import Lottie

let tag = 100

final class SplashViewController: UIViewController {

    @IBOutlet weak var logoFrameView: UIView!
  private var logoAnimationView = LOTAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setLogoAnimationView()
        
        logoAnimationView.play { (finished) in
            if finished {
                //키워드 선택해야하는 유저라면
                self.moveKeywordView()
                //아니라면 일반화면으로 이동
//                self.moveMainView()
            }
        }
    }
  
    ///애니메이션 후 메인화면으로 이동
    func moveMainView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    ///키워드 화면 진입
    func moveKeywordView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KeywordSelectViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    ///logoAnimationView 세팅
    func setLogoAnimationView() {
        logoAnimationView = LOTAnimationView(name: "logo") 
        logoAnimationView.contentMode = .scaleAspectFill
        logoAnimationView.frame = CGRect.init(x: 0,
                                               y: 0,
                                               width: logoFrameView.bounds.width,
                                               height: logoFrameView.bounds.height)
        
        logoFrameView.addSubview(logoAnimationView)
    }
   
}
