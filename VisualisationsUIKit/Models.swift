//
//  Models.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 20/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import Foundation
import UIKit

struct Visualisation: Codable {
    var id: Int
    let name, info, url_name, tags, imageURL, gifURL: String
}

struct DataModel: Codable {
    let Visualisations: [Visualisation]
}

//TWO GLOBAL VARIABLES needed to avoid pop over segues - might be bad practice - consider changing
var visualisations: [Visualisation] = [
    .init(id:0, name: "", info: "", url_name: "", tags: "", imageURL: "", gifURL: "")
]

var filteredVisualisations = [Visualisation]()
