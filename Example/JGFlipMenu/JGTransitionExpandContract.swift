//
//  JGTransitionExpandContract.swift
//  JGTransitions
//
//  Created by Jeff on 1/9/15.
//  Copyright (c) 2015 Jeff Greenberg. All rights reserved.
//

import UIKit

class JGTransitionExpandContract: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = true
    var focalPoint: CGPoint? // set to vanishing point or defaults to middle of screen
    var duration = 1.75
    var dampingRatio: CGFloat = 0.6
    var transformScale: CGFloat = 0.14
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        if self.isPresenting {
            toView.center = (focalPoint == nil) ? toView.center : focalPoint!
            containerView.addSubview(toView)
        } else {
            fromView.center = toView.center
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        let presentingTransform = CGAffineTransformIdentity
        let dismissingTransform = CGAffineTransformConcat(CGAffineTransformMakeScale(transformScale, transformScale), CGAffineTransformMakeRotation(CGFloat(8 * M_PI)))
        
        let animatingView = self.isPresenting ? toView : fromView
        animatingView.transform = isPresenting ? dismissingTransform : presentingTransform
        
        UIView.animateWithDuration( self.transitionDuration(transitionContext),
            delay: 0,
            usingSpringWithDamping: dampingRatio,
            initialSpringVelocity: 0,
            options: nil,
            animations: {
                
                if self.isPresenting {
                    toView.center = fromView.center
                } else {
                    fromView.center = (self.focalPoint == nil) ? fromView.center : self.focalPoint!
                }
                
                animatingView.transform = self.isPresenting ? presentingTransform : dismissingTransform
            },
            completion: { finished in
                
                containerView.addSubview(toView)
                
                fromView.removeFromSuperview()
                
                transitionContext.completeTransition(true)
            }
        )
    }
    
    internal func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return duration
    }
}