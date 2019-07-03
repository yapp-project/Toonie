//
//  RecommendViewController.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는' 태그에 따른 인스타툰 추천 화면
final class RecommendViewController: GestureViewController {
    
    //tagCollectionView 5줄 고정 위한 상수, 변수
    private let tagScrollContentViewWidthInitValue: CGFloat = 672
    private let maxTagItemWidth = 168
    
    ///item들을 일렬로 쭉 나열했을때의 max길이(간격포함)
    private let maxTagAllItemWidth = 4256
    
    private let maxTagCount = 31
    private let maxLine = 5
    
    /// tagAllWidth - 현재 뿌려질 태그 아이템들을 일렬로 늘어왔을때의 총 길이 (간격포함)
    private var tagAllWidth: Int = 0
    private var tagList = [String]()
    private var tagSelectArray = [String]()
    
    private var isFavorite = false
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var recommendTableView: UITableView!
    
    @IBOutlet private weak var tagFrameView: UIView!
    @IBOutlet private weak var tagScrollView: UIScrollView!
    
    ///이 수치에 따라 태그 줄수를 컨트롤 가능.
    @IBOutlet private weak var tagScrollContentViewWidth: NSLayoutConstraint!
    
    @IBOutlet private weak var tagCollectionView: UICollectionView!
    @IBOutlet private weak var tagCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var tagSelectedNotInfoView: UIView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurationTagList()
        setTableViewXib()
        setTagFlowLayout()
        setTagScrollContent()
        
        // test
//        getToonOfTagList(tag: "알콩달콩 결혼 생활")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadTagTableView()
        
        CommonUtility.analytics(eventName: "RecommendViewController",
                                param: ["token": CommonUtility.getUserToken() ?? "toonie"])
    }
    
    // MARK: - IBActions
    @IBAction func backButtionDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Function
    
    func getCurationTagList() {
        RecommendService.shared.getRecommends { [weak self] res in
            guard let self = self else { return }
            self.tagList = res
            self.tagCollectionView.reloadData()
        }
    }
    
//    func getToonOfTagList(tag: String) {
//        CurationTagService.shared.getCurationTagList(tagName: tag) { res in
//            // test
//            print("res : ", res!)
//        }
//    }
//    
    ///cell xib 이용
    func setTableViewXib() {
        let nibName = UINib(nibName: "RecommendTableViewCell",
                            bundle: nil)
        recommendTableView.register(nibName,
                                    forCellReuseIdentifier: "RecommendTableViewCell")
    }
    
    ///tagFlowLayout 프로퍼티 설정
    func setTagFlowLayout() {
        tagCollectionViewFlowLayout.minimumInteritemSpacing = 10
        tagCollectionViewFlowLayout.minimumLineSpacing = 9 //라인 사이의 최소간격
        tagCollectionViewFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        tagCollectionViewFlowLayout.estimatedItemSize = CGSize.init(width: 20, height: 30)
    }
    
    ///스크롤링 될 영역, 초기 보여질 영역 세팅
    func setTagScrollContent() {
        DispatchQueue.main.async {
            let leftMagin = (self.tagScrollContentViewWidth.constant - self.view.bounds.width) / 2
            self.tagScrollView.contentInset = UIEdgeInsets.init(top: 0,
                                                                left: leftMagin + 20,
                                                                bottom: 0,
                                                                right: 20)
        }
    }
    
    ///태그 선택할때
    func reloadTagTableView() {
        print("tagSelectArray \(tagSelectArray)")
        recommendTableView.reloadData()
    }
    
    func setTagSelectArray(selectArr: [String]?) {
        if let selectArr = selectArr {
            tagSelectArray = selectArr
        }
    }
    
}

// MARK: - TableView : 전체를 이루는 뷰
extension RecommendViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        if tagSelectArray.count == 0 {
            tagFrameView.bounds = CGRect.init(x: 0,
                                              y: 0,
                                              width: self.view.bounds.width,
                                              height: tableView.bounds.height)
            tagSelectedNotInfoView.isHidden = false
        } else {
            tagFrameView.bounds = CGRect.init(x: 0,
                                              y: 0,
                                              width: self.view.bounds.width,
                                              height: 326)
            tagSelectedNotInfoView.isHidden = true
        }
        return tagSelectArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: "RecommendTableViewCell",
                                 for: indexPath) as? RecommendTableViewCell
            else {
                return UITableViewCell()
        }
        
        //역순 노출
        let reverseIndex = tagSelectArray.count - (indexPath.row + 1)
        cell.setRecommentTitleLabel(titleString: tagSelectArray[reverseIndex])
      
        return cell
    }
}

// MARK: - CollectionView : TagView - UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if maxTagCount < tagList.count {
            return maxTagCount
        }
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                 for: indexPath) as? TagCollectionViewCell
            else { return UICollectionViewCell() }
        let titleName = tagList[indexPath.row]
        cell.setTitleLabel(titleString: titleName)
        
        cell.setCellStatus(bool: false)
        
        for arr in tagSelectArray {
            if arr == titleName {
                cell.setCellStatus(bool: true)
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = tagList[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .regular,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 28
        
        //최대길이제약 - 157
        if maxTagItemWidth < width {
            width = maxTagItemWidth
        }
        
        tagAllWidth += width
        
        //마지막 아니면 간격인 10씩 더해줌
        if tagList.count-1 != indexPath.row {
            tagAllWidth += 10
        } else {
            // 개수, 길이에 상관없이 5줄, 가운데 정렬을 위한 수치 계산.
            if tagScrollContentViewWidth.constant == tagScrollContentViewWidthInitValue { // 값이 초기값 그대로라면
                if maxTagAllItemWidth < tagAllWidth {
                    //한줄에 태그 몇개를 더 보여줘야 할지 계산 ,+1은 이 분기를 들어왔을때 하나는 이미 추가되어야 하기 때문
                    let addLineItemCount = (((tagAllWidth - maxTagAllItemWidth) / maxLine) / maxTagItemWidth) + 1
                    let addWidth = maxTagItemWidth * addLineItemCount
                    tagScrollContentViewWidth.constant += CGFloat(addWidth)
                }
            }
        }
        
        return CGSize(width: width, height: 30)
    }
    
}

// MARK: - CollectionView : TagView - UICollectionViewDelegate
extension RecommendViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? TagCollectionViewCell {
            cell.setCellStatus(bool: !cell.getCellStatus())
            
            //선택한 키워드 추가 및 삭제
            if cell.getCellStatus() == true {
                tagSelectArray.append(tagList[indexPath.row])
                
            } else {
                let findIndex = tagSelectArray.firstIndex(of: cell.getTitleString())
                
                if let index = findIndex {
                    tagSelectArray.remove(at: index)
                }
            }
            
            //카운트레이블, 버튼 리로드
            reloadTagTableView()
        }
    }
}

// MARK: - CollectionView : TagView - UICollectionViewDelegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let keyword = tagList[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .regular,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 28
        
        //최대길이제약 - 157
        if maxTagItemWidth < width {
            width = maxTagItemWidth
        }
        
        return CGSize(width: width, height: 30)
    }
}
