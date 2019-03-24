//
//  MypageViewController.swift
//  Toonie
//
//  Created by 양어진 on 04/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class MypageViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tagSettingButton: UIButton!
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var myCollectionButton: UIButton!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var mypageCollectionView: UICollectionView!
    
    // MARK: - DummyList
    var mypageList: [MyPage] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypageCollectionView.dataSource = self
        mypageCollectionView.delegate = self
        
        setMypageData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - IBAction
    
    @IBAction func recentButtonDidTap(_ sender: UIButton) {
    }
    
    @IBAction func myCollectionButtonDidTap(_ sender: UIButton) {
    }
    
    @IBAction func bookMarkButtonDidTap(_ sender: UIButton) {
        
    }
    
    @IBAction func tagButtonDidTap(_ sender: UIButton) {
        tagSettingButton.isHidden = false
    }
    
    @IBAction func tagSettingButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "KeywordSelectViewController")
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
        
        if indexPath.row == 0 {
            cell.mypageToonImageView.isHidden = true
            cell.mypageCollectionImageView.isHidden = false
            cell.mypageToonLabel.text = "새 컬렉션 만들기"
        } else {
            let mypage = mypageList[indexPath.row]
            cell.mypageToonImageView.image = UIImage(named: mypage.image)
            cell.mypageToonLabel.text = mypage.title
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
            let popViewController = storyboard.instantiateViewController(withIdentifier: "MypagePopUpViewController")
            self.addChild(popViewController)
            popViewController.view.frame = self.view.frame
            self.view.addSubview(popViewController.view)
            popViewController.didMove(toParent: self)
        } else {
            let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "MypageDetailViewController")
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

// MARK: - UICollectionViewDelegate

extension MypageViewController: UICollectionViewDelegate {
    
}

// 더미 모델에 더미 데이터 집어넣기
extension MypageViewController {
    func setMypageData() {
        let myPage1 = MyPage(image: "myRecentlyLoadingImg", title: "최근1번", status: "recent")
        let myPage2 = MyPage(image: "myRecentlyLoadingImg", title: "최근2번", status: "recent")
        let myPage3 = MyPage(image: "myRecentlyLoadingImg", title: "최근3번", status: "recent")
        let myPage4 = MyPage(image: "", title: "최근4번", status: "recent")
        let myPage5 = MyPage(image: "", title: "최근5번", status: "recent")

        mypageList = [myPage1, myPage2, myPage3, myPage4, myPage5]
    }
}
