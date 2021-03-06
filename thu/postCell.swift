//
//  postCell.swift
//  thu
//
//  Created by TRI TRAN on 4/22/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit
import Parse

class postCell: UITableViewCell {
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var picImg: UIImageView!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var titleLbl: KILabel!
    @IBOutlet weak var uuidLbl: UILabel!
    
    

    // default func
    override func awakeFromNib() {
        super.awakeFromNib()
        // clear like button title color
       likeBtn.setTitleColor(UIColor.clearColor(), forState: .Normal)
        
        // double tap to like
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(postCell.likeTap))
        likeTap.numberOfTapsRequired = 2
        picImg.userInteractionEnabled = true
        picImg.addGestureRecognizer(likeTap)
       
        
        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 20
        avaImg.clipsToBounds = true
        
    
    }
    
    // double tap to like
    func likeTap() {
        
        // create large like gray heart
        let likePic = UIImageView(image: UIImage(named: "unlike.png"))
        likePic.frame.size.width = picImg.frame.size.width / 1.5
        likePic.frame.size.height = picImg.frame.size.width / 1.5
        likePic.center = picImg.center
        likePic.alpha = 0.8
        self.addSubview(likePic)
        
        // hide likePic with animation and transform to be smaller
        UIView.animateWithDuration(0.4) { () -> Void in
            likePic.alpha = 0
            likePic.transform = CGAffineTransformMakeScale(0.1, 0.1)
        }
        
        // declare title of button
        let title = likeBtn.titleForState(.Normal)
        
        if title == "unlike" {
            
            let object = PFObject(className: "likes")
            object["by"] = PFUser.currentUser()?.username
            object["to"] = uuidLbl.text
            object.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                if success {
                    print("liked")
                    self.likeBtn.setTitle("like", forState: .Normal)
                    self.likeBtn.setBackgroundImage(UIImage(named: "like.png"), forState: .Normal)
                    
                    // send notification if we liked to refresh TableView
                    NSNotificationCenter.defaultCenter().postNotificationName("liked", object: nil)
                    
                    
                    // send notification as like
                    if self.usernameBtn.titleLabel?.text != PFUser.currentUser()?.username {
                        let newsObj = PFObject(className: "news")
                        newsObj["by"] = PFUser.currentUser()?.username
                        newsObj["ava"] = PFUser.currentUser()?.objectForKey("ava") as! PFFile
                        newsObj["to"] = self.usernameBtn.titleLabel!.text
                        newsObj["owner"] = self.usernameBtn.titleLabel!.text
                        newsObj["uuid"] = self.uuidLbl.text
                        newsObj["type"] = "like"
                        newsObj["checked"] = "no"
                        newsObj.saveEventually()
                    }
                    
                }
            })
            
        }
        
    }
    
    
    // clicked like button
    
    @IBAction func likeBtn_click(sender: AnyObject) {
        
    
        // declare title of button
        let title = sender.titleForState(.Normal)
        
        // to like
        if title == "unlike" {
            
            let object = PFObject(className: "likes")
            object["by"] = PFUser.currentUser()?.username
            object["to"] = uuidLbl.text
            object.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                if success {
                    print("liked")
                    self.likeBtn.setTitle("like", forState: .Normal)
                    self.likeBtn.setBackgroundImage(UIImage(named: "like.png"), forState: .Normal)
                    
                    // send notification if we liked to refresh TableView
                    NSNotificationCenter.defaultCenter().postNotificationName("liked", object: nil)
                    
                    // send notification as like
                   if self.usernameBtn.titleLabel?.text != PFUser.currentUser()?.username {
                        let newsObj = PFObject(className: "news")
                        newsObj["by"] = PFUser.currentUser()?.username
                        newsObj["ava"] = PFUser.currentUser()?.objectForKey("ava") as! PFFile
                        newsObj["to"] = self.usernameBtn.titleLabel!.text
                        newsObj["owner"] = self.usernameBtn.titleLabel!.text
                        newsObj["uuid"] = self.uuidLbl.text
                        newsObj["type"] = "like"
                        newsObj["checked"] = "no"
                        newsObj.saveEventually()
                    }
                    
                }
            })
            
            // to dislike
        } else {
            
            // request existing likes of current user to show post
            let query = PFQuery(className: "likes")
            query.whereKey("by", equalTo: PFUser.currentUser()!.username!)
            query.whereKey("to", equalTo: uuidLbl.text!)
            query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) -> Void in
                
                // find objects - likes
                for object in objects! {
                    
                    // delete found like(s)
                    object.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        if success {
                            print("disliked")
                            self.likeBtn.setTitle("unlike", forState: .Normal)
                            self.likeBtn.setBackgroundImage(UIImage(named: "unlike.png"), forState: .Normal)
                            
                            // send notification if we liked to refresh TableView
                            NSNotificationCenter.defaultCenter().postNotificationName("liked", object: nil)
                            
                            
                            // delete like notification
                           let newsQuery = PFQuery(className: "news")
                            newsQuery.whereKey("by", equalTo: PFUser.currentUser()!.username!)
                            newsQuery.whereKey("to", equalTo: self.usernameBtn.titleLabel!.text!)
                            newsQuery.whereKey("uuid", equalTo: self.uuidLbl.text!)
                            newsQuery.whereKey("type", equalTo: "like")
                            newsQuery.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) -> Void in
                                if error == nil {
                                    for object in objects! {
                                        object.deleteEventually()
                                    }
                                }
                            })
                            
                            
                        }
                    })
                }
            })
            
        }
        
    }
    
   
}
