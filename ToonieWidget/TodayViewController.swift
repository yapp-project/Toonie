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
    
    private let defaults = UserDefaults(suiteName: "group.com.yapp.toonie.ToonieWidget")
    @IBOutlet private weak var widgetCollecionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        widgetCollecionView.reloadData()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

extension TodayViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: "WidgetCollectionViewCell",
                                 for: indexPath) as? WidgetCollectionViewCell
            else {
                return UICollectionViewCell()
        }
        
        cell.setWidgetCollectionViewCellProperties(tagName: "반려동물")
        
        return cell
    }
}

extension TodayViewController: UICollectionViewDelegate {
    
}
