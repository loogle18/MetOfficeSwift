//
//  Climate.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 20.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

class Climate {
    var year, tMax, tMin, rain, afDays, sunHours: String
    
    init(year: String, tMax: String, tMin: String, rain: String, afDays: String, sunHours: String) {
        self.year = year
        self.tMax = tMax
        self.tMin = tMin
        self.rain = rain
        self.afDays = afDays
        self.sunHours = sunHours
    }
}
