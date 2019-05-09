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
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonUtility.sharedInstance.myPageNavigationViewController = self
    }
}

final class MypageViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var tagSettingButton: UIButton!
    @IBOutlet private weak var recentButton: UIButton!
    @IBOutlet private weak var bookMarkButton: UIButton!
    @IBOutlet private weak var tagButton: UIButton!
    @IBOutlet private weak var mypageCollectionView: UICollectionView!
    
    @IBOutlet weak var mypageCollectionViewFlowLayout: UICollectionViewFlowLayout!
    // MARK: - private var
    
    private var status = ""
    private var dataList: [ToonList] = []
    private var bookmarkList: [ToonList] = []
    private var tagList: [String] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 화면 - 최근 본 목록
        status = "recent"
        getToonList(status: status)
        mypageCollectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        goToFirstItem()
    }
    
    private func goToFirstItem() {
        self.mypageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                               at: .top,
                                               animated: true)
    }
    
    // MARK: - 함수
    
    private func setButtonInit() {
        
        recentButton.setImage(UIImage(named: "Recent"), for: .normal)
        bookMarkButton.setImage(UIImage(named: "mypageBookmark"), for: .normal)
        
        recentButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        bookMarkButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        tagButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        
    }
    
    private func goPushController(storyboardName: String,
                                  identifier: String) {
        let storyboard = UIStoryboard(name: "\(storyboardName)", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "\(identifier)")
        CommonUtility.sharedInstance.myPageNavigationViewController?
            .pushViewController(viewController, animated: true)
    }
    
    private func getTagList() {
        MyKeywordsService.shared.getMyKeywords { (res) in
            guard let list = res else { return }
            self.tagList = list
            self.mypageCollectionView.reloadData()
        }
    }
    
    private func getToonList(status: String) {
        
        if status == "recent" {
            LatestService.shared.getLatestToon { (res) in
                guard let list = res else { return }
                self.dataList = list
                self.mypageCollectionView.reloadData()
            }
            
        } else if status == "bookMark" {
            
            self.mypageCollectionView.reloadData()
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func recentButtonDidTap(_ sender: UIButton) {
        
        if status != "recent"{
            tagSettingButton.isHidden = true
            status = "recent"
            getToonList(status: status)
    
            setButtonInit()
            recentButton.setImage(UIImage(named: "RecentOn"), for: .normal)
            recentButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
        goToFirstItem()
    }
    
    @IBAction func bookMarkButtonDidTap(_ sender: UIButton) {
        if status != "bookMark"{
            tagSettingButton.isHidden = true
            status = "bookMark"
            getToonList(status: status)
            
            setButtonInit()
            bookMarkButton.setImage(UIImage(named: "mypageBookmarkOn"), for: .normal)
            bookMarkButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
        goToFirstItem()
    }
    
    @IBAction func tagButtonDidTap(_ sender: UIButton) {
        if status != "tag"{
            tagSettingButton.isHidden = false
            status = "tag"
            getTagList()
            
            setButtonInit()
            tagButton.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        }
        goToFirstItem()
    }
    
    @IBAction func tagSettingButtonDidTap(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard
            .instantiateViewController(withIdentifier: "KeywordSelectViewController") as? KeywordSelectViewController
            else {
                return
        }
        viewController.setLayoutMode(bool: true)
        self.navigationController?.pushViewController(viewController, animated: true)        
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
        
        cell.setMypageCollectionViewCellProperties()
        
        if status == "tag" {
            let tagName = tagList[indexPath.row]
            cell.mypageToonLabel.isHidden = false
            cell.mypageToonLabel.text = "#" + tagName
            cell.mypageToonImageView.image = UIImage(named: CommonUtility.tagImage(name: tagName))
            cell.mypageToonImageView.setCorner(cornerRadius: 5)
            
        } else {
            let list = dataList[indexPath.row]
            print("recentList : ", list)
            cell.mypageToonLabel.text = list.instaID
            cell.mypageToonImageView.imageFromUrl(list.instaThumnailUrl, defaultImgPath: "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if status == "tag" {
            goPushController(storyboardName: "Look",
                             identifier: "LookDetailViewController")
        } else {
            goPushController(storyboardName: "Detail",
                             identifier: "DetailToonView")
        }
    }
}

// MARK: - UICollectionViewDelegate

extension MypageViewController: UICollectionViewDelegate {
    
}
