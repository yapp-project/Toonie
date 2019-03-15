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
    private var logoAnimationView: LOTAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        logoAnimationViewSet()
        
        logoAnimationView?.play { (finished) in
            if finished {
                //키워드 선택해야하는 유저라면
                self.keywordMoveBtnShow()
                //아니라면 일반화면으로 이동
//                self.mainMove()
            }
        }
    }
  
    ///애니메이션 후 메인화면으로 이동
    func mainMove() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    ///키워드 화면 진입
    func keywordMoveBtnShow() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KeywordSelectViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    ///logoAnimationView 세팅
    func logoAnimationViewSet() {
        logoAnimationView = LOTAnimationView(name: "logo") 
        logoAnimationView!.contentMode = .scaleAspectFill
        logoAnimationView!.frame = CGRect.init(x: 0,
                                               y: 0,
                                               width: logoFrameView.bounds.width,
                                               height: logoFrameView.bounds.height)
        
        logoFrameView.addSubview(logoAnimationView!)
    }
   
}
