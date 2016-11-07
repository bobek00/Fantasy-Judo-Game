//
//  CompetitionsTableViewCell.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 02/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

class CompetitionsTableViewCell: UITableViewCell {

    @IBOutlet var competitonNameLabel: UILabel!
    @IBOutlet var competitionTypeImg: UIImageView!
    @IBOutlet var competitonDateLabel: UILabel!
   
    
    override func awakeFromNib() {
      
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
