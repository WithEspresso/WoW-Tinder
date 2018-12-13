//
//  InitProfileViewController.swift
//  Pyromance
//
//  Created by Jimmy Clark on 12/12/18.
//

import UIKit

class InitProfileViewController: UIViewController {

    @IBOutlet weak var RealmInput: UITextField!
    @IBOutlet weak var LevelInput: UITextField!
    @IBOutlet weak var FightForSwitch: UISegmentedControl!
    @IBOutlet weak var LookingForSwitch: UISegmentedControl!
    @IBOutlet weak var DescriptionInput: UITextField!
    
    var enteredEmailAddress : String?
    var enteredUsername : String?
    
    @IBAction func ConfirmButton(_ sender: Any) {
        //Add check then segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var confirmButton: UIButton!
    @IBAction func confirmAccountDetails(_ sender: Any) {
        let ref = Constants.refs.databaseUsers.childByAutoId()
        let user_information = ["email": enteredEmailAddress ?? "", "username": enteredUsername ?? "", "server": RealmInput.text, "faction": "Alliance", "level": "120"] as [String : Any]
        ref.setValue(user_information)
        
        // Saving to UserDefaults
        let fullUsername = enteredUsername! + "Stormrage"
        UserDefaults.standard.set(fullUsername, forKey: "username")
        let userDefaultsUsername = UserDefaults.standard.string(forKey: "username")
        print("From user defaults: \(String(describing: userDefaultsUsername))")
        
        performSegue(withIdentifier: "firstTimeLoginTransition", sender: self)
    }
}
