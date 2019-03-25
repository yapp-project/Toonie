//
//  MainViewController.swift
//  Toonie
//
//  Created by 이재은 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MainViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var feedContainerView: UIView!
    @IBOutlet private weak var lookContainerView: UIView!
    @IBOutlet private weak var myPageContainerView: UIView!
    @IBOutlet private weak var feedButton: UIButton!
    @IBOutlet private weak var lookButton: UIButton!
    @IBOutlet private weak var myPageButton: UIButton!
    
    // MARK: - Property
    
    private enum TabbarButtonCase {
        case feed, look, myPage
        
        var isStatusBool: Bool {
            switch self {
            case .feed:
                return true
            case .look:
                return true
            case .myPage:
                return true
            }
        }
        
        func showStatusView(view: inout UIView,
                            button: inout UIButton) {
            view.isHidden = !isStatusBool
            button.isSelected =  isStatusBool
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarButtonDidTap(feedButton)
    }
    
    // MARK: - Action
    
    @IBAction func tabBarButtonDidTap(_ sender: UIButton) {
        resetSelfView()
        
        switch sender {
        case feedButton:
            TabbarButtonCase.feed.showStatusView(view: &feedContainerView,
                                           button: &feedButton)
        case lookButton:
            TabbarButtonCase.look.showStatusView(view: &lookContainerView,
                                           button: &lookButton)
        case myPageButton:
            TabbarButtonCase.myPage.showStatusView(view: &myPageContainerView,
                                             button: &myPageButton)
        default:
            TabbarButtonCase.feed.showStatusView(view: &feedContainerView,
                                           button: &feedButton)
        }
    }
    
    // MARK: - Function

    ///뷰 초기화
    func resetSelfView() {
        hideAllContainerView()
        offTabbarButtonState()
    }
    
    ///모든 뷰 컨테이너 숨김
    func hideAllContainerView() {
        feedContainerView.isHidden = true
        lookContainerView.isHidden = true
        myPageContainerView.isHidden = true
    }
    
    ///모든 탭버튼 상태 off
    func offTabbarButtonState() {
        feedButton.isSelected = false
        lookButton.isSelected = false
        myPageButton.isSelected = false
        
    }
}
