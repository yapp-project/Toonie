//
//  FeedViewController.swift
//  Toonie
//
//  Created by 박은비 on 24/02/2019.
//  Copyright © 2019 Toonie. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //ebpark : 이거 임시라서.. 지워도 되는 부분입니다
        let testV: FeedFirstUIView = Bundle.main.loadNibNamed("FeedFirstUIView", owner: self, options: nil)?[0] as! FeedFirstUIView

        testV.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: UIScreen.main.bounds.width, height: 150))

        self.view.addSubview( testV )
        /***/
    }

}
