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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func nextBtnWasPressed(_ sender: Any) {
    }
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
    }
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)//The dismiss function along with nil completion basically dismisses the segues without doing anything else.
        
    }
    
}
