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
    
    @IBOutlet weak var logoFrameView: UIView!
    private var logoAnimationView: AnimationView?
    
    var moveMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogoAnimationView()

        //버전 체크 후 다음 로직 진행
        chkToonieUpdate {
            //사용자 상태 체크 후 애니메이션 실행.
            self.getUserSelectedKeyword { (mode) in
                self.logoAnimationView?.play { (finished) in
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
        if CommonUtility.userToken == ""{
            mode(true)
        } else {
            MyKeywordsService.shared.getMyKeywords { (myKeywords) in
                if myKeywords?.count == 0 || myKeywords == nil {
                    mode(true)
                } else {
                    mode(false)
                }
            }
            
        }
    }
    
    ///업데이트 체크
    func chkToonieUpdate(complete: @escaping () -> Void) {
        ChkToonieUpdateService.shared.getUpdateInfo { result in
            if result.forcedUpdate == true {
                if let forcedVersion = result.forceInfo?.forcedVersion {
                    if CommonUtility.compareToVersion(newVersion: forcedVersion) < 0 {
                        self.chkToonieUpdateAlertShow(message: result.forceInfo?.forcedString ?? "최신 버전이 나왔어요! 업데이트하고 즐거운 투니 되세요!",
                                                      urlString: result.forceInfo?.forcedMoveUrl ?? "",
                                                      mode: result.forceInfo?.forcedAlertMode == "oneButton",
                                                      complete: {
                                                        complete()
                        })
                    }
                } 
            }
            if result.targetUpdate == true {
                if let targetVersion = result.targetInfo?.targetVersion {
                    if CommonUtility.compareToVersion(newVersion: targetVersion) == 0 {
                        self.chkToonieUpdateAlertShow(message: result.targetInfo?.targetString ?? "최신 버전이 나왔어요! 업데이트하고 즐거운 투니 되세요!",
                                                      urlString: result.targetInfo?.targetMoveUrl ?? "",
                                                      mode: result.targetInfo?.targetAlertMode == "oneButton",
                                                      complete: {
                                                        complete()
                        })
                    }
                }
            }
            
            if result.targetUpdate == false &&
                result.targetUpdate == false {
                complete()
            }
        }
    }
    
    ///모드에 따라 업데이트 알럿을 다르게 띄움
    func chkToonieUpdateAlertShow(message: String,
                                  urlString: String,
                                  mode: Bool,
                                  complete: @escaping () -> Void) {
        if mode {
            UIAlertController
                .alert(title: nil,
                       message: message,
                       style: .alert)
                .action(title: "업데이트", style: .default) { _ in
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        complete()
                    }
                }
                .present(to: self)
        } else {
            UIAlertController
                .alert(title: nil,
                       message: message,
                       style: .alert)
                .action(title: "업데이트", style: .default) { _ in
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:])
                    } else {
                        complete()
                    }
                }
                .action(title: "취소", style: .default) { _ in
                    complete()
                }
                .present(to: self)
        }
    }
    
}
