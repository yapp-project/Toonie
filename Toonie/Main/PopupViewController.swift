//
//  PopupViewController.swift
//  Toonie
//
//  Created by ebpark on 28/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class PopupViewController: UIViewController {

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    private var tagAllWidth: Int = 0
    private var tagList = [String]()
    
    @IBOutlet weak var tagCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction private func closeButtonDidTap(_ sender: Any) {
        self.navigationController?.dismiss(animated: true,
                                           completion: nil)
        CommonUtility.shared
        .mainNavigationViewController?
            .dismiss(animated: false, completion: nil)
        
        UserDefaults.standard.set(Date.init(), forKey: "PopupCloseTime")
        
    }

    @IBAction private func recommendMoveDidTap(_ sender: Any) {
        CommonUtility.shared
            .mainNavigationViewController?.dismiss(animated: false, completion: {
                self.moveRecommend()
            })
        UserDefaults.standard.set(Date.init(), forKey: "PopupCloseTime")
    }
    
    private func moveRecommend() {
        let storyboard = UIStoryboard(name: "Feed", bundle: nil)
        if let viewController = storyboard
            .instantiateViewController(withIdentifier: "RecommendViewController")
            as? RecommendViewController {
            viewController.setTagSelectArray(selectArr: self.tagList)
            CommonUtility.shared
                .mainNavigationViewController?
                .pushViewController(viewController, animated: true)
        }
    }
    
    func setTagList(tagList: [String]?) {
        if let tagList = tagList {
            self.tagList = tagList
        }
    }


}

// MARK: - CollectionView : TagView - UICollectionViewDataSource
extension PopupViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell",
                                 for: indexPath) as? TagCollectionViewCell
            else { return UICollectionViewCell() }
        let titleName = tagList[indexPath.row]
        cell.setTitleLabel(titleName)
        
        cell.setCellStatus(bool: true)
        
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
        
        
        return CGSize(width: width, height: 30)
    }
    
}

// MARK: - CollectionView : TagView - UICollectionViewDelegate
extension PopupViewController: UICollectionViewDelegate {
 
}

// MARK: - CollectionView : TagView - UICollectionViewDelegateFlowLayout
extension PopupViewController: UICollectionViewDelegateFlowLayout {
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        let keyword = tagList[indexPath.row]
        let font = UIFont.getAppleSDGothicNeo(option: .regular,
                                              size: 14)
        var width = Int(keyword.widthWithConstrainedHeight(height: 17,
                                                           font: font))
        width += 28
    
        return CGSize(width: width, height: 30)
    }
}
