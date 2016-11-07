//
//  HomeViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 01/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseStorage

class HomeViewController: UIViewController {
    

    @IBOutlet var profileImage: UIImageView!
//    @IBAction func didTabLogout(sender: AnyObject) {
//        
//        //signs the user out of firebase
//        try! FIRAuth.auth()?.signOut()
//        
//        //sign the user out of facebook
//        FBSDKAccessToken.setCurrentAccessToken(nil)
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        let viewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
//        
//        self.presentViewController(viewController, animated: true, completion: nil)
//        
//    }
//    
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 4.0
        self.profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            let firstName = name!.componentsSeparatedByString(" ")[0]
            self.nameLabel.text = firstName
            
            //reference to the storage
            let storage = FIRStorage.storage()
            
            let storageRef = storage.referenceForURL("gs://fantasy-judo-game.appspot.com")
            
            let profilePicRef = storageRef.child(user.uid+"/profile_pic.jpg")
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            profilePicRef.dataWithMaxSize(1 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print("User has no image")
                } else {
                    
                    if(data != nil){
                        print("User already has an image, no need to download.")
                        self.profileImage.image = UIImage(data: data!)
                    }

                }
            }
            if(self.profileImage.image == nil)
            {
            let profilePic = FBSDKGraphRequest(graphPath: "me/picture", parameters: ["height":300, "width":"300","redirect":false], HTTPMethod: "GET")
            
            profilePic.startWithCompletionHandler({(connection, result, error) -> Void in
                
                if(error == nil)
                {
                    let dictionary = result as? NSDictionary
                    let data = dictionary?.objectForKey("data")
                    
                    let urlPic = (data?.objectForKey("url"))! as! String
                    
                    if let imageData = NSData(contentsOfURL: NSURL(string:urlPic)!)
                    {
                        
                        
                        let uploadTask = profilePicRef.putData(imageData, metadata:nil){
                            metadata,error in
                            if(error == nil)
                            {
                                let downloadURL = metadata!.downloadURL
                            }
                            else {
                                print("Error in downloading image!")
                            }
                        }
                        self.profileImage.image = UIImage(data:imageData)
                    }
                }
            })
        }
        } else {
        
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
