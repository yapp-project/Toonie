//
//  DetailViewController.swift
//  Toonie
//
//  Created by 이재은 on 30/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// 인스타툰 상세 화면
final class DetailToonViewController: GestureViewController {
  
  // MARK: - IBOutlets
  
  @IBOutlet private weak var detailToonImageView: UIImageView!
  @IBOutlet private weak var detailToonIdLabel: UILabel!
  @IBOutlet private weak var authorLabel: UILabel!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var blogLabel: UILabel!
  @IBOutlet private weak var postCountLabel: UILabel!
  @IBOutlet private weak var followerNumberLabel: UILabel!
  @IBOutlet private weak var mainKeywordLabel: UILabel!
  @IBOutlet private weak var subKeywordLabel: UILabel!
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    subKeywordLabel?.text = ""

  }
  
  // MARK: - IBActions
  @IBAction func backButtonDidTap(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
  }
  
  /// 공유 액션시트
  @IBAction func moreButtonDidTap(_ sender: UIButton) {
    UIAlertController
      .alert(title: nil, message: nil, style: .actionSheet)
      .action(title: "KakaoTalk에 공유", style: .default) { _ in
        print("dd")
      }
      .action(title: "Messager에 공유", style: .default) { _ in
        print("dd")
      }
      .action(title: "링크 복사", style: .default) { _ in
        print("dd")
      }
      .action(title: "이 작품 더이상 추천 받지 않기", style: .destructive) { _ in
        print("dd")
      }
      .action(title: "취소", style: .cancel) { _ in
        print("dd")
      }
      .present(to: self)
    
  }
  
  @IBAction func moveToonButtonDidTap(_ sender: UIButton) {
  }
  
  @IBAction func addToMyCollection(_ sender: UIButton) {
  }
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  // MARK: - Functions
  
}
