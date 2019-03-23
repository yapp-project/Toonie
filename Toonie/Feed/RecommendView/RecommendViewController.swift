//
//  RecommendViewController.swift
//  Toonie
//
//  Created by 이재은 on 18/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

// '지금 나는' 태그에 따른 인스타툰 추천 화면
final class RecommendViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var recommendTableView: UITableView!
    
    @IBOutlet weak var tagFrameView: UIView!
    @IBOutlet weak var tagScrollView: UIScrollView!
    
    ///이 수치에 따라 태그 줄수를 컨트롤 가능.
    @IBOutlet weak var tagScrollContentViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var tagCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var tagSelectedNotInfoView: UIView!
    
    // MARK: - Property
    
    //tagCollectionView 5줄 고정 위한 상수, 변수
    private let tagScrollContentViewWidthInitValue: CGFloat = 853
    private let maxTagItemWidth = 168
    
    ///item들을 일렬로 쭉 나열했을때의 max길이(간격포함)
    private let maxTagAllItemWidth = 4256
    
    private let maxTagCount = 31
    private let maxLine = 5
    
    /// tagAllWidth - 현재 뿌려질 태그 아이템들을 일렬로 늘어왔을때의 총 길이 (간격포함)
    private var tagAllWidth: Int = 0
    
    private var tagSelectArray = [String]()
    
    //임시데이터
    let dummy =  ["#이별의 상처를 치유하는",
                  "#받는 만큼 일하는 직장인",
                  "#고양이를 모시고 사는",
                  "#심리 치료하는",
                  "#한 템포 쉬고 싶은 백수",
                  "#취준 생활 공감",
                  "#이리저리 치이는 프리랜서",
                  "#귀여운 강아지",
                  "#힐링할 수 있는",
                  "#우울한 날을 함께하는",
                  "#쉽게 이해하는 페미니즘",
                  "#맛집을 소개하는",
                  "#훌쩍 해외로 떠나는",
                  "#공감되는 유학 생활",
                  "#연애 세포를 깨우는",
                  "#공감백배 다이어트",
                  "#유쾌한 알바썰",
                  "#로망을 가진 워홀생활",
                  "#짝사랑 공감",
                  "#평생 함께할 우정",
                  "화려한 솔로",
                  "#해외에서 생활하는",
                  "#미대생 야작 일기",
                  "#너무 다른 국제연애",
                  "#알콩달콩 결혼 생활",
                  "#하루하루 육아일기",
                  "#재미있는 자취일화",
                  "#세상을 시니컬하게 보는"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewXib()
        setTagFlowLayout()
        setTagScrollContent()
    }
    
    // MARK: - Function
    
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
        //        print("tagSelectArray \(tagSelectArray)")
        recommendTableView.reloadData()
    }
    
    @IBAction func backButtonDidTap(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        cell.recommentTitleLabel.text = tagSelectArray[reverseIndex]
        
        return cell
    }
}

// MARK: - CollectionView : TagView - UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        if maxTagCount < dummy.count {
            return maxTagCount
        }
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                 for: indexPath) as? TagCollectionViewCell
            else { return UICollectionViewCell() }
        cell.titleLabel.text = dummy[indexPath.row]
        cell.cellStatus = false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = dummy[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: UIFont.AppleSDOption.regular,
                                                     size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 22
        
        //최대길이제약 - 157
        if maxTagItemWidth < width {
            width = maxTagItemWidth
        }
        
        tagAllWidth += width
        
        //마지막 아니면 간격인 10씩 더해줌
        if dummy.count-1 != indexPath.row {
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
            cell.cellStatus = !cell.cellStatus
            
            //선택한 키워드 추가 및 삭제
            if cell.cellStatus == true {
                tagSelectArray.append(dummy[indexPath.row])
                
            } else {
                let findIndex = tagSelectArray.firstIndex(of: cell.titleLabel.text ?? "")
                
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
        let keyword = dummy[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: UIFont.AppleSDOption.regular,
                                                     size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 22
        
        //최대길이제약 - 157
        if maxTagItemWidth < width {
            width = maxTagItemWidth
        }
        
        return CGSize(width: width, height: 30)
    }
}
