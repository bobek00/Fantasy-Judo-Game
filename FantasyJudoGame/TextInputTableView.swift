//
//  TextInpuTableView.swift
//  FantasyJudoGame
//
//  Created by Boris Rudas on 01/10/2016.
//  Copyright © 2016 Boris Rudas. All rights reserved.
//

import UIKit

public class TextInputTableView: UITableViewCell {
    
    @IBOutlet var myTextField: UITextField!
    @IBOutlet var textFieldTitle: UILabel!
    
    public func configure(text:String?, placeholder:String?, title: String?)
   
    {
        myTextField.text = text
        myTextField.placeholder = placeholder
        textFieldTitle.text = title
    }
}

