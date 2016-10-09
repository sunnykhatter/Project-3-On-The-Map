//
//  UrlPostViewController.swift
//  OnTheMap
//
//  Created by Lakshay Khatter on 10/9/16.
//  Copyright © 2016 Lakshay Khatter. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class UrlPostViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var coordinates: CLLocationCoordinate2D?
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        

        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        setUpMapView()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    func setUpMapView() {
        let address = self.address
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                self.alert(self, title: "Error", message: "Can't geocode the location", actionTitle: "Try again")
                print("Error", error)
            } else {
                if let placemark = placemarks?.first {
                    self.coordinates = placemark.location!.coordinate
                    let location = CLLocationCoordinate2DMake(self.coordinates!.latitude, self.coordinates!.longitude)
                    let dropPin = MKPointAnnotation()
                    dropPin.coordinate = location
                    self.mapView.addAnnotation(dropPin)
                    // set boundaries of the zoom
                    let span = MKCoordinateSpanMake(0.01, 0.01)
                    // now move the map
                    let region = MKCoordinateRegion(center: dropPin.coordinate, span: span)
                    self.mapView.setRegion(region, animated: true)
                }
            }
        })
    }
    
    func alertWithOption (sender: AnyObject?, title: String, message: String, actionTitle: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: {(action: UIAlertAction!) in
            
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel,handler: nil))
        
        sender!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func alert(sender: AnyObject?, title: String, message: String, actionTitle: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default,handler: nil))
        
        sender!.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
