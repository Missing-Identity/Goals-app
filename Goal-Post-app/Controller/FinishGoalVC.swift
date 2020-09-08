//
//  FinishGoalVC.swift
//  Goal-Post-app
//
//  Created by Unmilan on 08/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    var goalDescription: String!
    var goalType: GoalType!
    
    func initData(description: String, type: GoalType) {
        
        self.goalDescription = description
        self.goalType = type
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createGoalBtn.bindToKeyboard()
        pointsTextField.delegate = self
        
    }
    @IBAction func createGoalBtnWasPressed(_ sender: Any) {
        //Pass data into the Core Data Goal Model
    }
    
}
