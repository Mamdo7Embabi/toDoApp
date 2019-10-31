//
//  CreatGoalVC.swift
//  goalPost
//
//  Created by MAC on 11/13/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit

class CreatGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var goalText: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    var goalType: GoalType = .shortTerm

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.bindToKeyboard()
        
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedColor()
        goalText.delegate = self
    }
    
    @IBAction func longTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn .setDeselectedColor()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn .setDeselectedColor()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        
        if goalText.text != "" && goalText.text != "What is your goal?"{
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: "finishGoalVC") as? FinishGoalVC
                else{return}
            finishGoalVC.intiData(desc: goalText.text!, type: goalType)
            
            presentingViewController?.presentSecodryDetail(finishGoalVC)
        }
        
    }
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismissVC()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        goalText.text = ""
        goalText.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
