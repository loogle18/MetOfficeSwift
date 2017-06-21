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
    
    override func viewDidAppear(_ animated: Bool) {
        StationDataService.getAllStationsData { stations in
            print(stations.count)
            self.stations = stations.sorted { $0.name < $1.name }
            self.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        cell.textLabel?.text = stations[indexPath.row].name
        return cell
    }
}
