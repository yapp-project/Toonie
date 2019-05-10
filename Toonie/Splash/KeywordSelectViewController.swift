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
    @IBOutlet weak var bigTitleLabel: UILabel!
    @IBOutlet weak var keywordCollecionView: UICollectionView!
    @IBOutlet weak var keywordFlowLayout: KTCenterFlowLayout!
    @IBOutlet weak var keywordCountLabel: UILabel!
    @IBOutlet weak var mainMoveButton: UIButton!
    
    private var layoutMode: Bool = false
    var keywordSelectArray = [String]()
    
    var keywords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserToken()
    
        if layoutMode == false {
            bigTitleLabel.text = "관심 있는 키워드를\n3개 이상 선택해주세요."
            mainMoveButton.setTitle("시작하기", for: .normal)
        } else {
            bigTitleLabel.text = "관심 있는 키워드를\n편집해주세요."
            mainMoveButton.setTitle("완료", for: .normal)
            print("내 서재에서 진입")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setKeywordValue()
        setSelectedKeywordValue()
    }
    
    ///시작하기 버튼-메인으로 이동
    @IBAction func startButtonDidTap(_ sender: UIButton) {
        //        print("선택한 키워드 \(keywordSelectArray)")
        // 누르면
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
    
    func setLayoutMode(bool: Bool) {
        layoutMode = bool
    }
    
    ///keywrods 값들 가져옴
    func setKeywordValue() {
        KeywordsService.shared.getKeywords { (result) in
            self.keywords = result ?? [String]()
            self.reloadKeywordCollectionView()
        }
    }
    
    ///사용자가 선택한 keywords를 가져옴
    func setSelectedKeywordValue() {
        MyKeywordsService.shared.getMyKeywords { (myKeywords) in
            self.keywordSelectArray = myKeywords ?? [String]()
            self.reloadKeywordCollectionView()
            self.reloadKeywordView()
        }
    }
    
    func reloadKeywordCollectionView() {
        DispatchQueue.main.async {
            self.keywordCollecionView.reloadData()
        }
    }
    
    ///기기에 UserToken값 없다면 서버에서 받아옴
    func setUserToken() {
        if CommonUtility.userToken == "" {
            TokenService.shared.getToken { result in
                UserDefaults.standard.set(result, forKey: "token")
            }
        }
        
    }
    
}

extension KeywordSelectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell",
                                                            for: indexPath) as? KeywordCell else {
                                                                return UICollectionViewCell()
        }
        
        cell.titleLabel.text = keywords[indexPath.row]
        
        cell.cellStatus = false
        
        //사용자가 선택한 키워드는 활성화처리
        for keywordSelect in keywordSelectArray
            where keywords[indexPath.row] == keywordSelect {
                cell.cellStatus = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = keywords[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 49, font: UIFont.systemFont(ofSize: 20)))
        
        return CGSize(width: width + 20, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeywordCell {
            let body = [
                "keywords": [self.keywords[indexPath.row]]
            ]
            
            MyKeywordsService.shared.postMyKeywords(params: body,
                                                    completion: {
                cell.cellStatus = !cell.cellStatus
                
                //선택한 키워드 추가 및 삭제
                if cell.cellStatus == true {
                    self.keywordSelectArray.append(self.keywords[indexPath.row])
                } else {
                    let findIndex = self.keywordSelectArray.firstIndex(of: cell.titleLabel.text ?? "")
                    
                    if let index = findIndex {
                        self.keywordSelectArray.remove(at: index)
                    }
                }
                
                //카운트레이블, 버튼 리로드
                self.reloadKeywordView()
            })
            
        }
    }
    
}

extension KeywordSelectViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let keyword = keywords[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 49, font: UIFont.systemFont(ofSize: 20)))
        
        return CGSize(width: width + 20, height: 50)
    }
}
