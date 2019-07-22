//
//  Models.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 20/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import Foundation

struct Visualisation: Codable {
    var id: Int
    let name, info, url_name, tags, imageURL, gifURL: String
}

struct DataModel: Codable {
    let Visualisations: [Visualisation]
}
