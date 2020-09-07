//
//  CreateGoalVC.swift
//  Goal-Post-app
//
//  Created by Unmilan on 07/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController {

    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm//Setting variable with the default value we want for the goal type in the app.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextBtn.bindToKeyboard()//This makes the button move with the keyboard following the instructions we mentioned in UIViewExt.
        shortTermBtn.setSelectedColour()//Sets default colour to shortTermBtn.
        longTermBtn.setDeSelectedColour()//Sets default colour to longTermBtn.
        
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        
        goalType = .shortTerm
        shortTermBtn.setSelectedColour()
        longTermBtn.setDeSelectedColour()
        
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        
        goalType = .longTerm
        longTermBtn.setSelectedColour()
        shortTermBtn.setDeSelectedColour()
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismissDetail()//The dismiss function creates a segue back to the previous view.
        
    }
    
}
