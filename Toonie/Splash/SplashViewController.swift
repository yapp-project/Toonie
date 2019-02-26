//
//  SplashViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import UIKit
import SwiftyGif

let KEYWORD_ANIMATION_TAG = 100


class SplashViewController: UIViewController {
 
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var keywordMoveBtn : UIButton!
    
    var keywordAniGifName: String = "giphy.gif"
    let gifManager = SwiftyGifManager(memoryLimit:60)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //일반 유저 진입용 로고 애니메이션과
        //키워드 선택 유저 진입용 로고 애니메이션 구분 필요할듯.
        
        //키워드를 선택한 유저인가?
        if UserDefaults.standard.bool(forKey:"KEYWORD_SELECT") {
            logoAnimation()
        }
        else{
            keywordSelectAnimation()
        }
        
    }
    
    
    
    ///일반 유저 진입시 실행되는 애니메이션
    func logoAnimation() {
    }
    
    ///키워드 화면 진입해야하는 유저일시 실행되는 애니메이션
    func keywordSelectAnimation() {
        let gifImage = UIImage(gifName: keywordAniGifName)
        logoImage.delegate = self
        logoImage.setGifImage(gifImage, manager: gifManager, loopCount: 1)
    }
    
    ///키워드 화면 진입 버튼 노출
    func keywordMoveBtnShow() {
        keywordMoveBtn.isHidden = false
        UIView.animate(withDuration: 0.5, delay:0, options: [], animations: {
            self.keywordMoveBtn.alpha = 1.0
        })
    }
    
    @IBAction func keywordMoveButtonDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "KeywordSelectViewController")
        UIApplication.shared.keyWindow?.rootViewController = vc
    }
}

//tabBarButtonDidTap

extension SplashViewController : SwiftyGifDelegate {
    func gifDidStart(sender: UIImageView) {
    }
    
    func gifDidLoop(sender: UIImageView) {
    }
    
    func gifDidStop(sender: UIImageView) {
        keywordMoveBtnShow()
    }
}
