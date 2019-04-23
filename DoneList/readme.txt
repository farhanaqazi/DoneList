# DoneList

Simple yet, extreemly handy application for iOS, The DONELIST is an app that first,  for the sake of privacy and user log to be maintained on the server side, allows user to First Login using the google account, via firebase API. Second, this app lets user to create multiple categories of their to do lists. Once user has created a category, the app proceeds to screen where users are allowed to add multiple items under the category. Each Item, just like each distinct category would show a unique color. At the end, based on the completion of the item under the category, user should be able to mark each item with a check mark that will be considered DONE. The app has Realm library ingrained to activate the persistence function. In future, the app can be enhanced for with a corporate version as many orgaizations use their own login mechanism to access the propriatery information. Each member of the organization has a seperate preference of a running checklist, that they would like to maintain. Additonally, School going students can find this app handy as it covers homework assignments of their different classes that can be saved in seperate color via their personal email login.



# Implementation

The app consists of 4 view constrollers. The ViewController.swift is for the login. CatagoryViewController saves the model to Realm and retrieves and updates the model, updates the tableview etc. ToDoListViewController activates and recives action from a search bar, to record the Items created under each catagory of the tableviewcontroller. SwipeTableViewController implements the swipecellkit to enhance the functioning of the swipe action by the user under each catagory and items.

# How to build

This app utilized Firebase login to record the user data on the server side and then after access is granted, user is allowed to enter into their personal checklist. The user can add the catagories and items under each catagories and mark it with a check sign once completed.

# Requirements

Xcode 9.2
Swift 4.0
.....







