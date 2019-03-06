//
//  LookViewController.swift
//  Toonie
//
//  Created by ebpark on 06/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class LookViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionViewLayout()
    }
    
    ///컬렉션 뷰 아이템 크기, 위치조정
    func setCollectionViewLayout() {
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.432 ,
                                                   height: (UIScreen.main.bounds.width * 0.432) * 0.95 )
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        collectionViewFlowLayout.minimumLineSpacing = 10.0
        collectionViewFlowLayout.minimumInteritemSpacing = 1.0
    }
}

extension LookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookCell",
                                                            for: indexPath) as? LookCell else {
                                                                return UICollectionViewCell()
        }
        
        cell.imageView.image = UIImage.init(named: "LookCategoryImg_\(indexPath.row + 1)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { 
        let storyboard = UIStoryboard(name: "Look", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "LookDetailViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
