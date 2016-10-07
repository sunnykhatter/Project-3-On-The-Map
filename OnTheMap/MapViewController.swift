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
            
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView!.canShowCallout = true
                //            pinView!.pinColor = .Red Apparently, Deprecated
                pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
            }
            else {
                pinView!.annotation = annotation
            }
            
            return pinView
        }

}
