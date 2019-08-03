//
//  FeedViewController.swift
//  Toonie
//
//  Created by 박은비 on 24/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import Lottie
import SnapKit
import Charts

// Feed의 NavigationController
final class FeedNavigationController: UINavigationController {
    var rootViewController: UIViewController? {
        return viewControllers.first
    } 
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonUtility.sharedInstance
            .feedNavigationViewController = self
    }
}

// 홈 화면
final class FeedViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var recommendContainerView: UIView!
    @IBOutlet private weak var feedScrollView: UIScrollView!
    @IBOutlet private weak var forYouCollectionView: UICollectionView!
    @IBOutlet private weak var recentCollectionView: UICollectionView!
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    @IBOutlet private weak var recentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var favoriteViewHeightConstraint: NSLayoutConstraint!
    
    //최상단 renew
    @IBOutlet private weak var recmdCardView: UIView!
    @IBOutlet private weak var recmdCardRepresentLabel: UILabel!
    @IBOutlet private weak var recmdCardTitleLabel: UILabel!
    @IBOutlet private weak var recmdCardImageView: UIImageView!
    @IBOutlet private weak var recmdCardIdLabel: UILabel!
    @IBOutlet private weak var recmdCardTagLabel: UILabel!
    
    @IBOutlet private weak var editorPickView: UIView!
    @IBOutlet private weak var editorPickViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var guideView: UIView!
    @IBOutlet private weak var guideViewHeight: NSLayoutConstraint!
    
    // MARK: - Property
    
    private let recentViewHeight: CGFloat = 296
    private let favoriteViewHeight: CGFloat = 429
    
    private var tagAnimationView: AnimationView?
    private var forYouToonLists: [ToonList]?
    private var latestToonLists: [ToonList]?
    private var favoriteToonLists: [ToonList]?
    private var favoriteToon: [ToonList]?
    private var detailToonId = ""
    private var isFavorite = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setTagAnimationView()
        setRecmdCardLayout()
        setEditorPickLayout()
        setToonieUseLayout()
        
        loadForYouToonList()
        loadLatestToonList()
        loadFavoriteToonList()
        updateView(&recentViewHeightConstraint, 0)
        updateView(&favoriteViewHeightConstraint, 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        playTagAnimationView()
        loadFavoriteToon()
        
        CommonUtility.analytics(eventName: "FeedViewController",
                                param: ["token": CommonUtility.getUserToken() ?? "toonie"])
    }
    
    // MARK: - IBAction
    
    /// 피드>피드상세 이동
    @IBAction func moveFeedDetailDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func moveRecommendDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "RecommendPopupViewConroller")
            as? RecommendPopupViewConroller {
            viewController.modalPresentationStyle = .overCurrentContext
            
            CommonUtility.sharedInstance
                .mainNavigationViewController?
                .present(viewController,
                         animated: false,
                         completion:nil)
        }
    }
    // MARK: - Function
    private func setEditorPickLayout() {
        if let view = Bundle.main
            .loadNibNamed("EditorPickView",
                          owner: self,
                          options: nil)?.first as? UIView {
            self.editorPickView.addSubview(view)
        } else {
            //없으면 해당 뷰의 height길이 0으로
            editorPickViewHeight.constant = 0
        }
    }
    
    private func setToonieUseLayout() {
        if let view = Bundle.main
            .loadNibNamed("ToonieUseView",
                          owner: self,
                          options: nil)?.first as? UIView {
            self.guideView.addSubview(view)
        } else {
            //없으면 해당 뷰의 height길이 0으로
            guideViewHeight.constant = 0
        }
    }

    private func setRecmdCardLayout() {
        self.recmdCardView.setCorner(cornerRadius:10)
        self.recmdCardImageView.setCorner(cornerRadius: self.recmdCardImageView.frame.width / 1.8)
    }
    
    ///초기화
    func resetArray() {
        latestToonLists = [ToonList]()
        favoriteToonLists = [ToonList]()
    }
    
    /// 당신을 위한 툰 정보 네트워크 요청
    private func loadForYouToonList() {
        ToonListService.shared.getForYouToonList { [weak self] result in
            guard let self = self else { return }
            if let result = result {
                if result.count <= 10 {
                    self.forYouToonLists = result
                } else {
                    self.forYouToonLists = makeRandomList(result,
                                                          number: 10)
                    
                }
                self.forYouCollectionView.reloadData()
            }
        }
    }
    
    /// 최신 본 작품과 연관된 정보 네트워크 요청
    private func loadLatestToonList() {
        ToonListService.shared.getLatestToonList { [weak self] result in
            guard let self = self else { return }
            if let result = result {
                if result.count <= 10 {
                    self.latestToonLists = result
                } else {
                    self.latestToonLists = makeRandomList(result,
                                                          number: 10)
                }
            }
            if self.latestToonLists?.count ?? 0 > 0 {
                self.updateView(&self.recentViewHeightConstraint, self.recentViewHeight)
            }
            self.recentCollectionView.reloadData()
        }
    }
    
    /// 찜한 툰과 연관된 목록 정보 네트워크 요청
    private func loadFavoriteToonList() {
        ToonListService.shared.getFavoriteToonList { [weak self] result in
            guard let self = self else { return }
            if let result = result {
                if result.count <= 10 {
                    self.favoriteToonLists = result
                } else {
                    self.favoriteToonLists = makeRandomList(result,
                                                            number: 10)
                }
            }
            if self.favoriteToonLists?.count ?? 0 > 0 {
                self.updateView(&self.favoriteViewHeightConstraint, self.favoriteViewHeight)
            }
            self.favoriteCollectionView.reloadData()
        }
    }
    
    /// 찜한 툰 정보 네트워크 요청
    func loadFavoriteToon() {
        FavoriteService.shared.getFavoriteToon { [weak self] result in
            guard let self = self else { return }
            
            if let result = result {
                self.favoriteToon = result
            }
            self.reloadCollectionView()
        }
    }
    
    /// 컬렉션뷰 리로드
    private func reloadCollectionView() {
        self.forYouCollectionView.reloadData()
        self.recentCollectionView.reloadData()
        self.favoriteCollectionView.reloadData()
    }
    
    /// 인스타툰 상세정보 화면으로 이동
    private func pushDetailToonViewController(toonID: String, isFavorite: Bool) {
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
    
    /// 뷰 높이 constant 0으로 해서 없앰
    private func updateView(_ constraint: inout NSLayoutConstraint,
                            _ hegiht: CGFloat) {
        constraint.constant = hegiht
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

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == forYouCollectionView {
            return forYouToonLists?.count ?? 0
        } else if collectionView == recentCollectionView {
            return latestToonLists?.count ?? 0
        } else if collectionView == favoriteCollectionView {
            return favoriteToonLists?.count ?? 0
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == forYouCollectionView {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "forYouCell",
                                     for: indexPath) as? ForYouCollectionViewCell
                else { return UICollectionViewCell() }
            if let forYouToonList = forYouToonLists?[indexPath.item] {
                cell.setForYouCollectionViewCellProperties(forYouToonList)
                isFavorite = checkFavoriteStatus(toonId: forYouToonList.toonID ?? "")
                cell.setBookMarkButton(isFavorite)
            }
            return cell
            
        } else if collectionView == recentCollectionView {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "recentCell",
                                     for: indexPath) as? RecentCollectionViewCell
                else { return UICollectionViewCell() }
            if let latestToonList = latestToonLists?[indexPath.item] {
                cell.setRecentCollectionViewCellProperties(latestToonList)
                isFavorite = checkFavoriteStatus(toonId: latestToonList.toonID ?? "")
                cell.setBookMarkButton(isFavorite)
            }
            return cell
            
        } else if collectionView == favoriteCollectionView {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "favoriteCell",
                                     for: indexPath) as? FavoriteCollectionViewCell
                else { return UICollectionViewCell() }
            if let favoriteToonList = favoriteToonLists?[indexPath.item] {
                cell.setFavoriteCollectionViewCellProperties(favoriteToonList)
                isFavorite = checkFavoriteStatus(toonId: favoriteToonList.toonID ?? "")
                cell.setBookMarkButton(isFavorite)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let currentCell = collectionView.cellForItem(at: indexPath) as? ForYouCollectionViewCell {
            detailToonId = currentCell.toonIdLabel.text ?? ""
        }
        if let currentCell = collectionView.cellForItem(at: indexPath) as? RecentCollectionViewCell {
            detailToonId = currentCell.toonIdLabel.text ?? ""
        }
        if let currentCell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell {
            detailToonId = currentCell.toonIdLabel.text ?? ""
        }
        pushDetailToonViewController(toonID: detailToonId, isFavorite: isFavorite)
    }
}
