//
//  MypageViewController.swift
//  Toonie
//
//  Created by 양어진 on 04/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

//MyPage의 MyPageNavigationController

final class MyPageNavigationController: UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonUtility.sharedInstance
            .myPageNavigationViewController = self
    }
}

final class MypageViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tagSettingButton: UIButton!
    @IBOutlet private weak var recentButton: UIButton!
    @IBOutlet private weak var bookMarkButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    @IBOutlet private weak var mypageCollectionView: UICollectionView!
    @IBOutlet private weak var dataCheckLabel: UILabel!
    @IBOutlet private weak var dataCheckImageView: UIImageView!
    
    @IBOutlet weak var mypageCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - private var
    
    private var status = ""
    private var dataList: [ToonList] = []
    private var tagList: [Categorys] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 화면 - 최근 본 목록
        status = "recent"
        mypageCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getToonList(status: status)
        
        CommonUtility.analytics(eventName: "MypageViewController",
                                param: ["token": CommonUtility.getUserToken() ?? "toonie"])
    }
    
    // MARK: - 함수
    
    /// status가 바뀔 때 마다 컬렉션뷰의 제일 첫번째 셀로 돌아가게하는 함수
    private func goToFirstItem() {
        self.mypageCollectionView.scrollToItem(at: IndexPath(row: 0,
                                                             section: 0),
                                               at: .top,
                                               animated: true)
    }
    
    /// button의 상태를 초기화해주는 함수
    private func setButtonInit() {
        recentButton.setImage(UIImage(named: "Recent"),
                              for: .normal)
        bookMarkButton.setImage(UIImage(named: "mypageBookmark"),
                                for: .normal)
        
        recentButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        bookMarkButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        tagButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
    }
    
    /// 인스타툰 상세정보 화면으로 이동하는 함수
    private func pushDetailToonViewController(toonID: String) {
        let storyboard = UIStoryboard(name: "Detail",
                                      bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "DetailToonView")
            as? DetailToonViewController {
            viewController.detailToonID = toonID
            CommonUtility.sharedInstance
                .mainNavigationViewController?
                .pushViewController(viewController,
                                    animated: true)
        }
    }
    
    /// Tag키워드를 가지고 TagDetail뷰로 이동하는 함수
    private func pushTagDetailViewController(keyword: String) {
        let storyboard = UIStoryboard(name: "Look",
                                      bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "LookDetailViewController") as? LookDetailViewController
            else {
                return
        }
        viewController.selectedKeyword = keyword
        self.navigationController?.pushViewController(viewController,
                                                      animated: true)
    }
    
    /// dataCheckLabel Hidden 함수
    private func dataCheck(status: String) {
        mypageCollectionView.reloadData()
        if status == "recent" {
            dataCheckLabel.text = "아직 감상한 작품이\n없습니다."
            dataCheckImageView.isHidden = false
            dataCheckLabel.isHidden = false
        } else if status == "bookMark" {
            dataCheckLabel.text = "아직 찜한 작품이\n없습니다."
            dataCheckImageView.isHidden = false
            dataCheckLabel.isHidden = false
        } else {
            dataCheckImageView.isHidden = true
            dataCheckLabel.isHidden = true
        }
    }
    
    /// Tag리스트를 불러오는 통신 함수
    private func getTagList() {
        MyCategorysService.shared.getMyCategorys { [weak self] (res) in
            guard let self = self else { return }
            self.dataList.removeAll()
            self.tagList.removeAll()
            guard let list = res else { return }
            self.tagList = list
            self.dataCheck(status: self.status)
        }
    }
    
    /// 툰 리스트를 status에 따라 통신하는 함수
    private func getToonList(status: String) {
        if status == "recent" {
            LatestService.shared.getLatestToon { [weak self] (res) in
                guard let self = self else { return }
                if res == nil {
                    self.dataCheck(status: self.status)
                } else {
                    self.dataCheck(status: " ")
                }
                self.dataList.removeAll()
                self.tagList.removeAll()
                guard let list = res else { return }
                self.dataList = list
            }
            
        } else if status == "bookMark" {
            FavoriteService.shared.getFavoriteToon { [weak self] (res) in
                guard let self = self else { return }
                if res == nil {
                    self.dataCheck(status: self.status)
                } else {
                    self.dataCheck(status: " ")
                }
                self.dataList.removeAll()
                self.tagList.removeAll()
                guard let list = res else { return }
                self.dataList = list
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func recentButtonDidTap(_ sender: UIButton) {
        mypageCollectionView.reloadData()
        if status != "recent"{
            tagSettingButton.isHidden = true
            status = "recent"
            getToonList(status: status)
            setButtonInit()
            recentButton.setImage(UIImage(named: "RecentOn"),
                                  for: .normal)
            recentButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func bookMarkButtonDidTap(_ sender: UIButton) {
        mypageCollectionView.reloadData()
        if status != "bookMark"{
            tagSettingButton.isHidden = true
            status = "bookMark"
            getToonList(status: status)
            setButtonInit()
            bookMarkButton.setImage(UIImage(named: "mypageBookmarkOn"),
                                    for: .normal)
            bookMarkButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func tagButtonDidTap(_ sender: UIButton) {
        mypageCollectionView.reloadData()
        if status != "tag"{
            tagSettingButton.isHidden = false
            status = "tag"
            getTagList()
            setButtonInit()
            tagButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
    }
    
    @IBAction func tagSettingButtonDidTap(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "KeywordSelectViewController") as? KeywordSelectViewController
            else {
                return
        }
        viewController.setLayoutMode(bool: true)
        self.navigationController?.pushViewController(viewController,
                                                      animated: true)
    }
    
}

// MARK: - UICollectionViewDataSource

extension MypageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if status == "tag" {
            return tagList.count
        } else {
            return dataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MypageCollectionViewCell",
                                 for: indexPath) as? MypageCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        if status == "tag" {
            if let tagName = tagList[indexPath.row].name {
                cell.setMypageCollectionViewTagCellProperties(tagName: tagName)
            }
        } else {
            let list = dataList[indexPath.row]
            if let label = list.toonName,
                let url = list.instaThumnailUrl {
                cell.setMypageCollectionViewToonCellProperties(labelText: label,
                                                               imageViewURL: url)
            }
        }
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension MypageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if status == "tag" {
            if let tag = tagList[indexPath.row].name {
                pushTagDetailViewController(keyword: tag)
            }
        } else {
            if let toonId = dataList[indexPath.row].toonID {
                pushDetailToonViewController(toonID: toonId)
            }
        }
    }
}
