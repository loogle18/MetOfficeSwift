//
//  StationTableViewController.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import MapKit

class StationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    var station: Station!
    var climates: [Climate]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationOnMapIfExist()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        climates = climates.sorted { $0.year < $1.year }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = station.name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return climates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClimateCell", for: indexPath) as! ClimateTableViewCell
        cell.climate = climates[indexPath.row]
        
        return cell
    }
    
    private func initLocationOnMapIfExist() {
        let stationLocation = station.location
        
        if let lat = stationLocation.lat, let lon = stationLocation.lon, let amsl = stationLocation.amsl {
            let location = CLLocationCoordinate2DMake(lat, lon)
            let formattedAmsl = CLLocationDegrees(amsl / 1000)
            let newAmsl = formattedAmsl > 0.002 || formattedAmsl < 0.0002 ? 0.002 : formattedAmsl
            let span = MKCoordinateSpanMake(newAmsl, newAmsl)
            let region = MKCoordinateRegion(center: location, span: span)
            
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = station.name
            
            mapView.addAnnotation(annotation)
        }
    }
}
