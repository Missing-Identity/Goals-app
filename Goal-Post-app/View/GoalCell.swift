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
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal) {
        
        self.goalDescriptionLbl.text = goal.goalDescription
        self.goalTypeLbl.text = goal.goalType//This pulls out the explicit variable type.
        self.goalProgressLbl.text = String(describing: goal.goalProgress)//This converts the int into a string type.
        if goal.goalProgress == goal.goalCompletionValue {//Hides completionView if progress is complete.
            self.completionView.isHidden = false
        } else {
            self.completionView.isHidden = true
        }
    }

}
