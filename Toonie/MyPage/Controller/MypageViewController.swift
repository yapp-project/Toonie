//
//  MypageViewController.swift
//  Toonie
//
//  Created by 양어진 on 04/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class MypageViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tagSettingButton: UIButton!
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var myCollectionButton: UIButton!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    @IBOutlet weak var mypageCollectionView: UICollectionView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mypageCollectionView.dataSource = self
        mypageCollectionView.delegate = self
    }
    
    // MARK: - IBAction
    
    @IBAction func recentButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func myCollectionButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func bookMarkButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func tagButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func tagSettingButtonAction(_ sender: UIButton) {
    }
}

    // MARK: - UICollectionViewDataSource

extension MypageViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "MypageCollectionViewCell",
                                 for: indexPath) as? MypageCollectionViewCell
            else { return UICollectionViewCell() }
        cell.setMypageCollectionViewCellProperties()
        
        return cell
        
    }
    
}

extension MypageViewController: UICollectionViewDelegate {
    
}
