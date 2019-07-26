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
            NetworkManager.SharedInstance.decodeJSON()
            SplashView.heartAttack = true
        }
        
        
        
        //ANIMATION TO COMPLETE BEFORE TRANSITION TO NEW VC
        
        //BOTCH - need to delay segue to allow animation to play
//        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500), execute: {
//            self.performSegue(withIdentifier: "replaceSegue", sender: self)
//        })
        
        print("done")

        //UIApplication.shared.keyWindow?.rootViewController = navVC

    }
}

