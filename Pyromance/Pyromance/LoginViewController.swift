////
//  LoginViewController.swift
//  Pyromance
//
//  Created by Jimmy Clark on 11/20/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

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
        
        print(enteredUsername)
        print(enteredPassword)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}
