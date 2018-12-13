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
            checkBox.setBackgroundImage(img, for: UIControlState.normal)
        } else {
            //set to unchecked image
            let img = UIImage(named: "checkBoxOUTLINE")
            checkBox.setBackgroundImage(img, for: UIControlState.normal)
        }
    }
    
    @IBOutlet weak var signUpButton: UIButton!
    
    /* Sign up button action
     @param:    UIButton as sender
     @return:   None
     */
    @IBAction func sign_up(_ sender: UIButton) {
        let enteredUsername = username.text ?? ""
        let enteredEmailAddress = emailAddress.text ?? ""
        let enteredPassword = password.text ?? ""
        let enteredConfirmationPassword = confirmPassword.text ?? ""
        let didAgeCheck = isChecked
        if (enteredPassword == enteredConfirmationPassword){
            confirmationError.text = ""
            if (didAgeCheck) {
                print(enteredUsername)
                print(enteredEmailAddress)
                print(enteredPassword)
                print(enteredConfirmationPassword)
                print(didAgeCheck)
                
                //Registration is done here. If the user is logged in at
                Auth.auth().createUser(withEmail: enteredEmailAddress, password: enteredPassword){ (authResult, error) in
                    guard let user = authResult?.user
                        else {
                            //Transitions back to login view once registration completes
                            self.performSegue(withIdentifier: "regToInitprofile", sender: self)
                            return
                    }
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = enteredUsername
                }
            } else {
                print("Did not check age")
            }
        } else {
            confirmationError.text = "Passwords do not match!"
        }
    }
    
    /*
     Segues into the other view controller with the desired contact to message.
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? InitProfileViewController {
            destination.enteredEmailAddress = self.emailAddress.text
            destination.enteredUsername = self.username.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isChecked = false
        // Do any additional setup after loading the view, typically from a nib.
    }
}

