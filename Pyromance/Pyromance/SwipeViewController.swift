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
    @IBAction func dislike(_ sender: UIButton) {
        print("\(String(describing: username)) Disliked: ")
        // Hardcoded values for debugging.
        let nextImage = "https://render-us.worldofwarcraft.com/character/stormrage/216/196027864-main.jpg"
        self.loadNextImage(currentImageUrl: nextImage)
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func like(_ sender: UIButton) {
        print("\(String(describing: username)) Liked: ")
        let nextImage = "https://render-eu.worldofwarcraft.com/character/stormrage/63/135139903-main.jpg"
        self.loadNextImage(currentImageUrl: nextImage)
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var swipeView: SwipeView!
    
    // Holds information about the user logged in.
    var username: String!
    var server: String?
    var level: String?
    
    // Holds information about the current user being passed judgement
    var imageUrls: [String?] = []
    var potentialMatchUsers: [String] = []
    
    var urlKey = URL(string: "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg")!
    let session = URLSession(configuration: .default)
    
    /* Loads the current user from NSUserDefaults, asks the database to load potential matches,
     and then loads the original image.
     @param:    None
     @return:   None
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        username = UserDefaults.standard.string(forKey: "username")
        
        // Debug
        print("Username in SwipeViewController is: ")
        print(String(describing: username))
        
        self.loadNextUser()
        
        // Loads image.
        imageView.image = UIImage(named: "imageView")
        
        let defaultImageUrl = "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg"
        //if imageUrls.count > 0 {
        //let currentImageUrl : String = imageUrls[0] ?? defaultImageUrl
        let currentImageUrl = defaultImageUrl
        if let url = NSURL(string: currentImageUrl){
            if let data = NSData(contentsOf: url as URL){
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    
    /*
     Passes username in segue to the next screen.
     @param:    None
     @return:   None
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "contactsTableTransition" {
            if let destinationVC = segue.destination as? ContactsTableViewController {
                //Some property on destinationVC that needs to be set
                destinationVC.sender = self.username
            }
        }
    }
    
    /*
     Updates the image being shown.
     */
    func loadNextImage(currentImageUrl: String) {
        // Hardcoded for testing.
        //let currentImageUrl = "https://render-eu.worldofwarcraft.com/character/stormrage/63/135139903-main.jpg"
        if let url = NSURL(string: currentImageUrl){
            if let data = NSData(contentsOf: url as URL){
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    /*
     Loads the image path from the database of the next user to be judged.
     @param:    None
     @return:   None
     */
    func loadNextUser() {
        print("Inside getNextUser!")
        Constants.refs.databaseUsers.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.exists() {
                print("Found existing snapshot!")
                print("Number of users found: \(snapshot.childrenCount)")               //   Number of users
                for data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    //let imageUrl = data.childSnapshot(forPath: "image").value as! String
                    //let username = data.childSnapshot(forPath: "username").value as! String
                    print("Found image: \(data.childSnapshot(forPath: "image").value as! String)")
                    print("Found username: \(data.childSnapshot(forPath: "username").value as! String)")
                    self.imageUrls.append(data.childSnapshot(forPath: "image").value as? String)
                    self.potentialMatchUsers.append(data.childSnapshot(forPath: "username").value as? String ?? "")
                }
            }
        })
        
        /*
         let searchRef = Constants.refs.databaseUsers.queryOrdered(byChild: "username")
         _ = searchRef.observe(.value, with: { (snapshot) in
         print("Inside get next user closure!!!!")
         print(snapshot)
         })
         print("Finished searching")
         */
        /*
         _ = searchRef.observe(.value, with: { (snapshot) in
         // let data = ((snapshot.value) as? [String: AnyObject])
         print("Inside get next user closure!!!!")
         print("Number of users found: \(snapshot.childrenCount)")               //   Number of users
         for data in snapshot.children.allObjects as! [DataSnapshot]
         {
         //let imageUrl = data.childSnapshot(forPath: "image").value as! String
         //let username = data.childSnapshot(forPath: "username").value as! String
         print("Found image: \(data.childSnapshot(forPath: "image").value as! String)")
         print("Found username: \(data.childSnapshot(forPath: "username").value as! String)")
         self.imageUrls.append(data.childSnapshot(forPath: "image").value as! String)
         self.potentialMatchUsers.append(data.childSnapshot(forPath: "username").value as! String)
         }
         })
         */
    }
}


