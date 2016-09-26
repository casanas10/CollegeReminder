//
//  NotesMasterTableViewCell.swift
//  College Reminder
//
//  Created by Anthony Colas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit

class NotesMasterTableViewCell: UITableViewCell {
    
    // @IBOutlet weak var masterTitleLabel: UILabel!
    // @IBOutlet weak var masterTextLabel: UILabel!
    
    
    //@IBOutlet weak var masterTitleLabel: UILabel!
    //@IBOutlet weak var masterTextLabel: UILabel!
    
    
    @IBOutlet weak var masterTitleLabel: UILabel!
    @IBOutlet weak var masterTextLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}