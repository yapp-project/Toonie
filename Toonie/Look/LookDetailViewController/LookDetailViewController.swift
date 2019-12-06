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
    var selectedCategory: Categorys? = nil
    var selectedKeywordName: String {
        get{
            if let name = selectedCategory?.name {
                return name
            }
            return ""
        }
    }
    var selectedKeywordIdx: Int {
        get{
            if let index = selectedCategory?.idx {
                return index
            }
            return 0
        }
    }
    
    private var tag = "전체보기"
    private var toonDataList = [ToonInfoList]()
    private var toonList = [ToonOfTag]()
    private var selectedToonID: String?
    private var favoriteToon: [ToonList]?
    
    private var toonsAllList = [Toons]()
    private var tagsAllList = [Tags]()
    
    private var isFavorite = false
    
    // MARK: - Life Cycle
    
    //최초? : http://106.10.51.191/toon/category/1
    //태그? : http://106.10.51.191/toon/tag?tag=%EA%B0%95%EC%95%84%EC%A7%80
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LookDetailViewController  \(selectedKeywordName)")
        lookDetailTitleLabel.text = selectedCategory?.name
        if let selectedCategory = selectedCategory {
            setCollectionViewData(category: selectedCategory)
        }
        
        setCollectionViewLayout()
        registerForPreviewing(with: self, sourceView: lookDetailCollectionView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavoriteToon()
        
        CommonUtility.analytics(eventName: "LookDetailViewController",
                                param: ["token": (CommonUtility.getUserToken() ?? "toonie") + selectedKeywordName])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "topSetting" {
            if let viewController = segue.destination as? LookDetailTopSelectViewController {
                viewController.selectedKeyword = self.selectedKeywordName
                viewController.tagDidTapClosure = { [weak self]
                    (tagString) -> Void in
                    guard let self = self else { return }
                    self.tag = tagString
                    print("self.selectedKeyword : \(self.selectedKeywordName)")
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
    private func setCollectionViewData(category: Categorys) {
        //최초? : http://106.10.51.191/toon/category/1
        if tag == "전체보기" {
            CategoryToonAllListService
                .shared
                .getCategoryToonAllList(index: selectedKeywordIdx) { [weak self] (res) in
                    guard let self = self else { return }
                    guard let toonData = res else { return }
                    
                    if let tags = toonData.tags {
                        self.tagsAllList = tags
                    }
                    
                    if let toons = toonData.toons {
                        self.toonsAllList = toons
                    }
                    
                    self.lookDetailCollectionView.reloadData()
            }
            
        } else {
            LookToonOfTagService.shared
                .getLookToonOfTag(toonTag: tag,
                                  completion: { [weak self] res in
                                    guard let self = self else { return }
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
        lookDetailCollectionViewFlowLayout.itemSize =
            CGSize(width: UIScreen.main.bounds.width * 0.322,
                   height: UIScreen.main.bounds.width * 0.322)
        lookDetailCollectionViewFlowLayout.sectionInset =
            UIEdgeInsets(top: 0,
                         left: 5 * CommonUtility.getDeviceRatioWidth(),
                         bottom: 0,
                         right: 5 * CommonUtility.getDeviceRatioWidth())
        lookDetailCollectionViewFlowLayout.minimumLineSpacing =
            1.0 * CommonUtility.getDeviceRatioWidth()
    } 
    
    /// 인스타툰 상세정보 화면으로 이동
    private func pushDetailToonViewController(toonID: String) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "DetailToonView")
            as? DetailToonViewController {
            viewController.detailToonID = toonID
            CommonUtility.shared
                .mainNavigationViewController?
                .pushViewController(viewController,
                                    animated: true)
        }
        
    }
    
    ///타이틀 세팅
    func setLookDetailTitleLabel(titleString: String) {
        self.lookDetailTitleLabel.text = titleString
    }
    
    /// 찜한 툰 정보 네트워크 요청
    func loadFavoriteToon() {
        FavoriteService.shared.getFavoriteToon { [weak self] result in
            guard let self = self else { return }
            
            if let result = result {
                self.favoriteToon = result
            }
        }
    }
    
    /// 찜한 상태인지 확인
    private func checkFavoriteStatus(toonId: String) -> Bool {
        isFavorite = false
        guard let favoriteToon = favoriteToon else { return false }
        for index in 0..<favoriteToon.count
            where toonId == favoriteToon[index].toonID {
                isFavorite = true
                break
        }
        return isFavorite
    }
}

// MARK: - UICollectionViewDataSource

extension LookDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if tag == "전체보기" {
            return toonsAllList.count
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
            if let thumnailURL = toonsAllList[indexPath.item].imagePath {
                cell.setImageView(imageURL: thumnailURL)
            }
        } else {
            if let thumnailURL = toonDataList[indexPath.item].instaThumnailUrl {
                cell.setImageView(imageURL: thumnailURL)
            }
        }
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension LookDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        // ebpark : 툰상세 이동시... toonID 필요함... 현재 미개발(?) 상태인듯
//        if tag == "전체보기" {
//            if let toonId = toonAllList[indexPath.item].toonID {
//                pushDetailToonViewController(toonID: toonId)
//            }
//        } else {
//            if let toonId = toonDataList[indexPath.item].toonID {
//                pushDetailToonViewController(toonID: toonId)
//            }
//        }
    }
}

// MARK: - UIViewControllerPreviewingDelegate

extension LookDetailViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let storyboard = UIStoryboard.init(name: "Preview", bundle: nil)
        
        guard let previewVC = storyboard
            .instantiateViewController(withIdentifier: "PreviewVC") as? PreviewViewController
            else {
                preconditionFailure("Expected a PreviewViewController")
        }
        
        if let selectedIndexPath = lookDetailCollectionView
            .indexPathForItem(at: location) {
            previewVC.preferredContentSize = CGSize
                .init(width: UIScreen.main.bounds.width,
                      height: UIScreen.main.bounds.width)
            // ebpark : 툰상세 이동시... toonID 필요함... 현재 미개발(?) 상태인듯
//            selectedToonID = toonAllList[selectedIndexPath.item].toonID
            previewVC.toonID = selectedToonID
            previewVC.imageUrl = toonsAllList[selectedIndexPath.item].imagePath
            previewVC.isFavorite = checkFavoriteStatus(toonId: selectedToonID ?? "")
        }
        
        return previewVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing,
                           commit viewControllerToCommit: UIViewController) {
        
        pushDetailToonViewController(toonID: selectedToonID ?? "")
    }
    
}
