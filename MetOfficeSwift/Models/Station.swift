//
//  Station.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 20.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

class Station {
    var name: String
    var location: Location
    var climates: [Climate]
    
    init(name: String, location: Location) {
        self.name = name
        self.location = location
        self.climates = [Climate]()
    }
}
