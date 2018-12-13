//
//  ProfileViewController.swift
//  Pyromance
//
//  Created by Jimmy Clark on 12/12/18.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var RealmLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var IFightForSwitch: UISegmentedControl!
    @IBOutlet weak var LookingForSwitch: UISegmentedControl!
    
    @IBOutlet weak var DescriptionLabel: UITextView!
    @IBOutlet weak var LevelLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    
    @IBAction func MakeChangesButton(_ sender: Any) {
    }
}
