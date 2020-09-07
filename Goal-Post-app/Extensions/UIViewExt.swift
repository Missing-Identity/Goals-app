//
//  UIViewExt.swift
//  Goal-Post-app
//
//  Created by Unmilan on 07/09/20.
//  Copyright © 2020 Unmilan. All rights reserved.
//

import UIKit

extension UIView {
    
    func bindToKeyboard() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)//This binds the keyboard notification to whatever we wanna bind it to. The observer has to be self. The selector parameters contains the function that the keyboard will change which is responsible for the animation.
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double//This identifies the duration of the animation in seconds. We HAVE to force cast it to be double.
        
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt//This sets the type of animation curve(ease in/ ease out or follow keyboard frames etc.) In this case we are making it follow the keyboard notification frames. We HAVE to force cast it as UInt.
        
        let startingFrame = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue//This captures the frame of the keyboard when its below the screen, i.e. before it comes up. We also need to convert it into CGRect to make it a rectangle to put it above the keyboard. Before we can pull CGRect value we have to force cast it as NSValue(Its a container for a single C or obj C data item).
        
        let endingFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue//This captures the end frame of keyboard(Once its up).
        
        let deltaY = endingFrame.origin.y - startingFrame.origin.y//We are subtracting the top y frame with bottom y frame to see how much our button moves up.
        
        UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions(rawValue: curve), animations: { self.frame.origin.y += deltaY }, completion: nil)//The animations section basically telling how high our keyboard is going up and animate the button that way. Remember to keep flower brackets for animations.
    }
}
