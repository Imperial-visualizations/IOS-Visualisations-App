//
//  NetworkManager.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 26/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import Foundation

class NetworkManager: NSObject {
    
    //var reachability: Reachability!
    
    static let SharedInstance: NetworkManager = NetworkManager()
    
    override init() {
        //reachability = try! Reachability()
    }
    
    func decodeJSON() {
        let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/DataModel"
        guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }

        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { fatalError("JSON data not loaded") }

            do {

                let decodedDataModel = try JSONDecoder().decode(DataModel.self, from: data)
                visualisations = decodedDataModel.Visualisations
                filteredVisualisations = decodedDataModel.Visualisations

            } catch {
                print(error)
            }

        }.resume()
        
    }
        
    
    
    
}
