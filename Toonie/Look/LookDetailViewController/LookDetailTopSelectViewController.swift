//
//  LookDetailTopSelectViewController.swift
//  Toonie
//
//  Created by ebpark on 29/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

struct TagStructure {
    let tagName: String
    var state: Bool
}

final class LookDetailTopSelectViewController: UIViewController {
  
    // MARK: - IBOutlets
    
    @IBOutlet weak var lookDetailTopSelectCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    //collectionView didSelected 했을시 호출할 클로저
    var tagDidTapClosure: ((String) -> Void)?
    var selectedKeyword: String = ""
    
    //state로 on off 진행
    var tags = [TagStructure]()
    private var toonAllList = [ToonList]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //맨처음 전체보기 기본세팅
        setTags()
    }
    
    func setTags() {
        let tagStructure: TagStructure = TagStructure.init(tagName: "전체보기",
                                                           state: true)
        tags.append(tagStructure)
        
        KeywordToonListService
            .shared
            .getKeywords(keyword: selectedKeyword) {(tags) in
                for tag in tags ?? [String]() {
                    self.tags.append(TagStructure.init(tagName: "#"+tag,
                                                       state: false))
                }
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
  
        cell.setTitleLabel(text: tags[indexPath.row].tagName)
        cell.setCellStatus(bool: tags[indexPath.row].state)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {

        if let closure = self.tagDidTapClosure {
            closure(tags[indexPath.row]
                .tagName
                .replacingOccurrences(of: "#",
                                      with: ""))
        }
        
        //우선 cell 상태 모두 초기화
        for index in 0..<tags.count {
            tags[index].state = false
        }
        
        //선택한 cell만 상태 변경
        tags[indexPath.row].state = true
        
        self.lookDetailTopSelectCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = tags[indexPath.row].tagName
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 41
        
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

        let keyword = tags[indexPath.row].tagName
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 41
        
        return CGSize(width: width, height: 30)
    }
}
