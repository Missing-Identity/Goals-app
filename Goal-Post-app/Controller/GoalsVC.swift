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
    
}

extension GoalsVC {
    
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
