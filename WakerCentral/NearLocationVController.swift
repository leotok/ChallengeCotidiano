//
//  NearLocationVController.swift
//  WakerCentral
//
//  Created by Lucas Menezes on 24/03/15.
//  Copyright (c) 2015 Leonardo Edelman Wajnsztok. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class NearLocationVController: UIViewController,CLLocationManagerDelegate,UITextFieldDelegate
{

    var presentPlace: String = String();
    var destination: String = String();
    var timeToWait: NSTimeInterval = NSTimeInterval();
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var partidaField: UITextField!
    
    @IBOutlet weak var destinoField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var backButton: UIButton = UIButton(frame: CGRectMake(10,20 , 30 , 30))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let location = CLLocationCoordinate2D(latitude: -51.50007773, longitude: -0.1246402)
        
        locationManager.delegate=self;
        locationManager.desiredAccuracy=kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        partidaField.text="Calculating your position..."
        
        backButton.setImage(UIImage(named: "backbt"), forState: UIControlState.Normal)
        backButton.addTarget(self, action: Selector("backMenu2:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(backButton)
        // 2
        
        partidaField.delegate = self
        destinoField.delegate = self
        
        //3
        
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backMenu2(sender: UIButton)
    {
        self.dismissViewControllerAnimated(false, completion: nil)
        
    }
    func showYouInMap(location: CLLocationCoordinate2D)
    {
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "You"
        annotation.subtitle = "Are here"
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if  status == .AuthorizedWhenInUse || status == .AuthorizedAlways
        {
            manager.startUpdatingLocation()
            // ...
        }
        println("changed")
        
    }
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        println("updated")
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler:
        { (placemarks, error) -> Void in
            if (error != nil)
            {
                println("Error:" + error.localizedDescription)
                return
            }
                
            if placemarks.count > 0
            {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
                
            }
            else
            {
                println("Error with data")
                    
            }
            
        })
    }

    func displayLocationInfo(placemark: CLPlacemark)
    {
        self.locationManager.stopUpdatingLocation()
        println(placemark.locality)
        println(placemark.postalCode)
        println(placemark.administrativeArea)
        println(placemark.country)
        println(placemark.name)
        println(placemark.region)
        println(placemark.subAdministrativeArea)
        println(placemark.subLocality)
        placemark.location
        partidaField.text=String(format: "%@ <%f, %f>",placemark.name,placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
        showYouInMap(placemark.location.coordinate)
    }
  
}
