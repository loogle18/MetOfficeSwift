//
//  ClimateTableViewCell.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class ClimateTableViewCell: UITableViewCell {
    @IBOutlet weak var yearUILabel: UILabel!
    @IBOutlet weak var tMaxUILabel: UILabel!
    @IBOutlet weak var tMinUILabel: UILabel!
    @IBOutlet weak var rainUILabel: UILabel!
    @IBOutlet weak var afDaysUILabel: UILabel!
    @IBOutlet weak var sunHoursUILabel: UILabel!
    var climate: Climate!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        yearUILabel.text = "\(climate.year)\nyear"
        tMaxUILabel.text = "Max temp: \(climate.tMax)" + (climate.tMax == "---" ? "" : " \u{00B0}C")
        tMinUILabel.text = "Min temp: \(climate.tMin)" + (climate.tMin == "---" ? "" : " \u{00B0}C")
        rainUILabel.text = "Rainfall: \(climate.rain)" + (climate.rain == "---" ? "" : " mm")
        afDaysUILabel.text = "Days of air frost: \(climate.afDays)" + (climate.afDays == "---" ? "" : " days")
        sunHoursUILabel.text = "Sunshine: \(climate.sunHours)" + (climate.sunHours == "---" ? "" : " hours")
    }
}
