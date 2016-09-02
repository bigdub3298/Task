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
    
    var delegate: ButtonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Actions 
    
    @IBAction func buttonTapped(sender: UIButton) {
        delegate?.buttonCellButtonTapped(self)
         
    }
    
    
    // MARK: - Helper Functions
    func updateButton(isComplete: Bool) {
        if isComplete {
            button.imageView?.image = UIImage(named: "complete")
        } else {
            button.imageView?.image = UIImage(named: "incomplete")
        }
    }
}



extension ButtonTableViewCell {
    
    func updateWithTask(task: Task) {
            primaryLabel.text = task.name
            updateButton(task.isComplete)
    }
}


protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
}