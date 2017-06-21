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
    
    class func createStation(_ data: String) -> Station {
        var lines = data.components(separatedBy: CharacterSet.newlines)
        let name = lines[0].components(separatedBy: "/").first?.components(separatedBy: "  ").first
        let station = Station(name: name!, location: lines[1])
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
            let tMax = data["tMax"]!.flatMap{ Double($0) }.average
            let tMin = data["tMin"]!.flatMap{ Double($0) }.average
            let rain = data["rain"]!.flatMap{ Double($0) }.average
            let afDays = data["afDays"]!.flatMap{ Double($0) }.average
            let sunHours = data["sunHours"]!.flatMap{ Double($0) }.average
            
            climates.append(Climate(year: year, tMax: tMax, tMin: tMin,
                                    rain: rain, afDays: afDays, sunHours: sunHours))
        }
        
        return climates
    }
}
