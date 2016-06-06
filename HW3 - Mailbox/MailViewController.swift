//
//  MailViewController.swift
//  HW3 - Mailbox
//
//  Created by Stephen Davis on 5/31/16.
//  Copyright © 2016 Stephen Davis. All rights reserved.
//

import UIKit

class MailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var feedView: UIImageView!
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    
    
    
    @IBOutlet var messagePanRecognizer: UIPanGestureRecognizer!
    
    var messageOriginalCenter: CGPoint!
    var messageLeft: CGPoint!
    var messageRight: CGPoint!
    var moveIconsLeft:Bool!
    var moveIconsRight:Bool!

    
    
    var archiveIconInitialCenter: CGPoint!
    var laterIconInitialCenter: CGPoint!
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.contentSize = feedView.image!.size
  


    
    }
    
    
    @IBAction func didPanMessage(sender: UIPanGestureRecognizer) {
        
        // Absolute (x,y) coordinates in parent view
        var point = messagePanRecognizer.locationInView(view)
        
        // Relative change in (x,y) coordinates from where gesture began.
        let translation = messagePanRecognizer.translationInView(view)
        var velocity = messagePanRecognizer.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            // Sets the center of Message View
            messageOriginalCenter = messageView.center
            
            // Sets the center of Archive Icon
            archiveIconInitialCenter = archiveIcon.center
            
            // Sets the center of Later Icon
            laterIconInitialCenter = laterIcon.center
            
            // Stops icons from moving
            moveIconsLeft = false
            moveIconsRight = false
        

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
            // If pan input x value changes, move Message View
            messageView.center.x = messageOriginalCenter.x + translation.x
            
            //if past x value threshold, start moving icons
            
            if moveIconsRight == true {
                
                //Move the Archive Icon with the Message View but take away 60
                archiveIcon.center.x = archiveIconInitialCenter.x + translation.x - 60
                
                //Move the Delete Icon with the Message View but take away 60
                deleteIcon.center.x = archiveIconInitialCenter.x + translation.x - 60
                
            }
            
            if moveIconsLeft == true {
                laterIcon.center.x = laterIconInitialCenter.x + translation.x + 60
                listIcon.center.x = laterIconInitialCenter.x + translation.x + 60
            }
            
            
        } else if translation.x > 60 {
            
                //make the archive icon opaque
                UIView.animateWithDuration(0.4, animations: {
                    self.archiveIcon.alpha = 1


                })
            
            if moveIconsRight == true {
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor.lightGrayColor()
                })
                moveIconsRight = false
                archiveIcon.center.x = archiveIconInitialCenter.x
                deleteIcon.center.x = archiveIconInitialCenter.x
                laterIcon.alpha = 0.5
            }
            
       
            
            
     
            
        } else if sender.state == UIGestureRecognizerState.Ended {
        
            
            // Sets the center of Message View
            
            UIView.animateWithDuration(0.3, animations: {
                self.messageView.center.x = self.messageOriginalCenter.x
            })
        }
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
