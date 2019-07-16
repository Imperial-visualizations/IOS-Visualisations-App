//
//  ViewController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 11/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import Foundation
import UIKit


//TODO - Fix UI style (truncation on back button etc)

//BUGS - 3D touch does not work on a search filtered view, 3D touch jittery on exit - BSMach error



struct Visualisation: Codable {
    var id: Int
    let name, info, url_name, tags, imageURL, gifURL: String
}

//replaced with JSON data later
//IMPORTANT - this NEEDS to be a non-empty array for selectedVisualisation to be init. If empty will crash. Before table displayed, all data will be replaced with JSON. Init values only serve to init selectedVisualisation outside functions but within class.
//Might be bad practice (check) but quick fix...

//global because DetailViewController uses this to have an init value for selectedVis. Might want to look into removing all non-const global variables.
//only ever changed in decodeJSON
var visualisations: [Visualisation] = [
    .init(id:0, name: "", info: "", url_name: "", tags: "", imageURL: "", gifURL: "")
]

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    //scope functionality not built/needed yet - potential TODO
    func filterForSearch(_ searchText: String, scope: String = "All") {
        filteredVisualisations = visualisations.filter{
            searchText.isEmpty ?
                true:
                "\($0)".lowercased().contains(searchText.lowercased())
            
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    var filteredVisualisations = [Visualisation]()
    
    //initialised - actual value doesn't matter - will be changed before segue
    
    //IMPORTANT - need this variable to be accessible to all funcs in class but also need to give it an initial value of correct type (object Visualisation). So, visualisations CANNOT be empty here otherwise will crash.
    var selectedVisualisation = visualisations[0]
    
    func decodeJSON() {
        let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/visData.json"
        guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }
    
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { fatalError("JSON data not loaded") }
    
            do {
                let decodedVisualisations = try JSONDecoder().decode([Visualisation].self, from: data)
                visualisations = decodedVisualisations
                self.filteredVisualisations = visualisations
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
    
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        decodeJSON()
        
        
        //WRONG - check!
        //filtered visualisations set inside viewDidLoad because JSON code needs to be in func. Initial init is outside func to be as accessible by all funcs in class.
        //filteredVisualisations = visualisations
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //TODO - prefetch?
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Visualisations"
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let logoImageView = UIImageView(image: UIImage(named: "AppIcon"))
        //logoImageView.frame = CGRect(x: 0, y: 0, width: 5, height: 20) //not working
        //logoImageView.contentMode = .scaleAspectFit //looks too fat
        
        let logoBarItem = UIBarButtonItem(customView: logoImageView)
        
        navigationItem.rightBarButtonItem = logoBarItem
        
        
        
        //SEARCH BAR SETUP
        //nil as current view controller shows filtered results
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = false
        
        if traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: tableView)
        }
 
    }
    
 
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
 
    //Attempt to fix rotation in detailed view - not working
    /*
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeRight
    }
    */

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredVisualisations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //visualisation at row in view
        let visualisation = filteredVisualisations[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.setCell(visualisation: visualisation)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedVisualisation = filteredVisualisations[indexPath.row]
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailViewController
        vc.selectedVis = self.selectedVisualisation
        
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filterForSearch(searchController.searchBar.text!)
    }
    
}

extension ViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableView.indexPathForRow(at: location) else { return nil }
        let selectedVis = filteredVisualisations[indexPath.row]
        //guard let cell = tableView.cellForRow(at: indexPath) as? TableViewCell else { return nil}
        
        let identifier = "GIFViewController"
        guard let GIFVC = storyboard?.instantiateViewController(withIdentifier: identifier) as? GIFViewController else { return nil}
        
        GIFVC.selection = selectedVis
        
        GIFVC.preferredContentSize = CGSize(width: 0, height: 190)
        
        return GIFVC
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        let selectedVis = (viewControllerToCommit as! GIFViewController).selection
        
        let identifier = "DetailViewController"
        
        //force unwrap?
        let detailVC = storyboard!.instantiateViewController(withIdentifier: identifier) as! DetailViewController
        
        detailVC.selectedVis = selectedVis
        
        self.show(detailVC, sender: self)
    }
    
}
