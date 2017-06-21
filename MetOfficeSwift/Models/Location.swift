//
//  Location.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import Foundation

class Location {
    var lat, lon: Double?
    var amsl: UInt?
    
    init(lat: Double?, lon: Double?, amsl: UInt?) {
        self.lat = lat
        self.lon = lon
        self.amsl = amsl
    }
}
