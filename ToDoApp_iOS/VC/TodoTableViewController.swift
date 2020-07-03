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
        resultsController.delegate = self
        //Fetch
        do {
            try resultsController.performFetch()
        }catch{
            print("Perform fetch error: \(error)")
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsController.sections?[section].numberOfObjects ?? 0
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
            let todo = self.resultsController.object(at: indexPath)
            self.resultsController.managedObjectContext.delete(todo)
            do{
                try self.resultsController.managedObjectContext.save()
                completion(true)
            }
            catch{
                print("delete failed: \(error)")
                completion(false)
            }
        }
        action.image = #imageLiteral(resourceName: "trash")
        action.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title:"Check" ) {(action, view, completion) in
            let todo = self.resultsController.object(at: indexPath)
            self.resultsController.managedObjectContext.delete(todo)
            do{
                try self.resultsController.managedObjectContext.save()
                completion(true)
            }
            catch{
                print("delete failed: \(error)")
                completion(false)
            }
        }
        action.image = #imageLiteral(resourceName: "check")
        action.backgroundColor = .green
    
        return UISwipeActionsConfiguration(actions: [action])
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowAddTodo", sender: tableView.cellForRow(at: indexPath))
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let _ = sender as? UIBarButtonItem, let vc = segue.destination as? AddTodoViewController{
            vc.managedContext = resultsController.managedObjectContext
        }
        if let cell = sender as? UITableViewCell, let vc = segue.destination as? AddTodoViewController{
            vc.managedContext = resultsController.managedObjectContext
            if let indexPath = tableView.indexPath(for: cell){
            let todo = resultsController.object(at: indexPath)
            vc.todo = todo
            }
        }
    }
}
extension TodoTableViewController: NSFetchedResultsControllerDelegate{
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath{
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath{
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .update:
            if let indexPath = indexPath, let cell = tableView.cellForRow(at: indexPath){
                let todo = resultsController.object(at: indexPath)
                cell.textLabel?.text = todo.title
            }
        default:
            break
        }
    }
}
