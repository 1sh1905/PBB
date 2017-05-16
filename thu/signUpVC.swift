//
//  signUpVC.swift
//  thu
//
//  Created by TRI TRAN on 4/11/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit
import Parse

class signUpVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var avaImg: UIImageView!
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var bioTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var scrollViewHeight:CGFloat = 0
    
    var keyboard = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.font = UIFont(name: "Pacifico", size: 20)

        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        scrollView.contentSize.height=self.view.frame.height
        scrollViewHeight=scrollView.frame.size.height
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(signUpVC.showKeyboard(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(signUpVC.hideKeyboard(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        
        let hideTap = UITapGestureRecognizer(target: self, action:#selector(signUpVC.hideKeyboardTap(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.userInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 6
        avaImg.clipsToBounds = true
        
        
        let avaTap = UITapGestureRecognizer(target: self, action:#selector(signUpVC.loadImg(_:)))
            avaTap.numberOfTapsRequired = 1
            avaImg.userInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)
        
        
        
        // alignment
        avaImg.frame = CGRectMake(self.view.frame.size.width / 2 - 40, 40, 80, 80)
        usernameTxt.frame = CGRectMake(20, avaImg.frame.origin.y + 90, self.view.frame.size.width - 25, 30)
        passwordTxt.frame = CGRectMake(20, usernameTxt.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        repeatPassword.frame = CGRectMake(20, passwordTxt.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        emailTxt.frame = CGRectMake(20, repeatPassword.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        fullnameTxt.frame = CGRectMake(20, emailTxt.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        bioTxt.frame = CGRectMake(20, fullnameTxt.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        webTxt.frame = CGRectMake(20, bioTxt.frame.origin.y + 40, self.view.frame.size.width - 25, 30)
        
        signUpBtn.frame = CGRectMake(20, webTxt.frame.origin.y + 50, self.view.frame.size.width / 4, 30)
        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.width / 20
        
        cancelBtn.frame = CGRectMake(self.view.frame.size.width - self.view.frame.size.width / 4 - 20, signUpBtn.frame.origin.y, self.view.frame.size.width / 4, 30)
        cancelBtn.layer.cornerRadius = cancelBtn.frame.size.width / 20
        
        // background
        let bg = UIImageView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        bg.image = UIImage(named: "background.jpg")
        bg.layer.zPosition = -1
        self.view.addSubview(bg)
        

    }
    func loadImg(recoginizer: UITapGestureRecognizer){
    let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = true
        presentViewController(picker,animated:true,completion:nil)
        
    
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func hideKeyboardTap(recoginizer:UITapGestureRecognizer){
    self.view.endEditing(true)

    }
    
    
    func showKeyboard(notification:NSNotification) {
        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue)!
        UIView.animateWithDuration(0.4){ () -> Void in
     self.scrollView.frame.size.height = self.scrollViewHeight-self.keyboard.height
    
    }
    }
    func hideKeyboard(notification:NSNotification) {
        keyboard = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey]!.CGRectValue)!
        UIView.animateWithDuration(0.4){ () -> Void in
            self.scrollView.frame.size.height = self.view.frame.height
            
        }
    }
    
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpBtn_click(sender: AnyObject) {
        
        
        print("Sign up pressed")
    self.view.endEditing(true)
        if(usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPassword.text!.isEmpty||emailTxt.text!.isEmpty||fullnameTxt.text!.isEmpty||bioTxt.text!.isEmpty||webTxt.text!.isEmpty){
        let alert = UIAlertController(title: "Error", message: "at least one field is not filled", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(ok)
         self.presentViewController(alert, animated: true, completion: nil)
       return
        
        }
        if(passwordTxt.text != repeatPassword.text){
        let alert = UIAlertController(title: "Password", message: "do not match", preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
       return
        
        }
        let user = PFUser()
        user.username = usernameTxt.text?.lowercaseString
        user.email = emailTxt.text?.lowercaseString
        user.password = passwordTxt.text
        user["fullname"] = fullnameTxt.text?.lowercaseString
        user["bio"] = bioTxt.text
        user["web"] = webTxt.text?.lowercaseString
        
        // in Edit Profile it's gonna be assigned
        user["tel"] = ""
        user["gender"] = ""
        
       // convert our image for sending to server
        let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.8)
        let avaFile = PFFile(name: "ava.jpg", data: avaData!)
        user["ava"] = avaFile
        
        // save data in server
       user.signUpInBackgroundWithBlock { (success:Bool, error:NSError?) -> Void in
         if success {
           print("registered")
                
                
                // remember looged user
         NSUserDefaults.standardUserDefaults().setObject(user.username, forKey: "username")
        NSUserDefaults.standardUserDefaults().synchronize()
                
                // call login func from AppDelegate.swift class
        let appDelegate : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.login()
                
        } else {
                // show alert message
          let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
         let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(ok)
        self.presentViewController(alert, animated: true, completion: nil)
       }
       }
    }
    
    @IBAction func cancelBtn_click(sender: AnyObject) {
        // hide keyboard when pressed cancel
        self.view.endEditing(true)
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
