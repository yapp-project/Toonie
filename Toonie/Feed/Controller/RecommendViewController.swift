//
//  RecommendViewController.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는' 태그에 따른 인스타툰 추천 화면
final class RecommendViewController: UIViewController {
  
  // MARK: - IBOutlets
  @IBOutlet weak var tagCollectionView: UICollectionView!
  @IBOutlet weak var recommendTableView: UITableView!
  @IBOutlet weak var recommendCollectionView: UICollectionView! // 연결 끊음
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
}
