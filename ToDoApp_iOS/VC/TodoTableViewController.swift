//
//  TodoTableViewController.swift
//  ToDoApp_iOS
//
//  Created by Elsa on 02/07/2020.
//  Copyright © 2020 Merita Ahmeti. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {
    // MARK : - Properties
    var resultsController : NSFetchedResultsController<Todo>!
    let coreDatabase = CoreDatabase()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Request
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        let sortDescriptors = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptors]
        //Init
        resultsController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: coreDatabase.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        //Fetch
        do {
            try resultsController.performFetch()
        }catch{
            print("Perform fetch error: \(error)")
        }
        
    }

  
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultsController.sections?[section].objects?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        //Configure the cell ...
        let todo = resultsController.object(at: indexPath)
        cell.textLabel?.text = todo.title

        return cell
    }
    //Mark - TableView delegate
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title:"Delete" ) {(action, view, completion) in
            //Todo: Delete todo
            completion(true)
        
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title:"Check" ) {(action, view, completion) in
            //Todo: Check todo
            completion(true)
            
        }
        action.image = #imageLiteral(resourceName: "check")
        action.backgroundColor = .green
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vc = segue.destination as? AddTodoViewController{
            vc.managedContext = coreDatabase.managedContext
        }
    }
    

}
