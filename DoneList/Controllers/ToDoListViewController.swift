//
//  ToDoListViewController.swift
//  DoneList
//
//  Created by Farhan Qazi on 4/17/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
import ChameleonFramework
import Firebase
import FirebaseDatabase

class TodoListViewController: SwipeTableViewController {
    
    var toBeDoneItems: Results<Item>?
    let realm = try! Realm()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var CatagorySection : Category? {
        didSet{
            itemsLoader()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        title = CatagorySection?.name
        
        guard let colourHex = CatagorySection?.colour else { fatalError() }
        
        updateNav(withHexCode: colourHex)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        updateNav(withHexCode: "d9f640")
        
    }
    

    
    func updateNav(withHexCode colourHexCode: String){
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        
        guard let navBarColour = UIColor(hexString: colourHexCode) else { fatalError()}
        
        navBar.barTintColor = navBarColour
        
        navBar.tintColor = ContrastColorOf(backgroundColor: navBarColour, returnFlat: true)
        
        navBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : ContrastColorOf(backgroundColor: navBarColour, returnFlat: true)]
        
        searchBar.barTintColor = navBarColour
        
    }
    
    
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toBeDoneItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let item = toBeDoneItems?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            if let colour = UIColor(hexString: CatagorySection!.colour)?.darken(byPercentage: CGFloat(indexPath.row) / CGFloat(toBeDoneItems!.count)) {
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(backgroundColor: colour, returnFlat: true)
            }

            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toBeDoneItems?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                print("Opps! Encountered an Error saving the done status, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
 
    @IBAction func addButtonAction(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clicks the Add Item button on our UIAlert
            
            if let currentCategory = self.CatagorySection {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                        /// Code to save newItem to fire to be inserte here
                        let newItemDB = Database.database().reference().child("newItem")
                        let newItemDictionary = [
                            "title" : newItem.title, "done": newItem.done
                            
                            ] as [String : Any]
                        newItemDB.childByAutoId().setValue(newItemDictionary ) {
                            (error,reference) in
                            if error != nil {
                                print (error!)
                            }else
                            {
                                print("Saved to Firebase")
                            }
                            
                        }
 
                    }
                } catch {
                    print("Sorry! Error in Saving, \(error)")
                }
            }
            
          
            
            
            
            
            
            
            
            /////
            
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
 
    
    
    func itemsLoader() {
        
        toBeDoneItems = CatagorySection?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
        
    }
    
    override func ModelUpdater(at indexPath: IndexPath) {
        if let item = toBeDoneItems?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(item)
                }
            } catch {
                print("Error found while deleting Item, \(error)")
            }
        }
    }
    
}



extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toBeDoneItems = toBeDoneItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
        tableView.reloadData()
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            itemsLoader()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
