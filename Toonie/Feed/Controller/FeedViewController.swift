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

// Feed의 NavigationController
final class FeedNavigationController: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        CommonUtility.sharedInstance.feedNavigationViewController = self
    }
}

// 홈 화면
final class FeedViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var recommendContainerView: UIView!
    @IBOutlet private weak var feedScrollView: UIScrollView!
    @IBOutlet private weak var tagView: UIView!
    @IBOutlet private weak var forYouCollectionView: UICollectionView!
    @IBOutlet private weak var recentCollectionView: UICollectionView!
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    @IBOutlet private weak var recentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var favoriteViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Property
    
    private var tagAnimationView: AnimationView?
    private var forYouToonLists: [ToonList]?
    private var toonsOfTag: [ToonInfoList]?
    private var detailToonId = ""
    private var isFavorite = false
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTagAnimationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadToon()
        playTagAnimationView()
    }
 
    // MARK: - IBAction
    
    /// 피드>피드상세 이동
    @IBAction func moveFeedDetailDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Function
    
    /// 툰 정보 네트워크 요청
    private func loadToon() {
        ForYouToonListService.shared.getForYouToonList { result in
            
            if let result = result {
                if result.count <= 10 {
                    self.forYouToonLists = result
                } else {
                    self.forYouToonLists = self.makeRandomList(result)
                }
            }
            self.forYouCollectionView.reloadData()
        }
        ToonOfTagService.shared.getToonOfTag { result in
            
            if let result = result {
                if result.count <= 10 {
                    self.toonsOfTag = result
                } else {
                    self.toonsOfTag = self.makeRandomList(result)
                }
            }
            self.recentCollectionView.reloadData()
            self.favoriteCollectionView.reloadData()
        }
    }
    
    /// 툰 랜덤 10개 목록 만들기
    private func makeRandomList<T>(_ list: [T]) -> [T] {
        var temporaryList = list
        var randomList: [T] = []
        for _ in 0..<10 {
            let index = Int(arc4random_uniform(UInt32((temporaryList.count - 1))))
            randomList.append(temporaryList[index])
            temporaryList.remove(at: index)
        }
        return randomList
    }
    
    /// tagAnimationView 세팅
    private func setTagAnimationView() {
        tagAnimationView = AnimationView(name: "newTag")
        if let tagAnimationView = tagAnimationView {
            tagAnimationView.contentMode = .scaleAspectFit
            tagView.addSubview(tagAnimationView)
            tagAnimationView.snp.makeConstraints { (make) -> Void in
                make.width.equalTo(tagView.bounds.width)
                make.height.equalTo(tagView.bounds.height)
                make.center.equalTo(tagView)
            }
            playTagAnimationView()
        }
    }
    
    private func playTagAnimationView() {
        tagAnimationView?.play()
    }
    
    /// 인스타툰 상세정보 화면으로 이동
    private func pushDetailToonViewController(toonID: String, isFavorite: Bool) {
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "DetailToonView")
            as? DetailToonViewController {
            viewController.detailToonID = toonID
            viewController.isFavorite = isFavorite
            CommonUtility.sharedInstance.mainNavigationViewController?
                .pushViewController(viewController,
                                    animated: true)
        }
        
    }
    
    /// 선택한 툰 타이틀로 툰 id 찾기
    private func findToonId(toonTitle: String) -> String {
        var toonId = ""
        if let forYouToonLists = forYouToonLists {
            for index in 0..<forYouToonLists.count
                where toonTitle == forYouToonLists[index].toonName {
                    toonId = forYouToonLists[index].toonID ?? ""
            }
        }
        if let toonsOfTag = toonsOfTag {
            for index in 0..<toonsOfTag.count
                where toonTitle == toonsOfTag[index].toonName {
                    toonId = toonsOfTag[index].toonID ?? ""
            }
        }
        return toonId
    }
    
    /// 뷰 높이 constant 0으로 해서 없앰
    private func removeView(_ height: NSLayoutConstraint) {
        height.constant = 0
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if collectionView == forYouCollectionView {
            return forYouToonLists?.count ?? 0
        } else if collectionView == recentCollectionView {
            if toonsOfTag?.count == 0 {
                removeView(recentViewHeightConstraint)
            }
            return toonsOfTag?.count ?? 0
        } else if collectionView == favoriteCollectionView {
            if toonsOfTag?.count == 0 {
                removeView(favoriteViewHeightConstraint)
            }
            return toonsOfTag?.count ?? 0
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
            }
            return cell
            
        } else if collectionView == recentCollectionView {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "recentCell",
                                     for: indexPath) as? RecentCollectionViewCell
                else { return UICollectionViewCell() }
            if let toonOfTag = toonsOfTag?[indexPath.item] {
                cell.setRecentCollectionViewCellProperties(toonOfTag)
            }
            return cell
            
        } else if collectionView == favoriteCollectionView {
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "favoriteCell",
                                     for: indexPath) as? FavoriteCollectionViewCell
                else { return UICollectionViewCell() }
            
            if let toonOfTag = toonsOfTag?[indexPath.item] {
                cell.setFavoriteCollectionViewCellProperties(toonOfTag)
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
            detailToonId = findToonId(toonTitle: currentCell.forYouToonTitleLabel.text ?? "")
            isFavorite = currentCell.bookMarkButton.isSelected
        }
        if let currentCell = collectionView.cellForItem(at: indexPath) as? RecentCollectionViewCell {
            detailToonId = findToonId(toonTitle: currentCell.recentToonTitleLabel.text ?? "")
            isFavorite = currentCell.bookMarkButton.isSelected
        }
        if let currentCell = collectionView.cellForItem(at: indexPath) as? FavoriteCollectionViewCell {
            detailToonId = findToonId(toonTitle: currentCell.favoriteToonTitleLabel.text ?? "")
            isFavorite = currentCell.bookMarkButton.isSelected
        }
        pushDetailToonViewController(toonID: detailToonId, isFavorite: isFavorite)
    }
}
