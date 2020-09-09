//
//  FinishGoalVC.swift
//  Goal-Post-app
//
//  Created by Unmilan on 08/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit
import CoreData

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
        if pointsTextField.text != "" {//If the text field isn't empty it triggers this function.
            
        self.save { (complete) in
            if complete {
                dismiss(animated: true, completion: nil)//Dismisses to MainVC
            }
        }
            
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismissDetail()
        
    }
    
    func save(completion: (_ finished: Bool) -> ()) {//This returns an empty function because we don't care what it returns in the end, we just want to pass some values in here and it has to return back the values to us.
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }//This is how we get our managed object context from the main queue.
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue//Bringing out raw value of type goalType.
        goal.goalCompletionValue = Int32(pointsTextField.text!)!//Force casting it to Int32.
        goal.goalProgress = Int32(0)//Initial progress setup.
        
        do{
           try managedContext.save()//This commits to the Content parents store/Persistent store coordinator.
            print("Saved Data properly.")
            completion(true)
        }   catch {
            debugPrint("Could not save: \(error.localizedDescription)")//This writes the texual representation of the given items for debugging.
            completion(false)
        }
    
}
}
