//
//  KeywordSelectViewController.swift
//  Toonie
//
//  Created by ebpark on 26/02/2019.
//  Copyright © 2019 Toonie. All rights reserved.
//

import UIKit
import KTCenterFlowLayout

final class KeywordSelectViewController: UIViewController {
    @IBOutlet weak var keywordCollecionView: UICollectionView!
    @IBOutlet weak var keywordFlowlayout: KTCenterFlowLayout!
    
    
    let dummy =  ["A",
                  "Ala",
                  "Ar",
                  "Ark",
                  "California",
                  "Colorado",
                  "Connecticut",
                  "Delaware",
                  "District Of Columbia",
                  "Florida",
                  "Georgia",
                  "Hawaii",
                  "Idaho",
                  "Illinois",
                  "Indiana",
                  "Iowa",
                  "Kansas",
                  "Kentucky",
                  "Louisiana",
                  "Maine",
                  "Maryland",
                  "Massachusetts",
                  "Michigan",
                  "Minnesota",
                  "Mississippi",
                  "Missouri",
                  "Montana",
                  "Nebraska",
                  "Nevada",
                  "New Hampshire",
                  "New Jersey",
                  "New Mexico",
                  "New York",
                  "North Carolina",
                  "North Dakota",
                  "Ohio",
                  "Oklahoma",
                  "Oregon",
                  "Pennsylvania",
                  "Rhode Island",
                  "South Carolina",
                  "South Dakota",
                  "Tennessee",
                  "Texas",
                  "Utah",
                  "Vermont",
                  "Virginia",
                  "Washington",
                  "West Virginia",
                  "Wisconsin",
                  "Wyoming"
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordFlowlayout.minimumInteritemSpacing = 3
        keywordFlowlayout.minimumLineSpacing = 3
        keywordFlowlayout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        keywordFlowlayout.estimatedItemSize = CGSize.init(width: 500, height: 30)
    }
}

extension KeywordSelectViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeywordCell", for: indexPath) as! KeywordCell
        
        cell.titleLabel.text = dummy[indexPath.row]
        
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let keyword = dummy[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 10, font: UIFont.systemFont(ofSize: 10)))
        
        return CGSize(width: width+3, height:30)
    }
}

extension KeywordSelectViewController :  UICollectionViewDelegateFlowLayout{
    private func collectionView(collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAtIndexPath indexPath:  IndexPath) -> CGSize {
        
        let keyword = dummy[indexPath.row]
        let width = Int(keyword.widthWithConstrainedHeight(height: 10, font: UIFont.systemFont(ofSize: 10)))
        
        print("확인해보자 \(width)")
        return CGSize(width: width+10, height:30)
    }
}

//
//extension KeywordSelectViewController : UICollectionViewDelegateFlowLayout{
//    private func collectionView(collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAtIndexPath indexPath:  IndexPath) -> CGSize {
//
//        let keyword = dummy[indexPath.row]
//        let width = Int(keyword.widthWithConstrainedHeight(height: 10, font: UIFont.systemFont(ofSize: 10)))
//
//        print("확인해보자 \(width)")
//        return CGSize(width: width+3, height:30)
//    }
//
//}
//



extension String {
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
}

