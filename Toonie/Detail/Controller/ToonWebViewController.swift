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
    var instaID: String?
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var instagramWebView: WKWebView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var forwardButton: UIButton!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWebView()
        setLabel(instaId: instaID ?? "", url: toonUrl ?? "https://www.instagram.com/")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        instagramWebView.goBack()
        instagramWebView.reload()
    }
    
    @IBAction func forwardButtonDidTap(_ sender: UIButton) {
        instagramWebView.goForward()
        instagramWebView.reload()
    }
    
    // MARK: - Function
    
    /// 웹뷰를 처음 띄움
    func loadWebView() {
        let url = URL(string: toonUrl ?? "https://www.instagram.com/")
        if let url = url {
            let request = URLRequest(url: url)
            instagramWebView.load(request)
        }
        instagramWebView.navigationDelegate = self
        instagramWebView.allowsBackForwardNavigationGestures = true
    }
    
    func setLabel(instaId: String, url: String) {
        idLabel.text = instaId
        urlLabel.text = url
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButton.isEnabled = instagramWebView.canGoBack
        forwardButton.isEnabled = instagramWebView.canGoForward
    }
}
