//
//  AddToonViewController.swift
//  Toonie
//
//  Created by 양어진 on 23/03/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class AddToonViewController: GestureViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var recentToonButton: UIButton!
    @IBOutlet private weak var myToonButton: UIButton!
    @IBOutlet private weak var addToonButton: UIButton!
    @IBOutlet private weak var addToonCollectionView: UICollectionView!
    
    // MARK: - private var
    
    private var status = ""
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 화면 - 최근 본 목록
        status = "recent"
    }
    
    // MARK: - 버튼 눌리지 않은 상태로 만드는 함수
    
    private func setButtonInit() {
        
        myToonButton.setBackgroundImage(UIImage(named: "searchbutton"), for: .normal)
        recentToonButton.setBackgroundImage(UIImage(named: "searchbutton"), for: .normal)
        
        recentToonButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
        myToonButton.setTitleColor(#colorLiteral(red: 0.6079999804, green: 0.6079999804, blue: 0.6079999804, alpha: 1), for: .normal)
    }
    
    // MARK: - IBAction
    
    @IBAction func recentToonButtonDidTap(_ sender: Any) {
        
        if status != "recent" {
            setButtonInit()
            status = "recent"
            recentToonButton.setBackgroundImage(UIImage(named: "searchbuttonOn"), for: .normal)
            recentToonButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            addToonCollectionView.reloadData()
        }
        
    }
    
    @IBAction func myToonButtonDidTap(_ sender: Any) {
        
        if status != "myToon" {
            setButtonInit()
            status = "myToon"
            myToonButton.setBackgroundImage(UIImage(named: "searchbuttonOn"), for: .normal)
            myToonButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            addToonCollectionView.reloadData()
        }
        
    }
    
    @IBAction func addToonButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func exitButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource

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
        
        if status == "recent" {
            cell.toonImageView.image = UIImage(named: "addToonLoading")
            cell.toonTitleLabel.text = "최근 본 웹툰 목록임"
        } else if status == "myToon" {
            cell.toonImageView.image = UIImage(named: "addToonLoading")
            cell.toonTitleLabel.text = "북마크 웹툰 목록임"
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "AddToonCollectionViewCell",
                                 for: indexPath) as? AddToonCollectionViewCell
            else { return }
        
        cell.toonImageView.image = UIImage(named: "collectionAddCheck")
        
    }
}

// MARK: - UICollectionViewDelegate

extension AddToonViewController: UICollectionViewDelegate {
    
}
