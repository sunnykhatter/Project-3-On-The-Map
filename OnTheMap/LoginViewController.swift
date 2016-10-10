//
//  ViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/18/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func login(sender: AnyObject) {
        guard let email = email.text where self.email.text != ""
            else {
                performUIUpdatesOnMain{
                    self.alert(self, title: "Error", message: "Email can't be empty", actionTitle: "Dismiss")
                    
                }
                return
        }
        
        guard let password = self.password.text where self.password.text != ""
            else {
                performUIUpdatesOnMain{
                    self.alert(self, title: "Error", message: "Password can't be empty", actionTitle: "Dismiss")
                    

                }
                return
        }
        UdacityClient.sharedInstance().createSession(email, password: password) {
            (SessionResults, error) in
            
            if let error = error {
                var message: String
                if error.code == 2 {
                    message = error.domain
                } else if error.code == -1009 {
                    message = "connection fails"
                } else {
                    message = error.domain
                }
                print(error)
                performUIUpdatesOnMain {
                        self.alert(self, title: "Error", message: message, actionTitle: "Try again")
                    
                }
            } else{
                UdacityClient.sharedInstance().SessionID = SessionResults[UdacityJSONResponseKeys.SessionID]
                UdacityClient.sharedInstance().UserID = SessionResults[UdacityJSONResponseKeys.UserID
                ]
                UdacityClient.sharedInstance().getUserInfo {
                    (result, error) in
                    if let error = error {
                        print(error)
                    } else {
                        if result as? Bool == true  {
                            //load map view
                            performUIUpdatesOnMain{
                                self.performSegueWithIdentifier("tabBarSegue", sender: self)
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    
    func alert(sender: AnyObject?, title: String, message: String, actionTitle: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default,handler: nil))
        
        sender!.presentViewController(alertController, animated: true, completion: nil)
    }

}

