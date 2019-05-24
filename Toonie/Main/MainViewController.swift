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
        CommonUtility.sharedInstance
            .mainNavigationViewController = self
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
    
    //탭바 이벤트 발생시 수행할 클로저
    var feedDidTapClosure: (() -> Void)?
    
    // MARK: - Property
    private weak var statusButton: UIButton!
    
    //탭바 이벤트 발생시 수행할 클로저
    var tabDidTapClosure: (() -> Void)?
    
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
        setButtonTextCenter()
        tabBarButtonDidTap(feedButton)
        
        //버전 체크
        chkToonieUpdate()
        
        //앱리뷰요청
        CommonUtility.sharedInstance.showStoreReview()
        
        UIAlertController
            .alert(title: "1.0.0(5)",
                   message: "앱리뷰기능추가\n찜기능 추가\n일부오류수정\n마이페이지 네트워킹부분 수정\n전체보기 기능",
                   style: .alert)
            .action(title: "확인", style: .default) { _ in
            }
            .present(to: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "Feed" {
            if let feedNavigationController = segue.destination as? FeedNavigationController {
                if let feedViewController = feedNavigationController.rootViewController as? FeedViewController {
                    self.feedDidTapClosure = {
//                        feedViewController.viewWillAppear(true)
//                         feedViewController.loadToon()
                    }
                }
            }
        }

        if segue.identifier == "myPage" {
            if let myPageNavigationController = segue.destination as? MyPageNavigationController {
                if let myPageViewController = myPageNavigationController.rootViewController as? MypageViewController {
                    self.tabDidTapClosure = {
                        myPageViewController.viewWillAppear(true)

                    }
                }
            }
        }
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
            if let closure = self.feedDidTapClosure {
                closure()
            }
        case lookButton:
            TabbarButtonCase.look.showStatusView(view: &lookContainerView,
                                                 button: &lookButton)
        case myPageButton:
            TabbarButtonCase.myPage.showStatusView(view: &myPageContainerView,
                                                   button: &myPageButton)
            if let closure = self.tabDidTapClosure {
                closure()
            }
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
            CommonUtility.sharedInstance
                .feedNavigationViewController?
                .popToRootViewController(animated: true)
        case lookButton:
            CommonUtility.sharedInstance
                .lookNavigationViewController?
                .popToRootViewController(animated: true)
        case myPageButton:
            CommonUtility.sharedInstance
                .myPageNavigationViewController?
                .popToRootViewController(animated: true)
        default:
            CommonUtility.sharedInstance
                .feedNavigationViewController?
                .popToRootViewController(animated: true)
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
    
    func setButtonTextCenter() {
        feedButton.centerImageAndButton(5, imageOnTop: true)
        lookButton.centerImageAndButton(5, imageOnTop: true)
        myPageButton.centerImageAndButton(5, imageOnTop: true)
    }
    
    ///업데이트 체크
    func chkToonieUpdate() {
        ChkToonieUpdateService.shared.getUpdateInfo { [weak self] result in
            guard let self = self else { return }
            if result.forcedUpdate == true {
                if let forcedVersion = result.forceInfo?.forcedVersion {
                    if CommonUtility.sharedInstance
                        .compareToVersion(newVersion: forcedVersion) < 0 {
                        
                        self.chkToonieUpdateAlertShow(message: result
                            .forceInfo?
                            .forcedString ?? "최신 버전이 나왔어요! 업데이트하고 즐거운 투니 되세요!",
                                                      urlString: result
                                                        .forceInfo?
                                                        .forcedMoveUrl ?? "",
                                                      mode: result
                                                        .forceInfo?
                                                        .forcedAlertMode == "oneButton")
                    }
                }
            }
            if result.targetUpdate == true {
                if let targetVersion = result.targetInfo?.targetVersion {
                    if CommonUtility.sharedInstance
                        .compareToVersion(newVersion: targetVersion) == 0 {
                        
                        self.chkToonieUpdateAlertShow(message: result
                            .targetInfo?
                            .targetString ?? "최신 버전이 나왔어요! 업데이트하고 즐거운 투니 되세요!",
                                                      urlString: result.targetInfo?.targetMoveUrl ?? "",
                                                      mode: result.targetInfo?.targetAlertMode == "oneButton")
                    }
                }
            }
            
        }
    }
    
    ///모드에 따라 업데이트 알럿을 다르게 띄움
    func chkToonieUpdateAlertShow(message: String,
                                  urlString: String,
                                  mode: Bool) {
        if mode {
            UIAlertController
                .alert(title: nil,
                       message: message,
                       style: .alert)
                .action(title: "업데이트", style: .default) { _ in
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
                .present(to: self)
        } else {
            UIAlertController
                .alert(title: nil,
                       message: message,
                       style: .alert)
                .action(title: "AppStore", style: .default) { _ in
                    if let url = URL(string: urlString) {
                        UIApplication.shared.open(url, options: [:])
                    }
                }
                .action(title: "취소", style: .default) { _ in
                }
                .present(to: self)
        }
    }
}
