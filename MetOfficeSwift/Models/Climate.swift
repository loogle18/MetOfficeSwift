//
//  Climate.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 20.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

class Climate {
    var year: String
    var tMax, tMin, rain, afDays, sunHours: Double?
    
    init(year: String, tMax: Double?, tMin: Double?, rain: Double?, afDays: Double?, sunHours: Double?) {
        self.year = year
        self.tMax = tMax
        self.tMin = tMin
        self.rain = rain
        self.afDays = afDays
        self.sunHours = sunHours
    }
}
