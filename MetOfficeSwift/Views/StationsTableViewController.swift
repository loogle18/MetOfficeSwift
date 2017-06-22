//
//  StationsTableViewController.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class StationsTableViewController: UITableViewController {
    var stations = [Station]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StationDataService.getAllStationsData { stations in
            self.stations = stations.sorted { $0.name < $1.name }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath) as! StationTableViewCell
        cell.name = stations[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowSelectedStation" {
            let stationVC = segue.destination as? StationViewController
            guard let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell) else {
                    return
            }
            let station = stations[indexPath.row]
            
            stationVC?.station = station
            stationVC?.climates = station.climates
        }
    }
}
