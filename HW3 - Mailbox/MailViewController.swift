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
    @IBOutlet weak var messageImage: UIImageView!
    @IBOutlet weak var archiveIcon: UIImageView!
    @IBOutlet weak var laterIcon: UIImageView!
    @IBOutlet weak var listIcon: UIImageView!
    @IBOutlet weak var deleteIcon: UIImageView!
    @IBOutlet weak var rescheduleView: UIImageView!
    @IBOutlet weak var listView: UIImageView!
    
    
    
    @IBOutlet var messagePanRecognizer: UIPanGestureRecognizer!
    
    var messageOriginalCenter: CGPoint!

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
        var translation = messagePanRecognizer.translationInView(view)
        var velocity = messagePanRecognizer.velocityInView(view)
        
        
        if sender.state == UIGestureRecognizerState.Began {
            
            // Sets the center of Message View
            messageOriginalCenter = messageImage.center
            
            // Sets the center of Archive Icon
            archiveIconInitialCenter = archiveIcon.center
            
            // Sets the center of Later Icon
            laterIconInitialCenter = laterIcon.center
            
            // Stops icons from moving
            moveIconsLeft = false
            moveIconsRight = false
        

            
        } else if sender.state == UIGestureRecognizerState.Changed {
            
            
            
            // If pan input x value changes, move Message View
            messageImage.center.x = messageOriginalCenter.x + translation.x
            
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
            
            if 30 <= translation.x && translation.x < 60 {
                
                //make the archive icon opaque
                UIView.animateWithDuration(0.4, animations: {
                    self.archiveIcon.alpha = 1
                })
                
                
                // if moving from right back towards center, reset the bkgnd to gray, stop moving icons and reset their positions
                if moveIconsRight == true {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.lightGrayColor()
                    })
                    moveIconsRight = false
                    archiveIcon.center.x = archiveIconInitialCenter.x
                    deleteIcon.center.x = archiveIconInitialCenter.x
                    laterIcon.alpha = 0.5
                }
                
            } else if -60 < translation.x && translation.x <= -30 {
                //start making later icon opaque
                laterIcon.alpha = 1
                
                //if moving left to right, reset the bknd color, stop moving the icons, and reset them to their original position
                if moveIconsLeft == true {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.lightGrayColor()
                    })
                    moveIconsLeft = false
                    laterIcon.center.x = laterIconInitialCenter.x
                    listIcon.center.x = laterIconInitialCenter.x
                    archiveIcon.alpha = 0.5
                }
                
            } else if 60 <= translation.x && translation.x < 260 {
                
                //set bkgn color to green
                // start moving archive icon
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor(red: 153, green: 239, blue: 0)
                

                })
                laterIcon.alpha = 0
                moveIconsRight = true
                
                if archiveIcon.alpha == 0 {
                    archiveIcon.alpha = 1
                    deleteIcon.alpha = 0
                }
                
                
                
            } else if -260 <= translation.x && translation.x < -60 {
                
                
                //set bkgn color to yellow
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor(red: 244, green: 229, blue: 0)
                })
                archiveIcon.alpha = 0
                //start moving the later icon
                moveIconsLeft = true
                if laterIcon.alpha == 0 {
                    laterIcon.alpha = 1
                    listIcon.alpha = 0
                }
                
                
            } else if 260 <= translation.x {
                
                //set bkgnd color to red
                //archive icon changes to delete icon
                UIView.animateWithDuration(0.4, animations: {
                    self.messageView.backgroundColor = UIColor(red: 244, green: 44, blue: 0)
                })
                archiveIcon.alpha = 0
                deleteIcon.alpha = 1
                
            } else if translation.x < -260 {
                
                //set bkgnd color to brown
                
                //later icon changes to list icon
                if messageView.backgroundColor != UIColor.brownColor() {
                    UIView.animateWithDuration(0.4, animations: {
                        self.messageView.backgroundColor = UIColor.brownColor()
                    })
                    laterIcon.alpha = 0
                    listIcon.alpha = 1
                }
                
            }

            
        } else if sender.state == UIGestureRecognizerState.Ended {
            
            
            if abs(translation.x) < 60 {
                UIView.animateWithDuration(0.3,
                    animations: {
                        // move messageImage back to original point
                        self.messageImage.center.x = self.messageOriginalCenter.x

                        // move icons back to their original points
                        self.laterIcon.center.x = self.laterIconInitialCenter.x
                        self.listIcon.center.x = self.laterIconInitialCenter.x
                        self.archiveIcon.center.x = self.archiveIconInitialCenter.x
                        self.deleteIcon.center.x = self.archiveIconInitialCenter.x
                    },
                    completion: {(value: Bool) in
                        // change messageView background back to light gray
                        self.messageView.backgroundColor = UIColor.lightGrayColor()

                    }
                
                )
                
            } else if translation.x >= 60 {
                
        
                UIView.animateWithDuration(0.4, animations: {() -> Void in
                    self.messageImage.center.x = self.messageOriginalCenter.x + 320
                    self.archiveIcon.center.x = 320 - self.archiveIconInitialCenter.x
                    self.deleteIcon.center.x = 320 - self.archiveIconInitialCenter.x
                    self.messageView.alpha = 0
                    },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.feedView.center.y = self.feedView.center.y - 65
                        })
                })
                
            } else if -260 < translation.x && translation.x <= -60 {
                
                UIView.animateWithDuration(0.4, animations: {() -> Void in
                    self.messageImage.center.x = self.messageOriginalCenter.x - 320
                    self.laterIcon.center.x = 320 - self.laterIconInitialCenter.x
                    self.listIcon.center.x = 320 - self.laterIconInitialCenter.x
                    },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.rescheduleView.alpha = 1
                        })
                })
                
            } else if translation.x < -260 {
                UIView.animateWithDuration(0.4, animations: { () -> Void in
                    self.messageImage.center.x = self.messageOriginalCenter.x - 320
                    self.laterIcon.center.x = 320 - self.laterIconInitialCenter.x
                    self.listIcon.center.x = 320 - self.laterIconInitialCenter.x
                    
                },
                    completion: {(Bool) -> Void in []
                        UIView.animateWithDuration(0.4, animations: {
                            self.listView.alpha = 1
                        })
                })
            }
        }
}
    
    @IBAction func tapListView(sender: UITapGestureRecognizer) {
  
        UIView.animateWithDuration(0.4, animations: {
            self.listView.alpha = 0
            self.messageView.alpha = 0
            self.feedView.center.y = self.feedView.center.y - 65
        })
          }
        
    
    
    @IBAction func tapRescheduleView(sender: UITapGestureRecognizer) {
   
        UIView.animateWithDuration(0.4, animations: {
            self.rescheduleView.alpha = 0
            self.messageView.alpha = 0
            self.feedView.center.y = self.feedView.center.y - 65
        })
         }
        
    
    
    


 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}


