//
//  SwipeViewController.swift
//  Login
//
//  Created by Jimmy Clark on 12/1/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit
import Firebase

class SwipeViewController: UIViewController, CardSwipeDelegate {
    
    @IBAction func goToProfile(_ sender: Any) {
    }
    
    @IBAction func goToMessages(_ sender: Any) {
    }
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var swipeView: SwipeView!
    
    @IBOutlet weak var cardViewProfileImageView: UIImageView!
    @IBOutlet weak var cardViewLevelLabel: UILabel!
    @IBOutlet weak var cardViewNameLabel: UILabel!
    @IBOutlet weak var cardViewRealmLabel: UILabel!
    @IBOutlet weak var cardViewClassLabel: UILabel!
    @IBOutlet weak var cardViewDescriptionLabel: UILabel!
    
    // Holds information about the current user being passed judgement
    var imageUrls: [String?] = []
    var potentialMatches: [PotentialMatch] = []
    var potentialMatchIndex = 0
    
    func updateCardView(){
        potentialMatchIndex += 1
        if potentialMatchIndex > potentialMatches.count - 1 {
            potentialMatchIndex = 0
        }
        
        let currentPotentialMatch : PotentialMatch = potentialMatches[potentialMatchIndex]
        self.loadNextImage(currentImageUrl: currentPotentialMatch.image)
        self.updatePotentialMatchNameLabel(newUsername: currentPotentialMatch.getFullUsername())
        self.cardViewLevelLabel.text = "120"
//        self.cardViewClassLabel.text = potentialMatches[potentialMatchIndex].characterClass ?? "hunter"
        self.cardViewClassLabel.text = "Hunter"
        self.cardViewRealmLabel.text = "Stromrage"
        self.cardViewDescriptionLabel.text = "I liek game. loooking 4 luv"
        
    }
    
    @IBAction func dislike(_ sender: UIButton) {
        print("\(String(describing: username)) Disliked: ")
        self.updateCardView()
    }
    
    @IBAction func like(_ sender: UIButton) {
        print("\(String(describing: username)) Liked: ")
        self.addLIkeToDatabase()
        self.updateCardView()
    }
    
    func dislikeSwipe(_ cardView:UIView){
        print("\(String(describing: username)) Disliked: ")
        self.updateCardView()
    }
    func likeSwipe(_ cardView:UIView){
        print("\(String(describing: username)) Liked: ")
        self.addLIkeToDatabase()
        self.updateCardView()
    }
    
    @IBOutlet weak var potentialMatchUsernameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    // Holds information about the user logged in.
    var username: String!
    var server: String?
    var level: String?
    
    
    
    var urlKey = URL(string: "zhttps://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg")!
    let session = URLSession(configuration: .default)
    
    func addLIkeToDatabase() {
        let ref = Constants.refs.databaseLikes.child(self.username)
        let likedUser = potentialMatchUsernameLabel.text
        ref.childByAutoId().setValue(likedUser)
        print("Added new like to database: \(String(describing: self.username)) now likes \(String(describing: likedUser))")
    }
    
    /* Loads the current user from NSUserDefaults, asks the database to load potential matches,
     and then loads the original image.
     @param:    None
     @return:   None
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeView.delegate = self
        username = UserDefaults.standard.string(forKey: "username")
        
        // Debug
        print("Username in SwipeViewController is: ")
        print(String(describing: username))
        
        self.loadPotentialMatchesFromDatabase()
        // Update name label
        let nextUsername = "Lehk-Stormrage"
        updatePotentialMatchNameLabel(newUsername: nextUsername)
        // Loads image.
        imageView.image = UIImage(named: "imageView")
        
        let defaultImageUrl = "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg"
        //if imageUrls.count > 0 {
        //let currentImageUrl : String = imageUrls[0] ?? defaultImageUrl
        let currentImageUrl = defaultImageUrl
        if let url = NSURL(string: currentImageUrl){
            if let data = NSData(contentsOf: url as URL){
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    /*
     Updates the name label.
     @param:    String of the new name to display as a label
     @return:   None
     */
    func updatePotentialMatchNameLabel(newUsername: String) {
        potentialMatchUsernameLabel.text = newUsername
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
                imageView.contentMode = UIViewContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
    }
    
    /*
     Creates potential matches from querying the database and add it to an array.
     @param:    None
     @return:   None
     */
    func loadPotentialMatchesFromDatabase() {
        print("Inside getNextUser!")
        Constants.refs.databaseUsers.observe(DataEventType.value, with: { (snapshot) in
            if snapshot.exists() {
                print("Found existing snapshot!")
                print("Number of users found: \(snapshot.childrenCount)")               //   Number of users
                for data in snapshot.children.allObjects as! [DataSnapshot]
                {
                    if let queriedImageUrl = data.childSnapshot(forPath: "image").value {
                        if let queriedUsername = data.childSnapshot(forPath: "username").value {
                            print("Creating new potential match from: ")
                            let image = data.childSnapshot(forPath: "image").value ?? ""
                            print("Found image: \(image)")
                            print("for username: \(data.childSnapshot(forPath: "username").value as! String)")
                            let newPotentialMatch = PotentialMatch.init(username: queriedUsername as! String, image: queriedImageUrl as! String)
                            self.potentialMatches.append(newPotentialMatch)
                        }
                    }
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
