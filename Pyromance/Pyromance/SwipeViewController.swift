//
//  SwipeViewController.swift
//  Login
//
//  Created by Jimmy Clark on 12/1/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit
import Firebase

class SwipeViewController: UIViewController {
    
    @IBAction func goToProfile(_ sender: Any) {
    }
    
    @IBAction func goToMessages(_ sender: Any) {
    }
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBAction func dislike(_ sender: Any) {
        print("\(String(describing: username)) Disliked: ")
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func like(_ sender: Any) {
        print("\(String(describing: username)) Liked: ")
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    // Holds information about the user logged in.
    var username: String!
    var server: String?
    var level: String?
    // End user info
    
    var urlKey = URL(string: "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg")!
    let session = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gets username
        let email = Auth.auth().currentUser?.email
        var queriedUsername : String!
        let searchRef = Constants.refs.databaseUsers.queryOrdered(byChild: "email").queryEqual(toValue: email)
        searchRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                for data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    print(data.childSnapshot(forPath: "username").value!)
                    queriedUsername = data.childSnapshot(forPath: "username").value as? String
                    self.username = queriedUsername as String
                }
            }
            else {
                print("Doesn't exist")
            }
        })
        // End Gets username
        
        
        // Loads image.
        imageView.image = UIImage(named: "imageView")
        if let url = NSURL(string: "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg"){
            if let data = NSData(contentsOf: url as URL){
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactsTableTransition" {
            if let destinationVC = segue.destination as? ContactsTableViewController {
                //Some property on destinationVC that needs to be set
                destinationVC.sender = self.username
            }
        }
    }
    
    /*
    func getNextUser() {
        // Gets username
        //let searchRef = Constants.refs.databaseUsers.queryOrdered(byChild: "email").queryEqual(toValue: email)
        searchRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                for data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    print(data.childSnapshot(forPath: "username").value!)
                    queriedUsername = data.childSnapshot(forPath: "username").value as? String
                    self.username = queriedUsername as String
                }
            }
            else {
                print("Doesn't exist")
            }
        })
        // End Gets username
    }
     */
    
    @IBOutlet weak var swipeView: SwipeView!
    
}
