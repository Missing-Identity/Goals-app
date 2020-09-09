//
//  UIViewControllerExt.swift
//  Goal-Post-app
//
//  Created by Unmilan on 07/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

extension UIViewController {//We will be overriding the default animations in the view controller.
    
    func presentDetail(_ viewControllerToPresent: UIViewController) {//Underscore will prevent the viewControllerToPresent from showing up everytime.
        let transition = CATransition()
        
        transition.duration = 0.3
        
        transition.type = CATransitionType.push//This replaces kCATransition command from earlier XCode versions. This sets the base animation.
        
        transition.subtype = CATransitionSubtype.fromRight//This tells the system from where the transition starts. Here its from right to left.
        
        self.view.window?.layer.add(transition, forKey: kCATransition)//The kCATransition is a built in key that represents transition animation. We keep self so that all this code applies to whatever View Controller this file is linked to.
        
        present(viewControllerToPresent, animated: false, completion: nil)//This will apply the animation to the view. Note that we keep animated= false as we are overriding the existing animation already so keeping it as true will make our code here obselete.
    }
    
    func presentSecondaryDetail(_ viewControllerToPresent: UIViewController) {//What this code does is that it dismisses the view controller passed into it once that view controller segues to the next one.
        
        let transition = CATransition()
        
        transition.duration = 0.3
        
        transition.type = CATransitionType.push
        
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController = presentedViewController else { return }
        
        presentedViewController.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(viewControllerToPresent, animated: false, completion: nil)
        }
    }
    
    func dismissDetail() {//This function is for dismiss animation.
        
        let transition = CATransition()
               
               transition.duration = 0.3
               
               transition.type = CATransitionType.push
               
               transition.subtype = CATransitionSubtype.fromLeft
        
               self.view.window?.layer.add(transition, forKey: kCATransition)
               
               dismiss(animated: false, completion: nil)
    }//Please note that for all of these to work properly you need to keep a StoryBoard ID in the Main.Storyboard
}
