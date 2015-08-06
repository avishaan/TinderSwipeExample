//
//  CHSwipeView.swift
//  swipeLearn
//
//  Created by Brown Magic on 8/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class CHSwipeView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  var originalOrientation:(center: CGPoint, transform: CGAffineTransform)!
  var screenSize: CGRect!
  var gestureRecognizer: UIPanGestureRecognizer!
  
  enum RemoveDirection {
    case Left
    case Right
  }
  
  override init(frame: CGRect) {
    println("init frame")
    super.init(frame: frame)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    println("init coder")
    self.myInit()
  }
  
  // use this init for storyboard init(coder) or programmatic init(frame)
  private func myInit() {
    self.gestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("onViewSwipe:"))
    self.addGestureRecognizer(self.gestureRecognizer)
  }
  
  func onViewSwipe(gesture: UIPanGestureRecognizer) {
    
    switch(gesture.state){
    case UIGestureRecognizerState.Began:
      println("Began")
      originalOrientation = (center: self.center, transform: self.transform)
    
    case UIGestureRecognizerState.Changed:
      let translation = gesture.translationInView(self.superview!)
      gesture.view!.center = CGPoint(x: gesture.view!.center.x + translation.x, y: gesture.view!.center.y + translation.y)
      gesture.setTranslation(CGPointZero, inView: self)
      
    case UIGestureRecognizerState.Ended:
      self.resetViewOrientation()
    
    default:
      println("Default")
      
    }
    
  }
  func resetViewOrientation() {
    
//    println("view \(view.center) vs start \(self.containerViewStartingValues!.center)")
    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
      self.center = self.originalOrientation.center
      self.transform = CGAffineTransformMakeRotation(0)
//      self.shouldShowShadow(false)
      }, completion: {success in })
  }

}
