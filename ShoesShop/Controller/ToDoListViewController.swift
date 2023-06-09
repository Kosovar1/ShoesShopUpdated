//
//  ToDoListViewController.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 02/05/2023.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)
        loadItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
           let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
           let addAction = UIAlertAction(title: "Add Item", style: .default) { (action) in
               guard let title = textField.text, !title.isEmpty else {
                   let emptyTitleAlert = UIAlertController(title: "Error", message: "Please enter a title for the item.", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default)
                   emptyTitleAlert.addAction(okAction)
                   self.present(emptyTitleAlert, animated: true, completion: nil)
                   return
               }
               let newItem = Item()
               newItem.title = textField.text!
               newItem.done = false
               self.itemArray.append(newItem)
               self.saveItems()
           }
           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
           alert.addTextField { (alertTextField) in
               alertTextField.placeholder = "Create New Item"
               textField = alertTextField
           }
           alert.addAction(addAction)
           alert.addAction(cancelAction)
           present(alert, animated: true, completion: nil)
       }
       
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
               DispatchQueue.main.async {
                   self.deleteItem(at: indexPath.row)
                   self.tableView.deleteRows(at: [indexPath], with: .fade)
               }
           }
       }
       
       func deleteItem(at index: Int) {
           
           itemArray.remove(at: index)
       }
       
       func saveItems() {
           let encoder = PropertyListEncoder()
           do {
               let data = try encoder.encode(itemArray)
               try data.write(to: dataFilePath!)
           } catch {
               print("error saving context,\(error)")
           }
           self.tableView.reloadData()
       }
       
       func loadItems() {
           if let data = try? Data(contentsOf: dataFilePath!) {
               let decoder = PropertyListDecoder()
               do {
                   itemArray = try decoder.decode([Item].self, from: data)
               } catch {
                print("error decodinc item array, \(error)")
            }
        }
    }
}
