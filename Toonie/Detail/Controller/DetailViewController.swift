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
    
    // MARK: - Properties
    
    var detailToonID: String?
    private var detailToon: DetailToon?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var detailToonImageView: UIImageView!
    @IBOutlet private weak var detailToonIdLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var postCountLabel: UILabel!
    @IBOutlet private weak var followerNumberLabel: UILabel!
    @IBOutlet private weak var mainKeywordLabel: UILabel!
    @IBOutlet private weak var subKeywordLabel: UILabel!
    
    // MARK: - IBActions
    
    /// 뒤로 가기
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
    
    /// 툰 웹뷰 띄우기
    @IBAction func moveToonButtonDidTap(_ sender: UIButton) {
        if let viewController = self.storyboard?
            .instantiateViewController(withIdentifier: "ToonWebView")
            as? ToonWebViewController {
            viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            viewController.toonUrl = detailToon?.instaUrl
            viewController.instaID = detailToon?.instaID
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    /// 툰 찜하기
    @IBAction func addToMyCollection(_ sender: UIButton) {
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("did\(String(describing: detailToonID))")
        loadDetailToon(detailToonID ?? "")
        if let detailToon = detailToon {
            setDetailToon(detailToon)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        subKeywordLabel?.text = ""
        
    }
    
    // MARK: - Functions
    
    /// 상세화면 툰 정보 네트워크 요청
    private func loadDetailToon(_ toonID: String) {
        DetailToonService.shared.getDetailToon(toonId: toonID) { result in
            self.detailToon = result
            if let detailToon = self.detailToon {
                self.setDetailToon(detailToon)
            }
        }
    }
    
    /// 툰 정보 넣기
    private func setDetailToon(_ detailToon: DetailToon) {
        if let url = URL(string: detailToon.instaThumnailUrl ?? "") {
            do {
                let data = try Data(contentsOf: url)
                detailToonImageView.image = UIImage(data: data)
            } catch let error {
                print("Error : \(error.localizedDescription)")
            }
        }
        detailToonIdLabel.text = detailToon.toonID
        authorLabel.text = detailToon.instaID
        descriptionLabel.text = detailToon.instaInfo
        postCountLabel.text = detailToon.instaPostCount
        followerNumberLabel.text = detailToon.instaFollowerCount
        var tagList = ""
        if let toonTagList = detailToon.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            mainKeywordLabel.text = tagList
        }
        if let toonTagList = detailToon.curationTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            subKeywordLabel.text = tagList
        }
    }
    
}
