//
//  GoalCell.swift
//  Goal-Post-app
//
//  Created by Unmilan on 04/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: String, goalProgressAmount: Int) {
        
        self.goalDescriptionLbl.text = description
        self.goalTypeLbl.text = type
        self.goalProgressLbl.text = String(describing: goalProgressAmount)//This converts the int into a string type.
        
    }

}
