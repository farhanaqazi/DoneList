//
//  LoginViewController..swift
//  DoneList
//
//  Created by Farhan Qazi on 4/15/19.
//  Copyright © 2019 Farhan Qazi. All rights reserved.
//
import UIKit
import FirebaseUI

class ViewController: UIViewController {
    
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
            
            print("Error found,\(error!)")
      
            return
        }
        
        performSegue(withIdentifier: "ProceedToMain", sender: self)
    }
    
}


















































