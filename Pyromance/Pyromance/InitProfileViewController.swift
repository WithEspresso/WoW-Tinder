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
    var image: String?
    
    var blizzardAPICaller : BlizzardAPICaller?
    
    @IBAction func ConfirmButton(_ sender: Any) {
        //Add check then segue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var confirmButton: UIButton!
    @IBAction func confirmAccountDetails(_ sender: Any) {
        //self.getUserProfileFromBlizzardAPI(username: enteredUsername as! String, realm: RealmInput.text as! String)
        let username = enteredUsername
        blizzardAPICaller = BlizzardAPICaller.init(characterName: username, realm: "Stormrage")
        let image : String? = blizzardAPICaller?.getThumbnail(characterName: username ?? "Skarmorite", realm: "Stormrage")
            ?? "https://bnetproduct-a.akamaihd.net//26/108f97e24b8b60b4c132e42c0ee956d8-WoW_Letters_Icon_optimized.png"
        let ref = Constants.refs.databaseUsers.childByAutoId()
        let user_information = ["email": enteredEmailAddress ?? "",
                                "username": enteredUsername ?? "",
                                "server": RealmInput.text,
                                "image": image,
                                "faction": "Alliance",
                                "level": "120"] as [String : Any]
        ref.setValue(user_information)
        
        // Saving to UserDefaults
        let fullUsername = enteredUsername! + "-Stormrage"
        UserDefaults.standard.set(fullUsername, forKey: "username")
        let userDefaultsUsername = UserDefaults.standard.string(forKey: "username")
        print("From user defaults: \(String(describing: userDefaultsUsername))")
        
        performSegue(withIdentifier: "firstTimeLoginTransition", sender: self)
    }
    
    func getUserProfileFromBlizzardAPI(username: String, realm: String) -> Bool {
        do {
            self.blizzardAPICaller = BlizzardAPICaller.init(characterName: username, realm: realm)
            self.image = blizzardAPICaller?.getImage()
            print("Image in Profile creator is: \(self.image)")
            return true
        }
        catch {
            return false
        }
    }
}
