//
//  DetailViewController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 11/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    //initialise - value actually given by prepare for segue
    var selectedVis = visualisations[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url: URL = URL(string: selectedVis.url_name)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
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
