//
//  CompCategoriesCollectionViewCell.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 04/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

class CompCategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var catLabel: UILabel!
    
    required init?(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.redColor().CGColor
    }
    
    func configureCell (text: String) {
        catLabel.text = text
    }
    
    
    
}
