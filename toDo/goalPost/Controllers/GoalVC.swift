//
//  ViewController.swift
//  goalPost
//
//  Created by MAC on 11/12/2011 ERA1.
//  Copyright © 2011 ERA1 mamdouh. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {
    
    var goals: [Goal]  = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeAlertView: UIView!
    @IBOutlet weak var undoBtn: UIButton!
    
    var undoDelet: Bool  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self

        tableView.dataSource = self
        tableView.isHidden  = false
        removeAlertView.isHidden = true
}

override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       self.fetchData()
     tableView.reloadData()
    }
    
    @IBAction func undoBtnWasPressed(_ sender: Any) {
        
        removeAlertView.isHidden = true
    }
    func fetchData(){
        self.fetch { (complete) in
            if complete{
                if goals.count >= 1 {
                    tableView.isHidden  = false
                }else{
                    tableView.isHidden  = true
                }
            }
        }
    }
    

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        
        guard let creatGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreatGoalVC")
            else{return}
        
        presentDetail(creatGoalVC)
    }
}
extension  GoalVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let goal = goals[indexPath.row]
        
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCell else{
            return UITableViewCell()
        }
        cell.cellConfig(goal: goal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removeAlertView.isHidden = false
            self.removeGoal(atIndexPath: indexPath)
            self.fetchData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        
        let addAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            self.setProgress(atIndexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        
        return [deleteAction, addAction]
    }
    
    
    

}


extension GoalVC{
    
    func setProgress(atIndexPath indexPath: IndexPath){
      guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal  = goals[indexPath.row]

        if  chosenGoal.goalProgress < chosenGoal.goalCompletionValue{
            chosenGoal.goalProgress = chosenGoal.goalProgress +  1
        }else{
            return
        }
        do{
            try managedContext.save()
            print("updated")
        }catch{
            debugPrint("could not set progress \(error.localizedDescription)")
        }
    }
    
    
    
    func removeGoal(atIndexPath indexPath:IndexPath){
        
       guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        
        managedContext.delete(goals[indexPath.row])
        do{
            try managedContext.save()
            print("removed")
            
        }catch{
            debugPrint("could not remove \(error.localizedDescription)")
        }
    }
    
    func fetch(completion:(_ complete:Bool)->()){
    
        guard let managedContext  = appDelegate?.persistentContainer.viewContext else{return  }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        do{
         goals = try managedContext.fetch(fetchRequest)
            completion(true)
            print("succssuflly fetched data")
        }catch{
            debugPrint("could not fetch \(error.localizedDescription)")
            completion(false)
        }
    }
}

