//
//  LookViewController.swift
//  Toonie
//
//  Created by ebpark on 06/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

///둘러보기 메인 - 하단 탭 둘러보기로 진입
final class LookViewController: UIViewController {
    @IBOutlet weak var mainCategoryCollectionView: UICollectionView!
    @IBOutlet weak var mainCategoryCollectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout()
    }
    
    ///컬렉션 뷰 아이템 크기, 위치조정
    func setCollectionViewLayout() {
        mainCategoryCollectionViewFlowLayout.scrollDirection = .vertical
        mainCategoryCollectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.432 ,
                                                   height: (UIScreen.main.bounds.width * 0.432) * 0.95 )
        mainCategoryCollectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        mainCategoryCollectionViewFlowLayout.minimumLineSpacing = 10.0
        mainCategoryCollectionViewFlowLayout.minimumInteritemSpacing = 1.0
    }
}

extension LookViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //대분류 카테고리 갯수는 우선 고정.
        return 12
    }
}
extension LookViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookCell",
                                                            for: indexPath) as? LookCell else {
                                                                return UICollectionViewCell()
        }
        
        cell.backgroundImageView.image = UIImage.init(named: "LookCategoryImg_\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { 
        let storyboard = UIStoryboard(name: "Look", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LookDetailViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
