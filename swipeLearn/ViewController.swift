//
//  ViewController.swift
//  swipeLearn
//
//  Created by Brown Magic on 8/5/15.
//  Copyright (c) 2015 codeHatcher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
  @IBOutlet weak var containerView: UIView!
  var containerViewStartingValues:(center:CGPoint, transform:CGAffineTransform)?
  var updatedLocation:CGPoint!
  
  // which way to remove the view
  enum RemoveDirection {
    case Left
    case Right
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func imagePanGesture(sender: UIPanGestureRecognizer) {
    
    switch(sender.state){
    case .Began:
      saveViewStartingValues(self.view)
      println("began center: \(self.view.center)")
    case .Changed:
      let translation = sender.translationInView(self.view)
      sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
      sender.setTranslation(CGPointZero, inView: self.view)
      // as the location changes, update the view center
      let newLocation = sender.view!.center
      updatedLocation = sender.view!.center
      println("sender: \(sender.view!.center) vs: \(self.view.center)")
      
      isGesturePastBounds(sender)
      
    case .Ended:
      println("ended movement")
      // check if gesture is past bounds
      if isGesturePastBounds(sender) {
        // remove the view in the direction based on which side it ended up on
        if (sender.view!.center.x < containerViewStartingValues!.center.x) {
          self.removeViewFromParent(containerView, direction: .Left)
        } else {
          self.removeViewFromParent(containerView, direction: .Right)
        }
      } else {
        resetViewToStartingValues(containerView, sender: sender)
      }
    default:
      // nothing
      var test = 0;
    }
  }
  
  func resetViewToStartingValues(view: UIView, sender: UIPanGestureRecognizer) {
    println("view \(view.center) vs start \(self.containerViewStartingValues!.center)")
    UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
      view.center = self.containerViewStartingValues!.center
      view.transform = CGAffineTransformMakeRotation(0)
//      self.shouldShowShadow(false)
      }, completion: {success in })
  }
  
  func removeViewFromParent(view: UIView, direction: RemoveDirection) {
    
    var animations:(()->Void)!
    switch direction {
    case .Left:
      animations = {view.center.x = -(UIScreen.mainScreen().bounds.width)}
    case .Right:
      animations = {view.center.x = UIScreen.mainScreen().bounds.width}
    default:
      break
    }
    
    UIView.animateWithDuration(0.2, animations: animations , completion: {success in view.removeFromSuperview()})

//    UIView.animateWithDuration(0.2, animations: {
//      view.center.x = view.center.x - 1000
//      },
//      completion: {success in
//        view.removeFromSuperview()
//      })
    
  }
  
  func saveViewStartingValues(view: UIView){
    containerViewStartingValues = (view.center, view.transform)
  }
  
  // did the gesture go too far
  func isGesturePastBounds(gesture: UIPanGestureRecognizer) -> Bool {
    let origCenter = containerViewStartingValues!.center
    
    // see how far we have moved the view as a ratio
    let ratioMoved = abs(gesture.view!.center.x - origCenter.x) / origCenter.x
//    println("ratio: \(ratioMoved)")
    if ratioMoved > 0.6 {
      return true
    } else {
      return false
    }
  }

}

