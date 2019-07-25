//
//  ReplaceSegue.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 25/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit

class ReplaceSegue: UIStoryboardSegue {

    override func perform() {
        
        source.navigationController?.setViewControllers([self.destination], animated: false)
    }
}
