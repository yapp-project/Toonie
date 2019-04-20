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
    
    // MARK: - private var
    
    private var status = ""
    
    // MARK: - DummyList
    
    private var mypageList: [MyPage] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMypageData()
        
        // 초기 화면 - 최근 본 목록
        status = "recent"
        mypageCollectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goToFirstItem()
    }
    
    private func goToFirstItem() {
        self.mypageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                               at: .top,
                                               animated: true)
    }
    
    // MARK: - 버튼 눌리지 않은 상태로 만드는 함수
    
    private func setButtonInit() {
        
        recentButton.setImage(UIImage(named: "Recent"), for: .normal)
        bookMarkButton.setImage(UIImage(named: "mypageBookmark"), for: .normal)
        
        recentButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        bookMarkButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        tagButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        
    }
    
    func goPushController(storyboardName: String,
                          identifier: String) {
        let storyboard = UIStoryboard(name: "\(storyboardName)", bundle: nil)
        let viewController = storyboard
            .instantiateViewController(withIdentifier: "\(identifier)")
        CommonUtility.sharedInstance.myPageNavigationViewController?
            .pushViewController(viewController, animated: true)
    }
    
    // MARK: - IBAction
    
    @IBAction func recentButtonDidTap(_ sender: UIButton) {
        
        if status != "recent"{
            tagSettingButton.isHidden = true
            status = "recent"
            mypageCollectionView.reloadData()
            
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
            mypageCollectionView.reloadData()

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
            mypageCollectionView.reloadData()
            
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
        return mypageList.count
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
        
        if status == "recent" {
            cell.mypageToonLabel.text = "최근 본 작품"
        } else if status == "bookMark" {
            cell.mypageToonLabel.text = "찜한 목록 작품"
        } else if status == "tag" {
            cell.mypageToonLabel.isHidden = true
            cell.mypageToonImageView.setCorner(cornerRadius: 5)
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if status == "recent" {
            goPushController(storyboardName: "Detail",
                             identifier: "DetailToonView")
        } else if status == "bookMark" {
            goPushController(storyboardName: "Detail",
                             identifier: "DetailToonView")
        } else if status == "tag" {
            goPushController(storyboardName: "Look",
                             identifier: "LookDetailViewController")
        }
    }

//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        if status == "tag" {
//            return 0.0
//        } else {
//            return 10.0
//        }
//    }
    
}

// MARK: - UICollectionViewDelegate

extension MypageViewController: UICollectionViewDelegate {
    
}

// 더미 모델에 더미 데이터 집어넣기
extension MypageViewController {
    func setMypageData() {
        let myPage1 = MyPage(image: "", title: "내 컬렉션 1번", status: "recent")
        let myPage2 = MyPage(image: "", title: "내 컬렉션 2번", status: "recent")
        let myPage3 = MyPage(image: "", title: "내 컬렉션 3번", status: "recent")
        let myPage4 = MyPage(image: "", title: "내 컬렉션 4번", status: "recent")
        let myPage5 = MyPage(image: "", title: "내 컬렉션 5번", status: "recent")

        mypageList = [myPage1, myPage2, myPage3, myPage4, myPage5]
    }
}
