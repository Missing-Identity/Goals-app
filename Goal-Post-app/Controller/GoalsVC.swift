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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else { return UITableViewCell() }
        cell.configureCell(description: "Finish iOS course", type: .shortTerm, goalProgressAmount: 7)
        return cell
    }
    
}
