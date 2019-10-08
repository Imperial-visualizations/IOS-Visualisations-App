//
//  AnimatedLaunchScreenController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 25/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit
import SDWebImage

class AnimatedLaunchScreenController: UIViewController {

    var reachability: Reachability?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        let LoadingLogoImage = UIImage(named: "logo_white_solid_NBG")
        
        //Cannot use ImperialBlue asset - loading screen should be the same in light & dark mode
        let LoadingBackground = UIColor(displayP3Red: 0.090, green: 0.238, blue: 0.439, alpha: 1.0)
        let SplashView = RevealingSplashView(iconImage: LoadingLogoImage!, iconInitialSize: CGSize(width: 115, height: 61), backgroundColor: LoadingBackground)

        SplashView.animationType = .heartBeat

        self.view.addSubview(SplashView)

        SplashView.startAnimation(){
            //on completion of animation
            self.performSegue(withIdentifier: "replaceSegue", sender: self)
        }
        
        reachability = try? Reachability()
        
        
//TEMPORARY - need to remove
//        if reachability?.connection != .unavailable {
//            print("reachable")
//
//            //Decode JSON - need to exit splash view only when fetch is finished, cannot access SplashView if decoding code is a method in NetworkManager. URLSession is async!
//
//            //let url_name = "https://api.myjson.com/bins/of7n9"
//            let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/DataModel"
//            guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }
//
//            URLSession.shared.dataTask(with: url) { (data, _, _) in
//                guard let data = data else { fatalError("JSON data not loaded") }
//
//                do {
//                    let decodedDataModel = try JSONDecoder().decode(DataModel.self, from: data)
//                    visualisations = decodedDataModel.Visualisations
//                    filteredVisualisations = decodedDataModel.Visualisations
//
//                    SplashView.heartAttack = true
//
//                } catch {
//                    print(error)
//                }
//
//            }.resume()
//        }
//    }
        
        let wifiImageView = UIImageView()
        var wifiImage: UIImage
        if #available(iOS 13.0, *) {
            wifiImage = UIImage(systemName: "wifi.slash")!
//            TODO - optional ?? provide default
            
        } else {
            wifiImage = UIImage(contentsOfFile: "logo_white_solid_NBG")!
            //TODO - add wifi symbol
        }
        wifiImageView.image = wifiImage
        
//      change size?
        wifiImageView.frame = CGRect(origin: CGPoint(x: 0, y: view.frame.size.height * -1/3), size: wifiImage.size)
        
        wifiImageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        //add constraints to sub view
        
        //???
//        wifiImageView.translatesAutoresizingMaskIntoConstraints = false
        
////      horizontally centers
//        let horizConstr = NSLayoutConstraint(item: wifiImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0)
//
//        let vertOffset = view.frame.size.height * 1/3
//
////      symbol 2/3 way down from top of screen
//        let vertConstr = NSLayoutConstraint(item: wifiImageView, attribute: .centerY, relatedBy: .lessThanOrEqual, toItem: view, attribute: .centerY, multiplier: 1.0, constant: vertOffset)
//
//        wifiImageView.addConstraints([horizConstr, vertConstr])
        
        
        //TODO - unreachable state needs testing
        reachability?.whenReachable = { _ in
            print("reachable")
            
//          removes wifi symbol when reachable
            if self.view.subviews.contains(wifiImageView) {
                wifiImageView.removeFromSuperview()
            }

            //Decode JSON - need to exit splash view only when fetch is finished, cannot access SplashView if decoding code is a method in NetworkManager. URLSession is async!

//            let url_name = "https://api.myjson.com/bins/of7n9"
            let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/DataModel"
            guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }

//            TODO - error handling
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { fatalError("JSON data not loaded") }

                do {

                    let decodedDataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    visualisations = decodedDataModel.Visualisations
                    filteredVisualisations = decodedDataModel.Visualisations

                    //signal to exit splash view
                    SplashView.heartAttack = true


                } catch {
                    print(error)
                }

            }.resume()
        }
        
        reachability?.whenUnreachable = { _ in
            print("unreachable")
            self.view.addSubview(wifiImageView)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }

    }
    
}

