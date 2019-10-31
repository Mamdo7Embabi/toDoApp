//
//  FinishGoalVC.swift
//  goalPost
//
//  Created by MAC on 11/15/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit

class FinishGoalVC: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var finishGoalBtn: UIButton!
    @IBOutlet weak var pointTxt: UITextField!
    
    var goalDesc: String!
    var goalType: GoalType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        finishGoalBtn.bindToKeyboard()
        pointTxt.delegate = self
    }
    
    
    func intiData(desc: String, type: GoalType){
        self.goalDesc = desc
        self.goalType = type
    }
    

    @IBAction func finishGoalWasPressed(_ sender: Any) {
        if pointTxt.text != ""{
            self.save { (complete) in
                if complete{
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismissVC()
        
    }
    
    
    func save(completion: (_ finish:Bool)->()){
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let goal = Goal(context: managedContext)
        
        goal.goalDesc = goalDesc
        goal.goalCompletionValue = Int32(pointTxt.text!)!
        goal.goalType = goalType.rawValue
        goal.goalProgress = Int32(0)
        
        do{
            try managedContext.save()
            completion(true)
            
            print("successfully save data")
            
        }catch{
            debugPrint("Data not saved \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
