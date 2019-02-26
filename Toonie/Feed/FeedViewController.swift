//
//  FeedViewController.swift
//  Toonie
//
//  Created by 박은비 on 24/02/2019.
//  Copyright © 2019 이재은. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testV : FeedFirstUIView = Bundle.main.loadNibNamed("FeedFirstUIView", owner: self, options: nil)?[0] as! FeedFirstUIView
        
        testV.frame = CGRect.init(origin:CGPoint.zero, size: CGSize.init(width:UIScreen.main.bounds.width , height: 150))
        
        self.view.addSubview( testV )
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
