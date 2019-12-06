//
//  SplashViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import Lottie

final class SplashViewController: GestureViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var logoFrameView: UIView!

    // MARK: - Property

    private var logoAnimationView: AnimationView?
    var moveMode: Bool = false

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoAnimationView()
        
        //사용자 상태 체크 후 애니메이션 실행.
        self.getUserSelectedKeyword { [weak self] (mode) in
            guard let self = self else { return }
            self.logoAnimationView?.play { [weak self](finished) in
                guard let self = self else { return }
                if finished {
                    if mode == true {
                        self.moveKeywordView()
                    } else {
                        self.moveMainView()
                    }
                }
            }
        }
    }

    // MARK: - Function

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
        logoAnimationView = AnimationView(name: "logoAnimation")
        if let logoAnimationView = logoAnimationView {
            logoAnimationView.contentMode = .scaleAspectFit
            logoAnimationView.frame = CGRect.init(x: 0,
                                                  y: 0,
                                                  width: logoFrameView.bounds.width,
                                                  height: logoFrameView.bounds.height)
            logoFrameView.addSubview(logoAnimationView)
        }
    }
    
    ///user가 선택한 keyword가 있냐 없냐에 따라 이동하는 화면 mode를 다르게할 메서드
    func getUserSelectedKeyword(mode: @escaping (Bool) -> Void) {
        
        //userToken이 없거나 키워드 선택을 하지 않은 유저인 경우 - true
        //나머지의 경우 - false
        if CommonUtility.getUserToken() == ""
            || CommonUtility.getUserToken() == nil {
            mode(true)
        } else {
            print("### token \(String(describing: CommonUtility.getUserToken()))")
            MyCategorysService.shared.getMyCategorys { (myCategorys) in
                if myCategorys?.count == 0
                    || myCategorys == nil {
                    mode(true)
                } else {
                    mode(false)
                }
            }
            
        }
    }
    
}
