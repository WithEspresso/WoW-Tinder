//
//  ViewController.swift
//  Login
//
//  Created by Jimmy Clark on 11/20/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    //username input field
    @IBOutlet weak var username: UITextField!
    //error message label for username
    @IBOutlet weak var userNameError: UILabel!
    
    //email address input field
    @IBOutlet weak var emailAddress: UITextField!
    //error message label for email address
    @IBOutlet weak var emailAddressError: UILabel!
    
    //password input field
    @IBOutlet weak var password: UITextField!
    //error message label for password
    @IBOutlet weak var passwordError: UILabel!
    
    //confirmation password input field
    @IBOutlet weak var confirmPassword: UITextField!
    //error message for confirmation of matching passwords
    @IBOutlet weak var confirmationError: UILabel!
    
    //Boolean for if checked age is greater than 18
    @IBOutlet weak var ageCheck: UISwitch!
    
    //Sign up button action
    @IBAction func sign_up(_ sender: UIButton) {
        
        //init all inputs as variables
        let enteredUsername = username.text ?? ""
        let enteredEmailAddress = emailAddress.text ?? ""
        let enteredPassword = password.text ?? ""
        let enteredConfirmationPassword = confirmPassword.text ?? ""
        let didAgeCheck = ageCheck.isOn
        
        if (enteredPassword == enteredConfirmationPassword){
            confirmationError.text = ""
            if (didAgeCheck){
                print(enteredUsername)
                print(enteredEmailAddress)
                print(enteredPassword)
                print(enteredConfirmationPassword)
                print(didAgeCheck)
                //do login here
                
                //Transitions back to login view once registration completes
                performSegue(withIdentifier: "RegtoLogin", sender: self)
            } else {
                print("Did not check age")
            }
        } else {
            confirmationError.text = "Passwords do not match!"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

