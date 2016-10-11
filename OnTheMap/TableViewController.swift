//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/11/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        self.tableView.hidden = true
        self.activityIndicator.startAnimating()
        super.viewDidLoad()

    }
    
    @IBAction func refresh(sender: AnyObject) {
        getLocations()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
        self.activityIndicator.hidden = true
        self.tableView.hidden = false

    }
    
    override func viewWillAppear(animated: Bool) {

        getLocations()
        self.tableView.reloadData()
        self.activityIndicator.stopAnimating()

        

    }
    
    func getLocations() {
        ParseClient.sharedInstance().getStudentLocations { (locations, error) in
            if let locations = locations {
                StudentInformation.StudentArray = locations
                
                performUIUpdatesOnMain {
                    self.tableView.reloadData()

                }
            } else {
                alert(self, title: "Error", message: "Can't get location info. Try again later", actionTitle: "OK")
            }
        }
    

    }

    
 
    @IBAction func logoutFunction(sender: AnyObject) {
        UdacityClient.sharedInstance().destroySession {(result, error) in
            if let error = error {
                print(error)
                performUIUpdatesOnMain {
                    alert(self, title: "Error", message: "Can't logout. Try again later", actionTitle: "Dismiss")
                }
            } else {
                if let _ = result {
                    performUIUpdatesOnMain {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        
                        let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
                        self.presentViewController(nextViewController, animated:true, completion:nil)
                        
                        
                    }
                }
            }
        }

    }

    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplee implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return StudentInformation.StudentArray.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LocationTableViewCell
         let name = StudentInformation.StudentArray[indexPath.row].firstName + " " + String(StudentInformation.StudentArray[indexPath.row].lastName)
        cell.nameLabel.text = name
         
         return cell
     }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let location = StudentInformation.StudentArray[indexPath.row]
        let link = location.mediaURL
        
        if let requestUrl = NSURL(string: link) {
            if UIApplication.sharedApplication().canOpenURL(requestUrl) {
                UIApplication.sharedApplication().openURL(requestUrl)
            } else {
                
                alert(self, title: "Error", message: "invalid link", actionTitle: "Dismiss")
            }
        } else {
                alert(self, title: "Error", message: "invalid link", actionTitle: "Dismiss")
        }
        }
    }




    func alert(sender: AnyObject?, title: String, message: String, actionTitle: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default,handler: nil))
        
        sender!.presentViewController(alertController, animated: true, completion: nil)
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
    

