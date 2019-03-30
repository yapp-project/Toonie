//
//  LookDetailTopSelectViewController.swift
//  Toonie
//
//  Created by ebpark on 29/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class LookDetailTopSelectViewController: UIViewController {
    @IBOutlet weak var lookDetailTopSelectCollectionView: UICollectionView!
    
    //임시데이터
    let dummy =  ["전체보기",
                  "#유럽여행",
                  "#국내여행",
                  "#바캉스",
                  "#지하철여행",
                  "#뚜벅이여행"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    } 
}

// MARK: - UICollectionViewDataSource

extension LookDetailTopSelectViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "LookDetailTopSelectCell",
                                 for: indexPath) as? LookDetailTopSelectCell
            else { return UICollectionViewCell() }
        
        cell.setTitleLabel(text: dummy[indexPath.row])
        cell.setCellStatus(bool: indexPath.row == 0 ? true : false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? LookDetailTopSelectCell {
            
            for _ in 0...dummy.count {
                cell.setCellStatus(bool: false)
            }
            
            cell.setCellStatus(bool: !cell.getCellStatus())
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = dummy[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 42
        
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

        let keyword = dummy[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .medium,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 42
        
        return CGSize(width: width, height: 30)
    }
}
