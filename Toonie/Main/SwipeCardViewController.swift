//
//  SwipeCardViewController.swift
//  Toonie
//
//  Created by ebpark on 30/05/2019.
//  Copyright © 2019 Yapp. All rights reserved.
//

import UIKit

class SwipeCardViewController: UIViewController  {
    
    @IBOutlet weak var cardBackgroundView: UIView!
    var dismissClosure: (() -> Void)?
    
    var card = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCard()
    }
    
    private func setCard() {
        let pileView = PileView(frame: self.frontCardViewFrame())
        pileView.popCardViewWithFrame = self.popCardViewWithFrame
        
        pileView.reloadContent()
        
        self.cardBackgroundView.addSubview(pileView)
    }
    
    private func popCardViewWithFrame(_ frame : CGRect) -> UIView? {
        if (card.count == 0) {
            return nil
        }
        
        let p : Card = card.removeLast()
        
        let imageView = UIImageView()
        
        if p.imageUrl != "swipeInfo" {
            imageView.imageFromUrl(p.imageUrl,
                                   defaultImgPath: "dum2")
        } else {
            imageView.image = UIImage.init(named: p.imageUrl)
        }
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = p.name
        
        return imageView
    }
    
    private func tappedImageView(_ sender : AnyObject) -> () {
        if let imageView = sender as? UIView {
            UIView.animate(withDuration: 0.5, animations: {
                imageView.alpha = 0
                imageView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            })
        }
    }
    
    private func frontCardViewFrame () -> CGRect {
        
        let width = self.view.frame.width * 0.8
        let height = width
        
        return CGRect(x: 0,
                      y: 0,
                      width: width,
                      height: height)
    }
    
    override func viewDidAppear(_ animated: Bool)  {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction private func closeButtonDidTap(_ sender: Any) {
        CommonUtility.shared
            .mainNavigationViewController?
            .dismiss(animated: false, completion: { [weak self] in
                guard let self = self else { return }
                
                if let closure = self.dismissClosure {
                    UserDefaults.standard.set(Date.init(), forKey: "SwipeCloseTime")
                    closure()
                }
            })
        
        
    }
}
