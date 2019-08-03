//
//  ToonieUseView.swift
//  Toonie
//
//  Created by ebpark on 02/08/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class ToonieUseView: UIView {
 
    @IBOutlet weak var toonieUseCollectionView: UICollectionView!
    @IBOutlet weak var toonieUseCollectionFlowview: UICollectionViewFlowLayout!
    @IBOutlet weak var toonieUsePageControl: UIPageControl!
    
    var itemCount = 3
    
    override func awakeFromNib() {
        self.toonieUseCollectionView.delegate = self
        self.toonieUseCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "ToonieUseCell",
                            bundle: nil)
        toonieUseCollectionView.register(nibName,
                                      forCellWithReuseIdentifier: "ToonieUseCell")

    }
    
    override func layoutSubviews() {
        toonieUsePageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }
    
}

extension ToonieUseView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToonieUseCell",
                                                            for: indexPath) as? ToonieUseCell
            else {
                return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

extension ToonieUseView: UICollectionViewDelegate {
    
}

extension ToonieUseView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        toonieUsePageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
