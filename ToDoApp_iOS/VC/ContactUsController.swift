//
//  ContactUsController.swift
//  ToDoApp_iOS
//
//  Created by Merita Ahmeti on 7/10/20.
//  Copyright © 2020 Merita Ahmeti. All rights reserved.
//


import UIKit

class ContactUsController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var personTable: UITableView!
    let cellReuseIdentifier = "cell"
    
    var db:DBHelper = DBHelper()
    
    var persons:[Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        personTable.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        personTable.delegate = self
        personTable.dataSource = self
        
        db.insert(id: 1, name: "Elsa", email: "morinaelsa01@gmail.com")
        db.insert(id: 2, name: "Merita", email: "meritaahmeti1998@gmail.com")
        persons = db.read()
    }
    @IBAction func buttonClose(_ sender: UIButton) {
         
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Name: " + persons[indexPath.row].name + "\n" + "Email: " + String(persons[indexPath.row].email)
        
        return cell
    }
}
