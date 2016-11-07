//
//  TableTableViewController.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 01/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import FBSDKLoginKit


class ProfileTableViewController: UITableViewController {
    
    var about = ["Name","Gender","Age","Phone","Email","Website","Bio"] //here i need to add COUNTRY, maybe fav category,  and delete bio, age, phone, email, website...
    
    var ref = FIRDatabase.database().reference()
    var user = FIRAuth.auth()?.currentUser

    @IBAction func didTapUpdate(sender: AnyObject) {
        
        var index = 0
        
        while index<about.count{
        
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            let cell: TextInputTableView? = self.tableView.cellForRowAtIndexPath(indexPath) as? TextInputTableView
            
            if cell?.myTextField != "" {
                let item:String = (cell?.myTextField.text!)!
                
                switch about[index]{
                
                case "Name":
                    self.ref.child("users").child("\(user!.uid)/name").setValue(item)
                case "Gender":
                    self.ref.child("users").child("\(user!.uid)/gender").setValue(item)
                    
                case "Age":
                    self.ref.child("users").child("\(user!.uid)/age").setValue(item)
                    
                case "Phone":
                    self.ref.child("users").child("\(user!.uid)/phone").setValue(item)
                
                case "Email":
                    self.ref.child("users").child("\(user!.uid)/email").setValue(item)
                    
                case "Website":
                    self.ref.child("users").child("\(user!.uid)/website").setValue(item)
                    
                case "Bio":
                    self.ref.child("users").child("\(user!.uid)/bio").setValue(item)
            
                default:
                    print("Don't update")
                
                } //end switch
            
            }//end if
            
            index+=1
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
            self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        
            var refHandle = self.ref.child("users").observeSingleEventOfType(FIRDataEventType.Value, withBlock: {(snapsot) in
        
            let usersDict = snapsot.value as! NSDictionary
            
            let userDetails = usersDict.objectForKey(self.user!.uid)
                
            var index = 0
                
                while index<self.about.count{
                    let indexPath = NSIndexPath(forRow: index, inSection: 0)
                    let cell: TextInputTableView? = self.tableView.cellForRowAtIndexPath(indexPath) as! TextInputTableView?
                    
                    let field: String = (cell?.myTextField.placeholder?.lowercaseString)!
                    
                    switch field{
                    case "name":
                        cell?.configure(userDetails?.objectForKey("name") as? String, placeholder: "Type your username", title: "Username")
                    case "gender":
                        
                        cell?.configure(userDetails?.objectForKey("gender") as? String, placeholder: "your gender", title: "Gender")

                    case "age":
                        cell?.configure(userDetails?.objectForKey("age") as? String, placeholder: "What is your age", title: "Age")

                    case "phone":
                        cell?.configure(userDetails?.objectForKey("phone") as? String, placeholder: "Your phone number", title: "Phone Number")

                    case "email":
                        cell?.configure(userDetails?.objectForKey("email") as? String, placeholder: "Type your email", title: "Email")

                    case "website":
                        cell?.configure(userDetails?.objectForKey("website") as? String, placeholder: "Your website", title: "Website")

                    case "bio":
                        cell?.configure(userDetails?.objectForKey("bio") as? String, placeholder: "Write something about you", title: "Bio")
                        
                    default:
                        ""
                    }
                
                    index+=1
                }
            
        })
        //

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return about.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:TextInputTableView = tableView.dequeueReusableCellWithIdentifier("TextInput", forIndexPath: indexPath) as! TextInputTableView
        
            cell.configure("", placeholder: "\(about[indexPath.row])", title: "")

        
        return cell
    }
    @IBAction func didTabLogout(sender: AnyObject) {
        
        //signs the user out of firebase
        try! FIRAuth.auth()?.signOut()
        
        //sign the user out of facebook
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("LoginView")
        
        self.presentViewController(viewController, animated: true, completion: nil)
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true

    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
