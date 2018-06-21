//
//  TrackingGpsViewController.swift
//  Benefit
//
//  Created by Lakshay Chhabra on 19/06/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class TrackingGpsViewController: UIViewController, CLLocationManagerDelegate {

    var time = Timer()
    var initialTime = 0
    var mins = 0
    @IBOutlet var minutesCountLabel: UILabel!
    @IBOutlet var map: MKMapView!
    @IBOutlet var startButton: UIButton!
    @IBOutlet var caloriesLabel: UILabel!
    
    var isStart = true
    var locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    var startLocation = CLLocationCoordinate2D()
    var speed = CLLocationSpeed()
    
    @IBOutlet var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        
        userLocation = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: userLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        self.map.setRegion(region, animated: true)
        map.showsUserLocation = true
         let startLocationPosition = CLLocation(latitude: startLocation.latitude, longitude: startLocation.longitude)
         let userLocationPosition = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
        
        let distance = userLocationPosition.distance(from: startLocationPosition)
        let roundedDistance = round(distance * 100)/100
        distanceLabel.text = "\(roundedDistance)"
        
        
        
    }
    
    @objc func increaseTimer(){
        initialTime += 1
        mins = initialTime/60
        minutesCountLabel.text = "\(mins)"
    }
    
    @IBAction func startButtonPressed(_ sender: Any) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
         startLocation = userLocation
        
       
        
        if isStart {
        distanceLabel.text = "0"
            time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.increaseTimer), userInfo: nil, repeats: true)
            
        locationManager.startUpdatingLocation()
         

        startButton.setTitle("STOP", for: .normal)
            isStart = false
        }
        else {
            time.invalidate()
            initialTime = 0
            locationManager.stopUpdatingLocation()
            locationManager.stopMonitoringSignificantLocationChanges()
            startButton.setTitle("START", for: .normal)
            isStart = true
            
        }
    }
    //display alerts
    func displayAlert(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func discardButtonPressed(_ sender: Any) {
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        displayAlert(title: "Task Completed", message: "That was a nice session")
    }
  
    
}
