//
//  followersCell.swift
//  thu
//
//  Created by TRI TRAN on 4/13/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit
import Parse
class followersCell: UITableViewCell {

    @IBOutlet weak var avaImg: UIImageView!
    
    @IBOutlet weak var usernameLbl: UILabel!
    
    @IBOutlet weak var followBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // alignment
        let width = UIScreen.mainScreen().bounds.width
        
        avaImg.frame = CGRectMake(10, 10, width / 5.3, width / 5.3)
        usernameLbl.frame = CGRectMake(avaImg.frame.size.width + 20, 28, width / 3.2, 30)
        followBtn.frame = CGRectMake(width - width / 3.5 - 10, 30, width / 3.5, 30)
        followBtn.layer.cornerRadius = followBtn.frame.size.width / 20
        
        // round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
        avaImg.clipsToBounds = true    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func followBtn_click(sender: AnyObject) {
        
        
        let title = followBtn.titleForState(.Normal)
        
        // to follow
        if title == "FOLLOW" {
            let object = PFObject(className: "follow")
            object["follower"] = PFUser.currentUser()?.username
            object["following"] = usernameLbl.text
            object.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                if success {
                    self.followBtn.setTitle("FOLLOWING", forState: UIControlState.Normal)
                    self.followBtn.backgroundColor = .greenColor()
                } else {
                    print(error?.localizedDescription)
                }
            })
            
            // unfollow
        } else {
            let query = PFQuery(className: "follow")
            query.whereKey("follower", equalTo: PFUser.currentUser()!.username!)
            query.whereKey("following", equalTo: usernameLbl.text!)
            query.findObjectsInBackgroundWithBlock({ (objects:[PFObject]?, error:NSError?) -> Void in
                if error == nil {
                    
                    for object in objects! {
                        object.deleteInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                            if success {
                                self.followBtn.setTitle("FOLLOW", forState: UIControlState.Normal)
                                self.followBtn.backgroundColor = .lightGrayColor()
                            } else {
                                print(error?.localizedDescription)
                            }
                        })
                    }
                    
                } else {
                    print(error?.localizedDescription)
                }
            })
            
        }
        
    }
    
    
    
}