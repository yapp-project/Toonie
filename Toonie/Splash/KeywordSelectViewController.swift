//
//  KeywordSelectViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import KTCenterFlowLayout

final class KeywordSelectViewController: GestureViewController {
    @IBOutlet weak var keywordCollecionView: UICollectionView!
    @IBOutlet weak var keywordFlowLayout: KTCenterFlowLayout!
    @IBOutlet weak var keywordCountLabel: UILabel!
    @IBOutlet weak var mainMoveButton: UIButton!
    
    var keywordSelectArray = [String]()
    
    //임시데이터
    
     let dummy   =  ["#학교생활",
                  "#직업",
                  "#자기계발",
                  "#해외",
                  "#심리•감정",
                  "#여행",
                  "#자취생활",
                  "#음식",
                  "#반려동물",
                  "#가족",
                  "#사랑•연애",
                  "#페미니즘"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setKeywords()
        setKeywordFlowLayout()
    }
    
    ///시작하기 버튼-메인으로 이동
    @IBAction func startButtonDidTap(_ sender: UIButton) {
//        print("선택한 키워드 \(keywordSelectArray)")
        
        TokenService().getToken(url: API.token) { (res) in
            print("asdf\(res)")
        }
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "RootViewController")
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    ///keywordFlowLayout 프로퍼티 설정
    func setKeywordFlowLayout() {
        keywordFlowLayout.minimumInteritemSpacing = 10
        keywordFlowLayout.minimumLineSpacing = 20 * CommonUtility.getDeviceRatioHieght()     //라인 사이의 최소간격
        keywordFlowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 5, bottom: 0, right: 5)
        keywordFlowLayout.estimatedItemSize = CGSize.init(width: 95, height: 50)
    }
    
    ///키워드 선택할때마다 카운트레이블, 버튼 리로드
    func reloadKeywordView() {
        keywordCountLabel.text = "\(keywordSelectArray.count)개"
        
        if 3 <= keywordSelectArray.count {
            //버튼상태 바꿈
            mainMoveButton.isEnabled = true
            mainMoveButton.backgroundColor = UIColor.clear // 그라디언트 소스코드로 적용해야함.
        } else {
            mainMoveButton.isEnabled = false
            mainMoveButton.backgroundColor = UIColor.init(named: "disabledButton")
          // color disableButton 오류
        }
    }
    
    ///키워드 서버에서 받아옴
    func setKeywords() {
        KeywordsService().getKeywords(url: API.keywords, completion: { (res) in
//            let resTest : NetworkResult<Keywords> = res as NetworkResult<Keywords>
            
        })
    }
}

extension KeywordSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell",
                                                            for: indexPath) as? KeywordCell else {
            return UICollectionViewCell()
        }

        cell.titleLabel.text = dummy[indexPath.row]
        cell.cellStatus = false
        
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let keyword = dummy[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 49, font: UIFont.systemFont(ofSize: 20)))

        return CGSize(width: width + 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeywordCell {
            cell.cellStatus = !cell.cellStatus
            
            //선택한 키워드 추가 및 삭제
            if cell.cellStatus == true {
                keywordSelectArray.append(dummy[indexPath.row])
            } else {
                let findIndex = keywordSelectArray.firstIndex(of: cell.titleLabel.text ?? "")
                
                if let index = findIndex {
                    keywordSelectArray.remove(at: index)
                }
            }
            
            //카운트레이블, 버튼 리로드
            reloadKeywordView()
        }
    }
    
}

extension KeywordSelectViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let keyword = dummy[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 49, font: UIFont.systemFont(ofSize: 20)))
        
        return CGSize(width: width + 20, height: 50)
    }
}
