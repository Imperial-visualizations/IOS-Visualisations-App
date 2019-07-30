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
    
    var DetailLoadingView: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect())
    @IBOutlet weak var webView: WKWebView!
    
    //initialise - value actually given by prepare for segue
    var selectedVis = visualisations[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        webView.navigationDelegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let url: URL = URL(string: selectedVis.url_name)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
    }

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        //orientation changed again to ensure view.frame is correct
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        let DetailLoadingViewFrame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: self.view.frame.size.width * 0.075, height: self.view.frame.size.height * 0.075)
        
        DetailLoadingView = NVActivityIndicatorView(frame: DetailLoadingViewFrame, type: .ballTrianglePath, color: UIColor(named: "ImperialBlue"))
        
        self.view.addSubview(DetailLoadingView)
        DetailLoadingView.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        DetailLoadingView.stopAnimating()
    }
}
