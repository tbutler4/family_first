//
//  ViewController.swift
//  FamilyFirst
//
//  Created by Christopher Chung on 7/17/18.
//  Copyright © 2018 Christopher Chung. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SeeFamilyViewController: UIViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    
    var people:[String] = []
    var allColors = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple, UIColor.black]
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddSegue", sender: self)
    }
    @IBOutlet weak var tableView: UITableView!
    // Importing Map
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        //Says we want the best accuracy
        manager.requestAlwaysAuthorization()
        //Have to request authorization for using users location
        manager.startUpdatingLocation()
        //Says "Hey manager, let's start updating
        mapView.showsUserLocation = true
    }
    
    //======================================================================================
    // HELPER FUNCTIONS
    //======================================================================================
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations location: [CLLocation]){
        let location = location[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
        print(location)
    }

}

extension SeeFamilyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCell", for: indexPath) as! customCell
        cell.nameLabel.text = "My Name"
        cell.uniqueColorLabel.textColor = allColors[indexPath.row]
        return cell
    }
    
}




