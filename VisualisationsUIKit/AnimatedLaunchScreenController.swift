//
//  AnimatedLaunchScreenController.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 25/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit

//TWO GLOBAL VARIABLES needed to avoid pop over segues - might be bad practice - consider changing
var visualisations: [Visualisation] = [
    .init(id:0, name: "", info: "", url_name: "", tags: "", imageURL: "", gifURL: "")
]

var filteredVisualisations = [Visualisation]()

class AnimatedLaunchScreenController: UIViewController {

    func decodeJSON() {
            let url_name = "https://raw.githubusercontent.com/VedantVarshney/VisualisationsPersonal/master/DataModel"
            guard let url = URL(string: url_name) else { fatalError("JSON URL not found") }

            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { fatalError("JSON data not loaded") }

                do {

                    let decodedDataModel = try JSONDecoder().decode(DataModel.self, from: data)
                    visualisations = decodedDataModel.Visualisations
                    filteredVisualisations = decodedDataModel.Visualisations

                } catch {
                    print(error)
                }

            }.resume()
        }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true

        let LoadingLogoImage = UIImage(named: "logo_white_solid_NBG")
        let background = UIColor(displayP3Red: 0.090, green: 0.238, blue: 0.439, alpha: 1.0)
        let SplashView = RevealingSplashView(iconImage: LoadingLogoImage!, iconInitialSize: CGSize(width: 60, height: 60), backgroundColor: background)

        SplashView.animationType = .heartBeat

        self.view.addSubview(SplashView)

        SplashView.startAnimation(){
            print("completed animation")
        }

        decodeJSON()

        //let navVC = storyboard!.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        //ANIMATION TO COMPLETE BEFORE TRANSITION TO NEW VC
        SplashView.heartAttack = true
        
        //BOTCH - need to delay segue to allow animation to play
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.performSegue(withIdentifier: "replaceSegue", sender: self)
        })
        
        print("done")

        //UIApplication.shared.keyWindow?.rootViewController = navVC

    }
}

