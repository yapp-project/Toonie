//
//  SwipeOptions.swift
//  PileView
//
//  Created by Jeff Barg on 6/16/14.
//  Copyright (c) 2014 Fructose Tech. All rights reserved.
//

import UIKit

class SwipeOptions {
    var swipeCancelledAnimationDuration : Double
    var swipeCancelledAnimationOptions : UIView.AnimationOptions
    var swipeAnimationDuration : CGFloat
    
    var swipeAnimationOptions : UIView.AnimationOptions
    var threshold : CGFloat
    
    var rotationFactor : CGFloat
    
    var onPan : ((PanState) -> ())
    var onChosen : ((SwipeResult) -> ())
    
    init()  {
        swipeCancelledAnimationDuration = 0.2
        swipeCancelledAnimationOptions = UIView.AnimationOptions.curveEaseOut
        
        swipeAnimationDuration = 0.15;
        swipeAnimationOptions = UIView.AnimationOptions.curveEaseIn;
        
        rotationFactor = 3.0;
        
        threshold = 100.0
        
        onPan = { _ -> () in }
        onChosen = { (result : SwipeResult) -> () in
            let duration = 0.15
            let options = UIView.AnimationOptions()
            
            let viewRect = result.view!.frame
            let superviewRect = result.view!.superview!.frame
            let translation = result.translation
            
            let destination = viewRect.extendOutOfBounds(superviewRect, translationVector: translation)
            
            UIView.animate(withDuration: duration, delay: 0.0, options: options, animations: {
                result.view!.frame = destination;
            }, completion: {(finished : Bool) -> () in
                if (finished) {
                    result.view!.removeFromSuperview()
                    result.onCompletion()
                }
            })
        }
    }
}
