//
//  StationDataService.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 20.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Alamofire

class StationDataService {
    private static let baseUrl = "http://www.metoffice.gov.uk/pub/data/weather/uk/climate/stationdata/"
    
    private static let dataSet = ["aberporth", "armagh", "ballypatrick", "bradford", "braemar", "camborne",
                                  "cambridge", "cardiff", "chivenor", "cwmystwyth", "dunstaffnage","durham",
                                  "eastbourne", "eskdalemuir", "heathrow", "hurn", "lerwick", "leuchars",
                                  "lowestoft", "manston", "nairn", "newtonrigg", "oxford", "paisley", "ringway",
                                  "rossonwye", "shawbury", "sheffield", "southampton", "stornoway","suttonbonington",
                                  "tiree", "valley", "waddington", "whitby", "wickairport", "yeovilton"]
    
    class func getAllStationsData(completion: @escaping ([Station]) -> Void) {
        var stations = [Station]()
        let group = DispatchGroup()
        
        for stationName in dataSet {
            group.enter()
            DispatchQueue.main.async {
                getStationData(stationName) { st in
                    if let station = st {
                        stations.append(station)
                    }
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            completion(stations)
        }
    }
    
    private class func getStationData(_ stationName: String, completion: @escaping (Station?) -> Void) {
        Alamofire.request("\(baseUrl)\(stationName)data.txt").responseData { response in
            if response.result.isSuccess {
                if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                    completion(CreateStationFromDataService.createStation(utf8Text))
                }
            }
        }
    }
}
