//
//  Person.swift
//  ToDoApp_iOS
//
//  Created by Merita Ahmeti on 7/10/20.
//  Copyright © 2020 Merita Ahmeti. All rights reserved.
//

import Foundation

class Person{
    
    var name: String = ""
    var email: String = ""
    var id: Int = 0
    
    init(id:Int, name:String, email:String){
        self.id = id
        self.name = name
        self.email = email
    }
}
