//
//  CommunityViewController.swift
//  Toonie
//
//  Created by 양어진 on 21/07/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

final class CommunityViewController: UIViewController {

    @IBOutlet private weak var communityTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

}

extension CommunityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunityTableViewCell",
                                                       for: indexPath) as? CommunityTableViewCell
            else {
                return UITableViewCell()
        }
        
        //임시//
        if indexPath.row == 1 {
            cell.recommendViewHeightConstraint.constant = 50
            cell.recommendButton.isHidden = false
            cell.recommendCollectionView.isHidden = true
            cell.contentsLabel.text = "요즘 직장상사 때문에 많이 힘든데 힘낼 수 있는 인스타툰 추천 받을 수 있을까요? 제가 LA에 살때가 생각나는데요. 요즘 직장상사 때문에 많이 힘든데 힘낼 수 있는 인스타툰 추천 받을 수 있을까요? 제가 LA에 살때가 생각나는데요. 요즘 직장상사 때문에 많이 힘든데 힘낼 수 있는 인스타툰 추천 받을 수 있을까요? 제가 LA에 살때가 생각나는데요."
        
        } else {
            cell.recommendViewHeightConstraint.constant = 102
            cell.recommendButton.isHidden = true
            cell.recommendCollectionView.isHidden = false
            
        }
        
//        cell.layer.borderWidth = 8
//        cell.layer.borderColor = #colorLiteral(red: 1, green: 0.9580548406, blue: 0.8891072869, alpha: 1)
        
        return cell
    }
    
}

extension CommunityViewController: UITableViewDelegate {
    
}
