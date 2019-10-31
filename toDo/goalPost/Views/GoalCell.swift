//
//  GoalCell.swift
//  goalPost
//
//  Created by MAC on 11/12/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var goalDescLab: UILabel!
    @IBOutlet weak var goalTypeLab: UILabel!
    @IBOutlet weak var goalProgressLab: UILabel!
    
    @IBOutlet weak var completionView: UIView!
    
    func cellConfig(goal:Goal){
        self.goalDescLab.text = goal.goalDesc
        self.goalTypeLab.text = goal.goalType
        self.goalProgressLab.text = String.init(describing: goal.goalProgress)
        
        if goal.goalProgress == goal.goalCompletionValue  {
            self.completionView.isHidden = false
        }else{
           self.completionView.isHidden = true
        }
        
    }
}
