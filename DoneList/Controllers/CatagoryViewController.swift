//
//  CatagoryViewController.swift
//  DoneList
//
//  Created by Farhan Qazi on 4/17/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import ChameleonFramework
import SVProgressHUD
import FirebaseAuth
import FirebaseDatabase



//let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView();

class CategoryViewController: SwipeTableViewController {
    
var handle: AuthStateDidChangeListenerHandle?
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CategoriesLoader()
        
        tableView.separatorStyle = .none
        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories?.count ?? 1
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        if let category = categories?[indexPath.row] {
            
            cell.textLabel?.text = category.name
            
            guard let categoryColour = UIColor(hexString: category.colour) else {fatalError()}
            
            cell.backgroundColor = categoryColour
            cell.textLabel?.textColor = ContrastColorOf(backgroundColor: categoryColour, returnFlat: true)
            
       }
        
        return cell
        
    }
    
    

    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.CatagorySection = categories?[indexPath.row]
        }
    }

//Step 3: Updated the CategoriesLoader function as below. Please note that we have filetered data based on the logged in userId.

    func CategoriesLoader() {
        guard let uid = Auth.auth().currentUser?.uid else{
            // Since uid is nil, this means that User is not logged in.
            // Show an error and redirect the user on login page.
            return
        }
        
        let allcategories  = realm.objects(Category.self)
        categories = allcategories.filter(NSPredicate(format: "userid = %@", uid))
        
        tableView.reloadData()
        
    }

    
    
    
//    func CategoriesLoader() {
//
//        categories  = realm.objects(Category.self)
//
//        tableView.reloadData()
//
//    }

    
    func saveToRealm(category: Category) {
        do {
            try realm.write {
                realm.add(category)
     
                
            }
        } catch {
            print("Error found while saving category \(error)")
        }
        
        /// Code to Save catagory to firebase
        let catagoryDB = Database.database().reference().child("catagory")
        let catagoryDictionary = [
            "name": category.name, "colour": category.colour, "userid": Auth.auth().currentUser?.uid ]
        catagoryDB.childByAutoId().setValue(catagoryDictionary){
            (error,reference) in
            if error != nil { print( error!)} else {
                print(" Saved to Firebase")
            }
        }
        ///////////////////////////////////////////////////////////
        
        tableView.reloadData()
        
    }
    

    
    override func ModelUpdater(at indexPath: IndexPath) {
        
        if let categoryForDeletion = self.categories?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(categoryForDeletion)
                }
            } catch {
                print("Error found while deleting category, \(error)")
            }
        }
    }
    
    

 //Step 4: Added code to save the userId. The updated addButtonPressed as follow:
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        // SHOWING Activity Indicator while saving Category

        //        self.startLoading()
        SVProgressHUD.show()
        
///**************************OLD
//        var textField = UITextField()
//
//        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
//
//        let action = UIAlertAction(title: "Add", style: .default) { (action) in
//
//            let newCategory = Category()
//            newCategory.name = textField.text!
//            newCategory.colour = UIColor.randomFlat().hexValue()
//
//            self.saveToRealm(category: newCategory)
////********************OLD
        
        // Fetching the UserId of Logged In User.
        guard let uid = Auth.auth().currentUser?.uid else{
            // Since uid is nil, this means that User is not logged in.
            // Show an error and redirect the user on login page.
            return
        }
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.colour = UIColor.randomFlat().hexValue()
            // Adding userId to Category.
            newCategory.userid = uid
            self.saveToRealm(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
        
        //STOP SHOWING Activity Indicator after saving
//          self.stopLoading()
        SVProgressHUD.dismiss()
        
            
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    
    }
    

    

    


