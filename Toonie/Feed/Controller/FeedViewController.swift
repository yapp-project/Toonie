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
    @IBOutlet private weak var tagView: UIView!
    @IBOutlet private weak var forYouCollectionView: UICollectionView!
    @IBOutlet private weak var recentCollectionView: UICollectionView!
    @IBOutlet private weak var favoriteCollectionView: UICollectionView!
    @IBOutlet private weak var recentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var favoriteViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var pieChartView: PieChartView!
    
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
    let items = ["인스타툰", "취향 태그"]
    let itemCount = [187, 58]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTagAnimationView()
        loadForYouToonList()
        loadLatestToonList()
        loadFavoriteToonList()
        updateView(&recentViewHeightConstraint, 0)
        updateView(&favoriteViewHeightConstraint, 0)
        
        customizeChart(dataPoints: items, values: itemCount.map{ Double($0) })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playTagAnimationView()
        loadFavoriteToon()
    }
    
    // MARK: - IBAction
    
    /// 피드>피드상세 이동
    @IBAction func moveFeedDetailDidTap(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RecommendViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Function
    
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
        }
         
        playTagAnimationView()
    }
    
    // 태그 애니메이션 재생
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

extension FeedViewController {
    
    func customizeChart(dataPoints: [String], values: [Double]) {
        
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i], data:  dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry)
        }
        
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: nil)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: dataPoints.count)
        
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        
        // 4. Assign it to the chart's data
        pieChartView.data = pieChartData
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
                colors.append(#colorLiteral(red: 0.9960784314, green: 0.2, blue: 0.003921568627, alpha: 1))
                colors.append(#colorLiteral(red: 1, green: 0.4666666667, blue: 0.007843137255, alpha: 1))
        colors.append(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))


        return colors
    }
}
