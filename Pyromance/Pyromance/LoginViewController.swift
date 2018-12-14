////
//  LoginViewController.swift
//  Pyromance
//
//  Created by Jimmy Clark on 11/20/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    //Username input field
    @IBOutlet weak var username: UITextField!
    //Password input field
    @IBOutlet weak var password: UITextField!
    
    //Sign in button action
    @IBAction func sign_in(_ sender: UIButton) {
        
        //init inputs as variables
        let enteredUsername = username.text ?? "No Username Entered"
        let enteredPassword = password.text ?? "No Password Entered"
        
        // If Firebase is able to authenticate the user, perform a segue.
        Auth.auth().signIn(withEmail: enteredUsername, password: enteredPassword) { (user, error) in
            if error != nil {
                NSLog("Sign in failed.")
                return
            }
            else {
                NSLog("Sign in successful.")
                self.performSegue(withIdentifier: "loginTransition", sender: self)
            }
        }
    }
    
    var databaseHandle : DatabaseHandle!
    
    /*
     Segues into the main swiping view controller with the user's username.
     Used for pulling potential matches from the database.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let email = Auth.auth().currentUser?.email
        var queriedUsername : String?
        
        let searchRef = Constants.refs.databaseUsers.queryOrdered(byChild: "email").queryEqual(toValue: email)
        searchRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                for data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    print("Found username: \(data.childSnapshot(forPath: "username").value!)")
                    let queriedUsername = data.childSnapshot(forPath: "username").value as? String
                    
                    print("Found server: \(data.childSnapshot(forPath: "server").value!)")
                    let queriedServer = data.childSnapshot(forPath: "server").value as? String
                    
                    let fullUsername = queriedUsername! + "-" + queriedServer!
                    
                    // Saving to UserDefaults
                    UserDefaults.standard.set(fullUsername, forKey: "username")
                    let userDefaultsUsername = UserDefaults.standard.string(forKey: "username")
                    print("From user defaults: \(String(describing: userDefaultsUsername))")
                }
            }
            else {
                print("Doesn't exist")
            }
        })
        
        if segue.identifier == "loginTransition" {
            if let destination = segue.destination as? SwipeViewController {
                destination.username = queriedUsername
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
