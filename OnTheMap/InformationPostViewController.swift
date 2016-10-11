//
//  InformationPostViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 10/8/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit
import MapKit

class InformationPostViewController: UIViewController, MKMapViewDelegate  {
    
    @IBOutlet weak var linkView: UIView!
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var whereAreYouStudyingView: UIView!
    
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addALinkTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var coordinates: CLLocationCoordinate2D?
    var address = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dimssView(sender: AnyObject) {
           self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func submit(sender: AnyObject) {
        
        
        
        if (addALinkTextField.text  == "Enter a Link to Share Here" || addALinkTextField.text  == "") {
            alert(self, title: "Error", message: "Please enter a link", actionTitle: "enter")
            return
        }
        
        if let validURL: NSURL = NSURL(string: addALinkTextField.text!) {
            // Successfully constructed an NSURL; open it
            if !UIApplication.sharedApplication().canOpenURL(validURL) {
                alert(self, title: "Error", message: "invalid link", actionTitle: "Try again")
                return
            }
        } else {
            alert(self, title: "Error", message: "invalid link", actionTitle: "Try again")
            return
        }
        
        let jsonBody: String = "{\"uniqueKey\": \"\(UdacityClient.sharedInstance().UserID!)\", \"firstName\": \"\(UdacityClient.sharedInstance().firstName!)\" , \"lastName\": \"\(UdacityClient.sharedInstance().lastName!)\",\"mapString\": \"\(locationTextField.text!)\", \"mediaURL\": \"\(addALinkTextField.text!)\",\"latitude\": \(coordinates!.latitude), \"longitude\": \(coordinates!.longitude)}"
            
            

        
        // if it is the first time for a user to add location
        if UdacityClient.sharedInstance().updateLoaction == false {
            
            ParseClient.sharedInstance().putNewLocation(jsonBody) { (result, error) in
                if result == true {
                    UdacityClient.sharedInstance().locationAdded = true
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    performUIUpdatesOnMain {
                        alert(self, title: "Error", message: "Can't add new location info to database", actionTitle: "Try again")
                    }
                    print(error)
                }
            }
        } else {

            ParseClient.sharedInstance().updateLocation(jsonBody) { (result, error) in
                if result == true {
                    UdacityClient.sharedInstance().locationAdded = true
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    performUIUpdatesOnMain {
                        alert(self, title: "Error", message: "Can't update location info to database", actionTitle: "Try again")
                    }
                    print(error)
                }
            }
        }
    }

    @IBAction func findOnTheMap(sender: AnyObject) {

        self.setUpMapView()

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func setUpMapView() {
        let address = locationTextField.text!
        let geocoder = CLGeocoder()
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                alert(self, title: "Error", message: "Can't geocode the location", actionTitle: "Try again")
                print("Error", error)
            } else {
                if let placemark = placemarks?.first {
  
                    
                    self.coordinates = placemark.location!.coordinate
                    let location = CLLocationCoordinate2DMake(self.coordinates!.latitude, self.coordinates!.longitude)
                    let pin = MKPointAnnotation()
                    pin.coordinate = location
                    self.mapView.addAnnotation(pin)
                    // set boundaries of the zoom
                    let span = MKCoordinateSpanMake(0.1, 0.1)
                    // now move the map
                    let region = MKCoordinateRegion(center: pin.coordinate, span: span)
                    self.mapView.setRegion(region, animated: true)

                    
                    UIView.animateWithDuration(0.4) {

                        self.whereAreYouStudyingView.alpha = 0.0
                    }
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.hidden = true

                }
            }
        })
    }
        
   
    

}
 


