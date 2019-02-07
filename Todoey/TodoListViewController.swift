//
//  ViewController.swift
//  Todoey
//
//  Created by Prijo on 2/6/19.
//  Copyright © 2019 Prijo. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        
        let newItem = Item()
        newItem.title = "Todo1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Todo2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Todo3"
        itemArray.append(newItem3)
        
//        if let items = defaults.array(forKey: "TodoItemArray") as? [Item] {
//            itemArray = items
//        }
    }

    //MARK: - Tableview Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let items = itemArray[indexPath.row]
        
        cell.textLabel?.text = items.title
        cell.accessoryType = items.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - Tableview Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Itemn", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: - Model Manipulation Method
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        } catch {
            print("Error encoding file \(error)")
        }
        tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Errpr emcode data \(error)")
        }
    }
        
    }
    
    
}

