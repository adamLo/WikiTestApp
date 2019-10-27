//
//  LocationCell.swift
//  WikiTestApp
//
//  Created by Adam Lovastyik on 27/10/2019.
//  Copyright © 2019 Adam Lovastyik. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var coordinatesLabel: UILabel!

    static let reuseId = "locationCell"
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        locationTitleLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
        locationTitleLabel.textColor = UIColor.black
        
        coordinatesLabel.font = UIFont.systemFont(ofSize: 13.0)
        coordinatesLabel.textColor = UIColor.darkGray
    }

    func setup(with location: CustomLocation) {
        
        locationTitleLabel.text = location.title
        coordinatesLabel.text = "\(location.coordinate.latitude), \(location.coordinate.longitude)"
    }
}
