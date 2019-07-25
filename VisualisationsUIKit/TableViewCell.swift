//
//  TableViewCell.swift
//  VisualisationsUIKit
//
//  Created by Vedant Varshney on 11/07/2019.
//  Copyright © 2019 Vedant Varshney. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    
    func setCell(visualisation: Visualisation){
        //ImageView.loadGif(name: visualisation.name + "_gif")
        //ImageView.image = UIImage(named: visualisation.name)
        
        //TODO load and store at viewDidLoad of main ViewController
        
        ImageView.sd_setImage(with: URL(string: visualisation.imageURL))
        //ImageView.image = SDImageCache.shared.imageFromCache(forKey: visualisation.imageURL)
        TitleLabel.text = visualisation.name
        TitleLabel.textColor = UIColor(named: "ImperialBlue")
        InfoLabel.text = visualisation.info
    }
}
