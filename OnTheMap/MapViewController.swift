//
//  MapViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 9/20/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
        
        @IBOutlet weak var mapView: MKMapView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            mapView.delegate = self

            
            
        }
    
    override func viewWillAppear(animated: Bool) {
        ParseClient.sharedInstance().getStudentLocations { (locations, error) in
            if let locations = locations {
                performUIUpdatesOnMain {
                    
                    for result in locations {
                        let location = CLLocationCoordinate2DMake(result.latitude, result.longitude)
                        let dropPin = MKPointAnnotation()
                        dropPin.coordinate = location
                        dropPin.title = result.firstName + " " + result.lastName
                        dropPin.subtitle = result.mediaURL
                        self.mapView.addAnnotation(dropPin)
                    }
                    
                }
            }
        }

    }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
            let reuseId = "pin"
            let buttonType = UIButtonType.InfoLight
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
            pinView.canShowCallout = true
            //pinView.animatesDrop = true //takes way to long
            pinView.rightCalloutAccessoryView = UIButton(type: buttonType)
            
            return pinView
        }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        if control == view.rightCalloutAccessoryView {
            
            let link = ((view.annotation?.subtitle)!)! as String
            
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
}
