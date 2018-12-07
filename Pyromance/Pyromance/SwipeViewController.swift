//
//  SwipeViewController.swift
//  Login
//
//  Created by Jimmy Clark on 12/1/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {
    
    @IBAction func goToProfile(_ sender: Any) {
    }
    
    @IBAction func goToMessages(_ sender: Any) {
    }
    
    @IBOutlet weak var dislikeButton: UIButton!
    @IBAction func dislike(_ sender: Any) {
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func like(_ sender: Any) {
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var urlKey = URL(string: "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg")!
    let session = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "imageView")
        if let url = NSURL(string: "https://render-us.worldofwarcraft.com/character/stormrage/97/196163681-main.jpg"){
            if let data = NSData(contentsOf: url as URL){
                imageView.contentMode = UIView.ContentMode.scaleAspectFit
                imageView.image = UIImage(data: data as Data)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var swipeView: SwipeView!
    
}
