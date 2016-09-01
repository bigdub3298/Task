//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Wesley Austin on 8/31/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped(sender: UIButton) {
        
    }
}
