//
//  UsersCollectionViewCell.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 02/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet var userName: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeItRound()
        self.userImage.layer.borderWidth = 2.0
        self.userImage.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func makeItRound() {
        self.userImage.layer.masksToBounds = true
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width/2
        
    }
    
}
