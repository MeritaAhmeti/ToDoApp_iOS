//
//  CoreDatabase.swift
//  ToDoApp_iOS
//
//  Created by Elsa on 02/07/2020.
//  Copyright © 2020 Merita Ahmeti. All rights reserved.
//

import Foundation
import CoreData

class CoreDatabase{
    var container: NSPersistentContainer {
        let container = NSPersistentContainer(name: "MyDatabase")
        container.loadPersistentStores{(description, error) in
            guard error == nil else {
                print("Error: \(error!)")
                return
            }
        }
        return container
    }
    var managedContext: NSManagedObjectContext {
        return container.viewContext
    }
}
