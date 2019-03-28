//
//  MainViewController.swift
//  Toonie
//
//  Created by 이재은 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

//Main의 NavigationController
final class MainNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder) 
        CommonUtility.sharedInstance.mainNavigationViewController = self
    }
}

final class MainViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var feedContainerView: UIView!
    @IBOutlet private weak var lookContainerView: UIView!
    @IBOutlet private weak var myPageContainerView: UIView!
    @IBOutlet private weak var feedButton: UIButton!
    @IBOutlet private weak var lookButton: UIButton!
    @IBOutlet private weak var myPageButton: UIButton!
    
    // MARK: - Property
    private var statusButton: UIButton!
    
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
        //전에 선택했던 버튼과 같다면 rootViewController로 돌아옴
        if statusButton == sender {
            didTapDoubleButton()
            return
        }
        
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
        
        statusButton = sender
        
    }
    
    // MARK: - Function
    ///이전에 선택한 버튼을 또 선택하는 경우 popToRootViewController
    func didTapDoubleButton() {
        switch statusButton {
        case feedButton:
            CommonUtility.sharedInstance.feedNavigationViewController?.popToRootViewController(animated: true)
        case lookButton:
            CommonUtility.sharedInstance.lookNavigationViewController?.popToRootViewController(animated: true)
        case myPageButton:
            CommonUtility.sharedInstance.feedNavigationViewController?.popToRootViewController(animated: true)
        default:
            CommonUtility.sharedInstance.feedNavigationViewController?.popToRootViewController(animated: true)
        }
    }
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
