//
//  LocationsViewController.swift
//  WikiTestApp
//
//  Created by Adam Lovastyik on 27/10/2019.
//  Copyright © 2019 Adam Lovastyik. All rights reserved.
//

import UIKit
import CoreLocation

class LocationsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var locationsTableView: UITableView!
    
    // MARK: - Properties
    
    private var locations: [CustomLocation]!
    
    // MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupLocations()
        setupUI()
    }

    // MARK: - UI customization
    
    private func setupUI() {
        
        title = "Wikipedia Locations Test"
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        locationsTableView.tableFooterView = UIView()
    }
    
    // MARK: - Data integration
    
    private func setupLocations() {
        
        let amsterdam = CustomLocation(title: "Amsterdam", coordinate: CLLocationCoordinate2D(latitude: 52.3545983, longitude: 4.8339214))
        let thehauge = CustomLocation(title: "The Hague", coordinate: CLLocationCoordinate2D(latitude: 52.0716335, longitude: 4.2398294))
        let sanfrancisco = CustomLocation(title: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7576948, longitude: -122.4726193))
        let newyork = CustomLocation(title: "New York", coordinate: CLLocationCoordinate2D(latitude: 40.6974034, longitude: -74.1197624))
        let buenosaires = CustomLocation(title: "Buenos Aires", coordinate: CLLocationCoordinate2D(latitude: -34.6158037, longitude: -58.5033379))
        let london = CustomLocation(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.5285582, longitude: -0.2416789))
        let budapest = CustomLocation(title: "Budapest", coordinate: CLLocationCoordinate2D(latitude: 47.4811282, longitude: 18.9902223))
        
        locations = [amsterdam, thehauge, sanfrancisco, newyork, buenosaires, london, budapest]
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return locations.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < locations.count, let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.reuseId, for: indexPath) as? LocationCell {
            
            let location = locations[indexPath.row]
            cell.setup(with: location)
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "addLocation")
        cell.textLabel?.text = "Add new location"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row < locations.count {
            
            let location = locations[indexPath.row]
            openWikiPedia(with: location)
        }
        else {
            
            addNewLocation()
        }
    }
    
    // MARK: - Data handling
    
    private func addNewLocation() {
        
        let alert = UIAlertController(title: "Add new location", message: "Enter coordinates as latitude, longitude - separated by comma", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func openWikiPedia(with location: CustomLocation) {
        
        let url = URL(string: "wikipedia://places?LACoordinate=\(location.coordinate.latitude),\(location.coordinate.longitude)")!
        
        if UIApplication.shared.canOpenURL(url) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {
            
            let alert = UIAlertController(title: "Error", message: "Cannot open Wikipedia App!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
}
