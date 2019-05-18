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
    var isFavorite: Bool?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var detailToonImageView: UIImageView!
    @IBOutlet private weak var detailToonIdLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var postCountLabel: UILabel!
    @IBOutlet private weak var followerNumberLabel: UILabel!
    @IBOutlet private weak var mainKeywordLabel: UILabel!
    @IBOutlet private weak var subKeywordLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - IBActions
    
    /// 뒤로 가기
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 공유 액션시트
    @IBAction func moreButtonDidTap(_ sender: UIButton) {
        UIAlertController
            .alert(title: nil, message: nil, style: .actionSheet)
            .action(title: "인스타툰 링크 공유하기", style: .default) { _ in
                self.shareActivity()
            }
//            .action(title: "이 작품 더이상 추천 받지 않기", style: .destructive) { _ in
//                print("dd")
//            }
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
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
    /// 툰 찜하기 & 취소 기능
    @IBAction func addToMyFavorite(_ sender: UIButton) {
        isFavorite?.toggle()
        
        let body = [
            "workListName": "default",
            "workListInfo": "찜한 목록",
            "toonId": detailToon?.toonID
        ]
        
        FavoriteService.shared
            .postFavoriteToon(params: body as [String: Any],
                              completion: {
                                if self.isFavorite == true {
                                    print("Success to add favorite toon")
                                    self.showAddFavoriteToast()
                                } else {
                                    print("Success to delete favorite toon")
                                }
                                self.changeFavoriteButton(self.isFavorite ?? false)
            })
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        addLatestToonList()
        
        loadDetailToon(detailToonID ?? "")
        if let detailToon = detailToon {
            setDetailToon(detailToon)
        }
        changeFavoriteButton(isFavorite ?? false)
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
        DispatchQueue.main.async {
            self.detailToonImageView.imageFromUrl(detailToon.instaThumnailUrl, defaultImgPath: "collectionAddLoading")
            self.detailToonImageView.setCorner(cornerRadius: self.detailToonImageView.frame.width / 2)
            self.detailToonIdLabel.text = detailToon.toonID
            self.authorLabel.text = detailToon.instaID
            self.descriptionLabel.text = detailToon.instaInfo
            self.postCountLabel.text = detailToon.instaPostCount
            self.followerNumberLabel.text = detailToon.instaFollowerCount
        }
        
        var tagList = ""
        if let toonTagList = detailToon.toonTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            DispatchQueue.main.async {
                self.mainKeywordLabel.text = tagList
            }
        }
        if let toonTagList = detailToon.curationTagList {
            for index in 0..<toonTagList.count {
                tagList += "#" + toonTagList[index] + " "
            }
            DispatchQueue.main.async {
                self.subKeywordLabel.text = tagList
            }
        }
    }
    
    /// '찜하기' 했을 때 뜨는 토스트
    private func showAddFavoriteToast() {
        let bookmarkImage = UIImage(named: "bookmark")
        let bookmarkImageView = UIImageView(image: bookmarkImage)
        bookmarkImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 18)
        
        let window = UIApplication.shared.keyWindow
        let toastButton = UIButton(frame: CGRect(x: 0,
                                                 y: view.frame.size.height - (window?.safeAreaInsets.bottom)! - 86,
                                                 width: view.frame.size.width,
                                                 height: 86))
        toastButton.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.3764705882, blue: 0.2509803922, alpha: 1)
        toastButton.setImage(bookmarkImage, for: .normal)
        toastButton.titleLabel?.textColor = UIColor.white
        toastButton.setTitle("    내 찜한 작품에 추가되었습니다.", for: .normal)
        toastButton.titleLabel?.font = UIFont.getAppleSDGothicNeo(option: .medium, size: 14)
        toastButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        toastButton.alpha = 1.0
        view.addSubview(toastButton)
        
        self.toastDown(view: toastButton)
    }
    
    /// 토스트 아래로 사라지는 애니메이션 기능
    private func toastDown(view: UIView) {
        let window = UIApplication.shared.keyWindow
        UIView.animate(withDuration: 0.3, delay: 0.8, options: .curveLinear, animations: {
            view.center.y += 40 - (window?.safeAreaInsets.bottom)!
            view.alpha = 0
        }, completion: { _ in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    /// '찜하기' 버튼 상태 변경 기능
    private func changeFavoriteButton(_ isFavorite: Bool) {
        if isFavorite == true {
            favoriteButton.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.6078431373, blue: 0.6078431373, alpha: 1)
            favoriteButton.setTitle("찜하기 취소", for: .normal)
        } else {
            favoriteButton.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.3764705882, blue: 0.2509803922, alpha: 1)
            favoriteButton.setTitle("찜하기", for: .normal)
        }
    }
    
    /// 공유하기 기능
    private func shareActivity() {
        let textToShare = [detailToon?.instaUrl]
        let activityVC = UIActivityViewController(activityItems: textToShare as [Any],
                                                  applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
    }
    
    /// 최근 조회한 툰 등록하기
    private func addLatestToonList() {
        let body = [
            "workListName": "latest",
            "workListInfo": "최근 본 목록",
            "toonId": detailToon?.toonID
        ]
        
        LatestService.shared
            .postLatestToon(params: body as [String: Any],
                            completion: {
                                print("Success to add latest toon")
            })
    }
    
}
