//
//  MasterNavigationController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 12/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit

class MasterNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    internal override var shouldAutorotate: Bool {
        return visibleViewController!.shouldAutorotate
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
