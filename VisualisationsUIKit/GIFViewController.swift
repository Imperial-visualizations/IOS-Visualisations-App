//
//  GIFViewController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 12/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit
import SDWebImage
import FLAnimatedImage

class GIFViewController: UIViewController {

    @IBOutlet weak var GIFView: SDAnimatedImageView!
    
    var selection = visualisations[0]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //GIFView.loadGif(name: selection.name + "_gif")
        
        //TODO - RESIZE GIF AND CACHE INSTEAD OF JUST CLEARING!
        
        //Slow and not fully working scaling - easier to just clear cache
        //let transformer = SDImageResizingTransformer(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), scaleMode: .aspectFit)
        
        //GIFView.sd_setImage(with: URL(string: selection.gifURL), placeholderImage: nil, context: [.imageTransformer: transformer])
        
        GIFView.sd_setImage(with: URL(string: selection.gifURL))
        
        
        // Do any additional setup after loading the view.
    }
    
    //clear image cache when preview disappear - prevents memory issues and crash after few GIFs are opened
    
    //MEMORY MANAGEMENT
    override func viewDidDisappear(_ animated: Bool = true) {
        SDImageCache.shared.clearMemory()
    }

    override func didReceiveMemoryWarning() {
        SDImageCache.shared.clearMemory()
    }
    
    
    //For testing
    
//    deinit {
//        print("DEALLOCATED GIFViewController class")
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
