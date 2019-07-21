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
        
        return cell
    }
    
  
}

extension CommunityViewController: UITableViewDelegate {
    
}
