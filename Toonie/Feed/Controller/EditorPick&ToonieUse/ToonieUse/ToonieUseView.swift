//
//  ToonieUseView.swift
//  Toonie
//
//  Created by ebpark on 02/08/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class ToonieUseView: UIView {
    // MARK: - Properties
    private var itemCount = 3
    
    // MARK: - IBOutlets
    @IBOutlet private weak var toonieUseCollectionView: UICollectionView!
    @IBOutlet private weak var toonieUseCollectionFlowview: UICollectionViewFlowLayout!
    @IBOutlet private weak var toonieUsePageControl: UIPageControl!
    
    // MARK: - Life Cycle
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
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

// MARK: - UIScrollViewDelegate
extension ToonieUseView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        toonieUsePageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
    }
}
