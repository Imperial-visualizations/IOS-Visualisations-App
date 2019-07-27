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
        let SplashView = RevealingSplashView(iconImage: LoadingLogoImage!, iconInitialSize: CGSize(width: 160, height: 85), backgroundColor: LoadingBackground)

        SplashView.animationType = .heartBeat

        self.view.addSubview(SplashView)

        SplashView.startAnimation(){
            //on completion of animation
            self.performSegue(withIdentifier: "replaceSegue", sender: self)
        }
        
        reachability = try? Reachability()
        
        //NOT WORKING - PRIORITY
//        reachability?.whenReachable = { reachability in
//            DispatchQueue.main.async {
//                print("reached")
//                NetworkManager.SharedInstance.decodeJSON()
//                SplashView.heartAttack = true
//            }
//        }
        
        
        //TEMPORARY
        if reachability?.connection != .unavailable {
            print("reachable")
            
            //Decode JSON - need to exit splash view only when fetch is finished, cannot access SplashView if decoding code is a method in NetworkManager. URLSession is async!
            
            let url_name = "https://api.myjson.com/bins/of7n9"
            //let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/DataModel"
            guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }

            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { fatalError("JSON data not loaded") }

                do {

                    let decodedDataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    visualisations = decodedDataModel.Visualisations
                    filteredVisualisations = decodedDataModel.Visualisations
                    
                    SplashView.heartAttack = true
                    

                } catch {
                    print(error)
                }

            }.resume()
        }
        
        
        print("done")

        //UIApplication.shared.keyWindow?.rootViewController = navVC

    }
}

