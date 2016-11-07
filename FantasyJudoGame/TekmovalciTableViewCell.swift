//
//  TekmovalciTableViewCell.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 06/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

class TekmovalciTableViewCell: UITableViewCell {

    @IBOutlet var competitorsName: UILabel!
    @IBOutlet var competitorsCountry: UILabel!

    
    @IBOutlet var predictedFirstPlaceImg: UIImageView!
    @IBOutlet var predictedSecondPlaceImg: UIImageView!
    @IBOutlet var predictedThirdPlaceImg1: UIImageView!
    @IBOutlet var predictedThirdPlaceImg2: UIImageView!
    
    @IBOutlet var setFirstBtn: UIButton!
    @IBOutlet var setSecondBtn: UIButton!
    @IBOutlet var setThird1Btn: UIButton!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    


    func configureCell (text: String , text2: String) {
        competitorsName.text = text
        competitorsCountry.text = text2
        
    }
    
    
    
}
