//
//  LookDetailViewController.swift
//  Toonie
//
//  Created by ebpark on 06/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 상세 - LookViewController의 CollectionView의 didSelected시 이동되는 화면
final class LookDetailViewController: GestureViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var lookDetailTitleLabel: UILabel!
    @IBOutlet private weak var lookDetailCollectionView: UICollectionView!
    @IBOutlet private weak var lookDetailCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    // MARK: - Properties
    var selectedKeyword: String = ""
    private var tag = "전체보기"
    private var toonDataList = [ToonInfoList]()
    private var toonList = [ToonOfTag]()
    private var toonAllList = [ToonList]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lookDetailTitleLabel.text = selectedKeyword
        setCollectionViewData(keyword: selectedKeyword)
        setCollectionViewLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "topSetting" {
            if let viewController = segue.destination as? LookDetailTopSelectViewController {
                viewController.selectedKeyword = self.selectedKeyword
                viewController.tagDidTapClosure = {
                    (tagString) -> Void in
                    self.tag = tagString
                    print("self.selectedKeyword : \(self.selectedKeyword)")
                    self.setCollectionViewData(keyword: self.selectedKeyword)
                }
            }
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Function
    
    /// 컬렉션뷰 데이터 설정
    private func setCollectionViewData(keyword: String) {
        if tag == "전체보기" {
            KeywordToonAllListService
                .shared
                .getKeywordToonAllList(keyword: self.selectedKeyword,
                                       completion: { (res) in
                                        guard let toonData = res else { return }
                                        self.toonAllList = toonData
                                        self.lookDetailCollectionView.reloadData()
                })
            
        } else {
            LookToonOfTagService.shared
                .getLookToonOfTag(toonTag: tag,
                                  completion: { res in
                                    self.toonList = [res]
                                    guard let toonData = res.toonInfoList else { return }
                                    self.toonDataList = toonData
                                    self.lookDetailCollectionView.reloadData()
                })
        }
    }
    
    /// 컬렉션 뷰 아이템 크기, 위치조정
    private func setCollectionViewLayout() {
        lookDetailCollectionViewFlowLayout.scrollDirection = .vertical
        lookDetailCollectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.322 ,
                                                               height: UIScreen.main.bounds.width * 0.322)
        lookDetailCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0,
                                                                       left: 5 * CommonUtility.getDeviceRatioWidth(),
                                                                       bottom: 0,
                                                                       right: 5 * CommonUtility.getDeviceRatioWidth())
        lookDetailCollectionViewFlowLayout.minimumLineSpacing = 1.0 * CommonUtility.getDeviceRatioWidth()
    } 
    
    /// 인스타툰 상세정보 화면으로 이동
    private func pushDetailToonViewController(toonID: String) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
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
    
    ///타이틀 세팅
    func setLookDetailTitleLabel(titleString: String) {
        self.lookDetailTitleLabel.text = titleString
    }
}

// MARK: - UICollectionViewDataSource

extension LookDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if tag == "전체보기" {
            return toonAllList.count
        } else {
            return toonDataList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "LookDetailCell",
                                 for: indexPath) as? LookDetailCell
            else { return UICollectionViewCell() }

        if tag == "전체보기" {
            if let thumnailURL = toonAllList[indexPath.item].instaThumnailUrl {
                cell.setImageView(imageURL: thumnailURL)
            }
        } else {
            if let thumnailURL = toonDataList[indexPath.item].instaThumnailUrl {
                cell.setImageView(imageURL: thumnailURL)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if tag == "전체보기" {
            if let toonId = toonAllList[indexPath.item].toonID {
                pushDetailToonViewController(toonID: toonId)
            }
        } else {
            if let toonId = toonDataList[indexPath.item].toonID {
                pushDetailToonViewController(toonID: toonId)
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension LookDetailViewController: UICollectionViewDelegate {
    
}
