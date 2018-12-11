//
//  ViewController.swift
//  Login
//
//  Created by Jimmy Clark on 11/20/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit
import Firebase

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
    
    //boolean for if checkbox is checked
    var isChecked = false
    //check box button
    @IBOutlet weak var checkBox: UIButton!
    //action if check box is clicked
    @IBAction func checkClicked(_ sender: UIButton) {
        //invert bool
        isChecked = !isChecked
        
        //if checked
        if (isChecked){
            //set to checked image
            let img = UIImage(named: "checkBoxFILLED")
            checkBox.setBackgroundImage(img, for: UIControl.State.normal)
        } else {
            //set to unchecked image
            let img = UIImage(named: "checkBoxOUTLINE")
            checkBox.setBackgroundImage(img, for: UIControl.State.normal)
        }
    }
    
    //Sign up button action
    @IBAction func sign_up(_ sender: UIButton) {
        
        //init all inputs as variables
        let enteredUsername = username.text ?? ""
        let enteredEmailAddress = emailAddress.text ?? ""
        let enteredPassword = password.text ?? ""
        let enteredConfirmationPassword = confirmPassword.text ?? ""
        let didAgeCheck = isChecked
        
        if (enteredPassword == enteredConfirmationPassword){
            confirmationError.text = ""
            if (didAgeCheck){
                print(enteredUsername)
                print(enteredEmailAddress)
                print(enteredPassword)
                print(enteredConfirmationPassword)
                print(didAgeCheck)
                //Registration is done here.
                Auth.auth().createUser(withEmail: enteredEmailAddress, password: enteredPassword) { (authResult, error) in
                    guard let user = authResult?.user else { return }
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = enteredUsername
                    
                    let ref = Constants.refs.databaseUsers.childByAutoId()
                    // Placeholder hardcoded profile
                    let user_information = ["email": enteredEmailAddress, "username": enteredUsername, "server": "Stormrage", "faction": "Alliance", "level": "120"]
                    ref.setValue(user_information)
                }
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
        isChecked = false
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

