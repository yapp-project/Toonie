//
//  EditorPickView.swift
//  Toonie
//
//  Created by ebpark on 02/08/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class EditorPickView: UIView {
 
    // MARK: - Properties
    
    // MARK: - IBOutlets
    @IBOutlet private weak var editorCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        self.editorCollectionView.delegate = self
        self.editorCollectionView.dataSource = self
        
        let nibName = UINib(nibName: "EditorPickCollectionViewCell",
                            bundle: nil)
        editorCollectionView.register(nibName,
                                         forCellWithReuseIdentifier: "EditorPickCollectionViewCell")
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension EditorPickView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditorPickCollectionViewCell",
                                                            for: indexPath) as? EditorPickCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        return cell
    }
    
    
}

extension EditorPickView: UICollectionViewDelegate {
    
}
