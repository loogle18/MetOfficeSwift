//
//  CreateStationFromDataService.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation

class CreateStationFromDataService {
    private static let lastLineIdentifierBeforeYears = "degC"
    private static let noDataSign = "---"
    
    class func createStation(_ data: String) -> Station {
        var lines = data.components(separatedBy: CharacterSet.newlines)
        let name = lines[0].components(separatedBy: "/").first?.components(separatedBy: "  ").first
        let locationData = (lines[1] + " " + lines[2]).components(separatedBy: "Lat").last
        let location = createLocationFromData(locationData!)
        
        let station = Station(name: name!, location: location)
        var indexToRemoveInclusive = 0
        
        for (index, line) in lines.enumerated() {
            if line.range(of: lastLineIdentifierBeforeYears) != nil {
                indexToRemoveInclusive = index
                break
            }
        }
        
        for _ in 0...indexToRemoveInclusive {
            lines.remove(at: 0)
        }
        
        var dataSetPerYear = [String : [String : [String]]]()
        
        for line in lines {
            var dataArray = line.components(separatedBy: CharacterSet.whitespaces).filter{ $0 != "" }
            
            if dataArray.count > 6 {
                let (year, tMax, tMin, afDays, rain, sunHours) = (dataArray[0], dataArray[2], dataArray[3],
                                                                  dataArray[4], dataArray[5], dataArray[6])
                if var existYear = dataSetPerYear[year] {
                    existYear["tMax"]!.append(tMax)
                    existYear["tMin"]!.append(tMin)
                    existYear["rain"]!.append(rain)
                    existYear["afDays"]!.append(afDays)
                    existYear["sunHours"]!.append(sunHours)
                    dataSetPerYear[year] = existYear
                } else {
                    dataSetPerYear[year] = ["tMax" : [tMax], "tMin" : [tMin], "rain" : [rain],
                                            "afDays" : [afDays], "sunHours" : [sunHours]]
                }
            }
        }
        
        station.climates = createClimates(dataSetPerYear)
        
        return station
    }
    
    private class func createClimates(_ dataDict: [String : [String : [String]]]) -> [Climate] {
        var climates = [Climate]()
        for (year, data) in dataDict {
            let tMax = getFormattedDataFor(data["tMax"]!)
            let tMin = getFormattedDataFor(data["tMin"]!)
            let rain = getFormattedDataFor(data["rain"]!)
            let afDays = getFormattedDataFor(data["afDays"]!)
            let sunHours = getFormattedDataFor(data["sunHours"]!)
            
            climates.append(Climate(year: year, tMax: tMax, tMin: tMin,
                                    rain: rain, afDays: afDays, sunHours: sunHours))
        }
        
        return climates
    }
    
    private class func getFormattedDataFor(_ data: [String]) -> String {
        let noDataSignFilteredData = data.filter { $0 != noDataSign }
        if noDataSignFilteredData.count > 0 {
            let filteredData = noDataSignFilteredData.flatMap{ $0.trimed(from: "#").trimed(from: "*") }
                .flatMap{ Double($0) }
                .average
                .roundTo(places: 2)
            return filteredData == 0.0 ? "0" : String(filteredData)
        } else {
            return noDataSign
        }
    }
    
    private class func createLocationFromData(_ data: String) -> Location {
        let (lanLatPattern, amslPttern, digitsPattern) = ("-?\\d+.\\d+", "(\\d+ m| \\d+m)", "\\d+")
        let lat = data.matches(for: lanLatPattern)[0]
        let lon = data.matches(for: lanLatPattern)[1]
        let amsl = data.matches(for: amslPttern)[0].matches(for: digitsPattern)[0]
        
        return Location(lat: Double(lat), lon: Double(lon), amsl: UInt(amsl))
    }
}
