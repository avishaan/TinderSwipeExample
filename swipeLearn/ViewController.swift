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
      
    case .Ended:
      println("ended movement")
      resetViewToStartingValues(containerView, sender: sender)
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
  
  func saveViewStartingValues(view: UIView){
    containerViewStartingValues = (view.center, view.transform)
  }

}

