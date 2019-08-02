//
//  ToonieUseView.swift
//  Toonie
//
//  Created by ebpark on 02/08/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class ToonieUseView: UIView {

    @IBOutlet weak var toonieLabel: UILabel!
    override func awakeFromNib() {
        toonieLabel.text = "투니스"
    }

}
