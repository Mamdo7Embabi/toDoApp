//
//  UIViewControllerExt.swift
//  goalPost
//
//  Created by MAC on 11/15/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit

extension UIViewController{
    func presentDetail(_ viewControllerToPresent:UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
       present(viewControllerToPresent, animated: false, completion: nil)
    }
    func presentSecodryDetail(_ viewControllerToPresent:UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        
        guard let presentedViewController  = presentedViewController else{return}
        presentedViewController.dismiss(animated: false) {
            
        self.view.window?.layer.add(transition, forKey: kCATransition)
        self.present(viewControllerToPresent, animated: false, completion: nil)
        }
        
        
    }
    func dismissVC(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
}
