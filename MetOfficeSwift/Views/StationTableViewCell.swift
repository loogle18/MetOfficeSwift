//
//  StationTableViewCell.swift
//  MetOfficeSwift
//
//  Created by Медведь Святослав on 21.06.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class StationTableViewCell: UITableViewCell {
    @IBOutlet weak var nameUILabel: UILabel!
    var name: String!
    var location: String!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameUILabel.text = name
    }
}
