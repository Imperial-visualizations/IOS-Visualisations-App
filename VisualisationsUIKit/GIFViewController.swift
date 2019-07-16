//
//  GIFViewController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 12/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit
import SDWebImage

class GIFViewController: UIViewController {

    @IBOutlet weak var GIFView: UIImageView!
    
    var selection = visualisations[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //GIFView.loadGif(name: selection.name + "_gif")
        
        GIFView.sd_setImage(with: URL(string: selection.gifURL))
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool = true) {
        SDImageCache.shared.clearMemory()
    }
    deinit {
        print("DEALLOCATED GIFViewController class")
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
