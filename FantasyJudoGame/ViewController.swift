//
//  ViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 01/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import Firebase
import FirebaseStorage
import FirebaseDatabase


class ViewController: UIViewController,FBSDKLoginButtonDelegate {

    var loginButton = FBSDKLoginButton()
   
    @IBOutlet var aivLoadingSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.hidden = true
        
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("TabBarControllerView")
                
                self.presentViewController(homeViewController, animated: true, completion: nil)
                
                
            } else {
                self.loginButton.center = self.view.center
                self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
                self.loginButton.delegate = self
                self.view!.addSubview(self.loginButton)
                self.loginButton.hidden = false

                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        print("User logged in!")
        
        self.loginButton.hidden = true
        
        aivLoadingSpinner.startAnimating()
        
        if ((error) != nil)
        {
            // Process error
            self.loginButton.hidden = false
            aivLoadingSpinner.stopAnimating()
        }
        else if result.isCancelled {
            // Handle cancellations
            self.loginButton.hidden = false
            aivLoadingSpinner.stopAnimating()
        }
        else {
            let credential = FIRFacebookAuthProvider.credentialWithAccessToken( FBSDKAccessToken.currentAccessToken().tokenString)
            
            FIRAuth.auth()?.signInWithCredential(credential) {(user, error) in
                print ("User logged in to Firebase App")
                
                //when the user logs in for the first time, we'll store the users name and the users email on their profile page.
                //also store the small version of the profile picture in the database and in the storage
                
                if(error == nil){
                    let storage = FIRStorage.storage()
                    
                    let storageRef = storage.referenceForURL("gs://fantasy-judo-game.appspot.com")
                    
                    let profilePicRef = storageRef.child(user!.uid+"/profile_pic_small.jpg")
                    
                    //store the userId
                    let userId = user?.uid
                    
                    let databaseRef = FIRDatabase.database().reference()
                    
                    databaseRef.child("users").child(userId!).child("profile_pic_small").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                    
                        let profile_pic = snapshot.value as? String?
                        if(profile_pic == nil){
                        
                            if let imageData = NSData(contentsOfURL: user!.photoURL!){
                                let uploadTask = profilePicRef.putData(imageData, metadata:nil) {
                                    metadata,error in
                                    if(error == nil){
                                        let downloadURL = metadata!.downloadURL
                                        
                                        databaseRef.child("users").child("\(user!.uid)/profile_pic_small").setValue(downloadURL()!.absoluteString)
                                        
                                    } else {
                                        print("Error in downloading image")
                                    }
                                }
                            }
                            //store data into the users profile page
                            databaseRef.child("users").child("\(user!.uid)/name").setValue(user?.displayName)
                            databaseRef.child("users").child("\(user!.uid)/gender").setValue("")
                            databaseRef.child("users").child("\(user!.uid)/age").setValue("")
                            databaseRef.child("users").child("\(user!.uid)/phone").setValue("")
                            databaseRef.child("users").child("\(user!.uid)/email").setValue(user?.email)
                            databaseRef.child("users").child("\(user!.uid)/website").setValue("")
                            databaseRef.child("users").child("\(user!.uid)/bio").setValue("")
                            
                        } else {
                            print("User has logged in erlier")
                        }
                    })
                }
            }
        }
    }
        
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print ("User did log out!")
    }
    


}

