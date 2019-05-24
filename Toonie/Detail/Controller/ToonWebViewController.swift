//
//  ToonWebViewController.swift
//  Toonie
//
//  Created by 이재은 on 31/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import Foundation
import WebKit

// 인스타툰 웹뷰
final class ToonWebViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - Property
    
    var toonUrl: String?
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var instagramWebView: WKWebView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instagramWebView.navigationDelegate = self
        loadWebView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction
    
    /// 모달 닫기
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    /// 웹 화면 이동
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        instagramWebView.goBack()
    }
    
    /// 웹 화면 이동
    @IBAction func forwardButtonDidTap(_ sender: UIButton) {
        instagramWebView.goForward()
    }
    
    // MARK: - Function
    
    /// 웹뷰를 띄우기
    private func loadWebView() {
        let url = URL(string: toonUrl ?? "https://www.instagram.com/")
        if let url = url {
            let request = URLRequest(url: url)
            instagramWebView.load(request)
        }
    }
    
    /// 웹뷰 타이틀, url 넣기
    private func setLabel() {
        let javascript = "document.title\n"
        
        instagramWebView.evaluateJavaScript(javascript) { [weak self] (result, error) -> Void in
            guard let self = self else { return }
            if error == nil {
                self.idLabel.text = result as? String
            }
        }
        urlLabel.text = instagramWebView.url?.absoluteString
    }
    
    /// 웹뷰 버튼, 레이블 설정
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //        backButton.isEnabled = instagramWebView.canGoBack
        //        forwardButton.isEnabled = instagramWebView.canGoForward
        setLabel()
    }
    
}
