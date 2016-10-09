//
//  InformationPostViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 10/8/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit

class InformationPostViewController: UIViewController {

    @IBOutlet weak var linkView: UIView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissViewC(sender: AnyObject) {
           self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBAction func findOnMapClicked(sender: AnyObject) {
        performSegueWithIdentifier("toUrlPostView", sender: sender)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
            if segue.identifier == "toUrlPostView" {
                let viewController:UrlPostViewController = segue.destinationViewController as! UrlPostViewController
                viewController.address = locationTextField.text!
                
            }
            
            
        }
    }
 


