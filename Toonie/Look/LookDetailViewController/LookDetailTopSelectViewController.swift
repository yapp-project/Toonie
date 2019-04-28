//
//  LookDetailTopSelectViewController.swift
//  Toonie
//
//  Created by ebpark on 29/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class LookDetailTopSelectViewController: UIViewController {
  
    // MARK: - IBOutlets
    
    @IBOutlet weak var lookDetailTopSelectCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    //collectionView didSelected 했을시 호출할 클로저
    var tagDidTapClosure: ((String) -> Void)?
    var selectedKeyword: String = ""
    
    var tags = ["전체보기"]
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTags()
    }
    
    func setTags() {
        KeywordToonListService
            .shared
            .getKeywords(keyword: selectedKeyword) {(tags) in
                self.tags += tags ?? [String]()
                self.lookDetailTopSelectCollectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension LookDetailTopSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "LookDetailTopSelectCell",
                                 for: indexPath) as? LookDetailTopSelectCell
            else { return UICollectionViewCell() }
        
        cell.setTitleLabel(text: tags[indexPath.row])
        cell.setCellStatus(bool: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        if let closure = self.tagDidTapClosure {
            closure(tags[indexPath.row])
        }
        
        //우선 cell 상태 모두 초기화
        for index in 0...tags.count {
            let loopIndexPath = IndexPath.init(item: index, section: 0)
            if let cell = collectionView.cellForItem(at: loopIndexPath) as? LookDetailTopSelectCell {
                cell.setCellStatus(bool: false)
            }
        }
        
        //선택한 cell만 상태 변경
        if let cell = collectionView.cellForItem(at: indexPath) as? LookDetailTopSelectCell {
            cell.setCellStatus(bool: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = tags[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 48
        
        return CGSize(width: width, height: 30)
    }
    
}

// MARK: - UICollectionViewDelegate

extension LookDetailTopSelectViewController: UICollectionViewDelegate {
    
}

// MARK: - CollectionView : TagView - UICollectionViewDelegateFlowLayout

extension LookDetailTopSelectViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {

        let keyword = tags[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 48
        
        return CGSize(width: width, height: 30)
    }
}
