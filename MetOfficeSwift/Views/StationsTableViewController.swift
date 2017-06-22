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
    var loadingView: UIView!
    var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        StationDataService.getAllStationsData { stations in
            self.stations = stations.sorted { $0.name < $1.name }
            self.tableView.reloadData()
            self.hideActivityIndicator()
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
    
    private func showActivityIndicator() {
        DispatchQueue.main.async() {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = CGPoint(x: self.tableView.bounds.size.width / 2,
                                              y: self.tableView.bounds.size.height / 2 - 44)
            self.loadingView.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 0.8)
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10
            
            self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x: self.loadingView.bounds.size.width / 2,
                                          y: self.loadingView.bounds.size.height / 2)
            
            self.loadingView.addSubview(self.spinner)
            self.tableView.addSubview(self.loadingView)
            self.spinner.startAnimating()
        }
    }
    
    private func hideActivityIndicator() {
        DispatchQueue.main.async() {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
        }
    }
}
