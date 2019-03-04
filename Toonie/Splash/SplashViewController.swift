//
//  SplashViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

let tag = 100

final class SplashViewController: UIViewController {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var keywordMoveButton: UIButton!

    var keywordAniGifName: String = "giphy.gif"

    override func viewDidLoad() {
        super.viewDidLoad()

        //일반 유저 진입용 로고 애니메이션과
        //키워드 선택 유저 진입용 로고 애니메이션 구분 필요할듯.

        //키워드를 선택한 유저인가?
//        if UserDefaults.standard.bool(forKey: "KEYWORD_SELECT") {
//            logoAnimation()
//        } else {
//            keywordSelectAnimation()
//        }
        keywordMoveBtnShow()

    }

    ///일반 유저 진입시 실행되는 애니메이션
    func logoAnimation() {
    }

    ///키워드 화면 진입해야하는 유저일시 실행되는 애니메이션
    func keywordSelectAnimation() {
    }

    ///키워드 화면 진입 버튼 노출
    func keywordMoveBtnShow() {
        keywordMoveButton.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.keywordMoveButton.alpha = 1.0
        })
    }

    @IBAction func keywordMoveButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KeywordSelectViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
}
