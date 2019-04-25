//
//  ViewController..swift
//  DoneList
//
//  Created by Farhan Qazi on 4/15/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//
import UIKit
import FirebaseUI
import SVProgressHUD



class ViewController: UIViewController {
    let catagory = Category()
    static var userid: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //// Testing login: test@test.com, password: TestTest
    @IBAction func buttontapped(_ sender: Any) {
 
        let AuthUI = FUIAuth.defaultAuthUI()

        guard AuthUI != nil else {
            return
        }

        AuthUI?.delegate = self
        AuthUI?.providers = [FUIEmailAuth()]
 
        let authViewController = AuthUI!.authViewController()
        present(authViewController, animated: true, completion: nil)
    }
    
}


extension ViewController: FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {

        guard error == nil else {
            
            print(error!)
            
            let alertController = UIAlertController(title: "Try Agin...", message:
                "Error finding an Account!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
      
            return
        }

       // catagory.userid = AuthDataResult.user.uid
        
        
        performSegue(withIdentifier: "ProceedToMain", sender: self)
        
    }
    
}


















































