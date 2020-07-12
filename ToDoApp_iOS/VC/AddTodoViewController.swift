//
//  AddTodoViewController.swift
//  ToDoApp_iOS
//
//  Created by Elsa on 02/07/2020.
//  Copyright © 2020 Merita Ahmeti. All rights reserved.
//

import UIKit
import CoreData

class AddTodoViewController: UIViewController {
    //MARK: - Properties
    var managedContext: NSManagedObjectContext!
    var todo: Todo?
    
    // MARK: Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let todo = todo{
            textView.text = todo.title
            textView.text = todo.title
            segmentedControl.selectedSegmentIndex = Int(todo.priority)
        }
    }
    fileprivate func dismissAndResign() {
        dismiss(animated: true)
        textView.resignFirstResponder()
    }
    @IBAction func cancel(_ sender: Any) {
        
        let alert = UIAlertController(title:"Cancel?" ,    message:"Are you sure you want to cancel?",preferredStyle: .alert)
        let yesButton = UIAlertAction(title:"Yes", style: .default, handler: self.yes)
        let noButton = UIAlertAction(title:"No", style: .cancel ,handler: nil )
        alert.addAction(yesButton)
        alert.addAction(noButton)
        self.present(alert, animated: true, completion: nil)

    }
    
    func yes(alert: UIAlertAction!){
        dismissAndResign()
    }
    
    @IBAction func done(_ sender: Any) {
        guard let title = textView.text, !title.isEmpty else{
            return
        }
        
        if let todo = self.todo{
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
        }else{
            let todo = Todo(context: managedContext)
            todo.title = title
            todo.priority = Int16(segmentedControl.selectedSegmentIndex)
            todo.date = Date()
        }
        do{
            try managedContext.save()
            dismissAndResign()
        }catch{
            print("Error saving Todo: \(error)")
        }
    }
    
}

extension AddTodoViewController: UITextViewDelegate{
    func textViewDidChangeSelection(_ textView: UITextView) {
        if doneButton.isHidden{
            textView.text.removeAll()
            textView.textColor = .white
            
            doneButton.isHidden = false
            
            UIView.animate(withDuration: 0.3){
                self.view.layoutIfNeeded()
            }
        }
    }
}
