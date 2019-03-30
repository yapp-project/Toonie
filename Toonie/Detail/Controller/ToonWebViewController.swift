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
  
  private var toonUrl = "https://www.instagram.com/hongal.hongal"
  
  // MARK: - IBOutlet
  
  @IBOutlet private var instagramWebView: WKWebView!
  @IBOutlet private weak var backButton: UIButton!
  @IBOutlet private weak var forwardButton: UIButton!
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadWebView()
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
    let url = URL(string: toonUrl)
    if let url = url {
      let request = URLRequest(url: url)
      instagramWebView.load(request)
    }
    instagramWebView.navigationDelegate = self
    instagramWebView.allowsBackForwardNavigationGestures = true
  }
  
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    backButton.isEnabled = instagramWebView.canGoBack
    forwardButton.isEnabled = instagramWebView.canGoForward
  }
  
}
