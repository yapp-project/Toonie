//
//  TodayViewController.swift
//  ToonieWidget
//
//  Created by 양어진 on 26/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit
import NotificationCenter

final class TodayViewController: UIViewController, NCWidgetProviding {

    // MARK: - IBOutlet
    @IBOutlet private weak var widgetCollecionView: UICollectionView!
    @IBOutlet private weak var curtionButton: UIButton!
    
    // MARK: - Property

    private let tagArray = ["가족", "반려동물", "사랑 연애", "심리 감정", "여행",
                            "음식", "자기계발", "자취생활", "직업", "페미니즘", "학교생활", "해외"]
    private var tagList: [String] = []

    // MARK: - IBAction

    @IBAction func curationButton(_ sender: Any) {
        
        let url = URL(string: "Toonie://")!
        self.extensionContext?.open(url, completionHandler: { (success) in
            if (!success) {
                print("error: failed to open app from Today Extension")
            }
        })
        
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        curtionButton.setTitle("추천\n받기", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tagList = makeRandomList(tagArray, number: 4)
        widgetCollecionView.reloadData()
    }

    // MARK: - Function

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

// MARK: - UICollectionViewDataSource

extension TodayViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "WidgetCollectionViewCell",
                                 for: indexPath) as? WidgetCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        let tag = tagList[indexPath.row]
        cell.setWidgetCollectionViewCellProperties(tagName: tag)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension TodayViewController: UICollectionViewDelegate {
    
}
