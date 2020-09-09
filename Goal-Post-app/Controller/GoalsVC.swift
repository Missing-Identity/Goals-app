//
//  GoalsVC.swift
//  Goal-Post-app
//
//  Created by Unmilan on 04/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate//Public AppDelegate available to all classes.

class GoalsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var goals: [Goal] = []//This is the variable where our fetched Goals will be saved.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("View will appear")
        fetchCoreDataObjects()
        tableView.reloadData()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if goals.count > 0 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }

    @IBAction func addGoalBtnwasPressed(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(identifier: "CreateGoalVC") else {
            return//This will let us exit this with no error in case the view controller identifier is wrong.
        }
        presentDetail(createGoalVC)//This presents the custom animation on Btn press and note that presentDetail function is available only in UIViewController.
    }
    
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        let goal = goals[indexPath.row]
        cell.configureCell(goal: goal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {//This enables the row to be edited.
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {//This is for picking the type of editing style here.
        return .none//We keep none here cause we have a custom configuration here.
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {//This code adds a "DELETE" button to a swipe action.
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeGoal(atIndexPath: indexPath)//This removes the row data from the index path from self.
            self.fetchCoreDataObjects()//This updates the table after a row data is deleted.
            
            tableView.deleteRows(at: [indexPath], with: .automatic)//This removes the row and animates the closing.
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }//This code adds a "ADD 1" button to the swipe action.
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1) //Sets colour to the delete button.
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1) //Sets colour to the add button.
        
        return [deleteAction, addAction]//Remember to keep this in an array as its expecting return type to be array.
    }
    
}

extension GoalsVC {
    
    func setProgress(atIndexPath indexPath: IndexPath) {//This function will allow us to set progress.
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let chosenGoal = goals[indexPath.row]//Getting the goal data in the chosen index
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {//Code will trigger only if progress is less than completion value.
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1//Adding 1 point to goal progress.
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("Sucessfully set progress")
        } catch {
            debugPrint("Could not set progress: \(error.localizedDescription)")
        }
    }
    
    func removeGoal(atIndexPath indexPath: IndexPath) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(goals[indexPath.row])//This deletes a specific cell data depending on index.
        
        do {
            try managedContext.save()//We are updating the core data here saying that we deleted a cell data.
            print("Successfully removed goal.")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")//Fetching Goal enitity from data model.
        do{
            
            goals = try managedContext.fetch(fetchRequest)//Returns array of whatever request we ask for. In this case it is Goal.
            print("Fetched Data")
            completion(true)
            
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            print("Could not fetch")
            completion(false)
        }
        
    }
}
