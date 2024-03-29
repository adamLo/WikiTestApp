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
        
        title = NSLocalizedString("Wikipedia Locations Test", comment: "Main controller navigation title")
        
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
        cell.textLabel?.text = NSLocalizedString("Add new location", comment: "Add new location title")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row < locations.count {
            
            let location = locations[indexPath.row]
            openWikiPedia(with: location)
        }
        else {
            
            queryAddNewLocation()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return indexPath.row < locations.count
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.row < locations.count {
            return UISwipeActionsConfiguration(actions: [UIContextualAction(style: .destructive, title: NSLocalizedString("Delete", comment: "Delete action title"), handler: { (action, view, handler) in
                
                self.locations.remove(at: indexPath.row)
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
                handler(true)
            })])
        }
        
        return nil
    }
    
    // MARK: - Data handling
    
    private func queryAddNewLocation() {
        
        let alert = UIAlertController(title: NSLocalizedString("Add new location", comment: "Add new location title"), message: NSLocalizedString("Enter coordinates as\nlatitude, longitude\nseparated by comma", comment: "Add new locaton alert dialog message"), preferredStyle: .alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = NSLocalizedString("Latitude, Longitude", comment: "Coordinates text field placeholder")
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK Button title"), style: .default, handler: { (_) in
            
            if let textField = alert.textFields?.first, let text = textField.text, let location = CustomLocation(coordinates: text) {
                self.add(location: location)
            }
            else {
                self.showError(NSLocalizedString("Please enter valid coordinates", comment: "Error message when entered text does not contain valid coordinates"))
            }
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel button title"), style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func openWikiPedia(with location: CustomLocation) {
        
        if let url = location.wikiURL, UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else {            
            showError(NSLocalizedString("Cannot open Wikipedia App!", comment: "Error message when cannot create URL form location or cannot open Wikipedia app"))
        }
    }
    
    private func add(location: CustomLocation) {
        
        locations.append(location)
        
        locationsTableView.beginUpdates()
        locationsTableView.insertRows(at: [IndexPath(row: locations.count - 1, section: 0)], with: .automatic)
        locationsTableView.endUpdates()
    }
    
    // MARK: - Error handling
    
    private func showError(_ message: String) {
        
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Error dialog title"), message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK Button title"), style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
