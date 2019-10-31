//
//  UIButtonExt.swift
//  goalPost
//
//  Created by MAC on 11/15/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit

extension UIButton{
    
    func setSelectedColor(){
        
        self.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.8431372549, blue: 0.003921568627, alpha: 1)
        
    }
    func setDeselectedColor(){
        
        self.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.8666666667, blue: 0.6862745098, alpha: 1)
    }
}
