//
//  AddToonViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class AddToonViewController: GestureViewController {
    @IBOutlet weak var recentToonButton: UIButton!
    @IBOutlet weak var myToonButton: UIButton!
    @IBOutlet weak var addToonCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func recentToonButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func myToonButtonDidTap(_ sender: Any) {
    }
    
    @IBAction func exitButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddToonViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "AddToonCollectionViewCell",
                                 for: indexPath) as? AddToonCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        cell.setAddToonCollectionViewCellProperties()
        
        cell.toonImageView.image = UIImage(named: "addToonLoading")
        cell.toonTitleLabel.text = "addToon입니다"
        
        return cell
    }
    
}

extension AddToonViewController: UICollectionViewDelegate {
    
}
