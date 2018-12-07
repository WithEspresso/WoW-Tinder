//
//  SettingsAndEditViewController.swift
//  Login
//
//  Created by Danielle Nunez on 12/2/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import Foundation
import UIKit

class SettingsAndEditViewController : UIViewController {
    
    @IBOutlet weak var editProfileLabel: UILabel!
    @IBOutlet weak var charNameLabel: UILabel!
    @IBOutlet weak var charNameField: UITextField!
    @IBOutlet weak var charRealmLabel: UILabel!
    @IBOutlet weak var charRealmField: UITextField!
    
    @IBOutlet weak var selfFactionLabel: UILabel!
    @IBOutlet weak var searchFactionLabel: UILabel!
    
    @IBOutlet weak var selfFactionSelector: UISegmentedControl!
    @IBOutlet weak var searchFactionSelector: UISegmentedControl!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var aboutMeField: UITextView!
    @IBOutlet weak var currentLevelLabel: UILabel!
    @IBOutlet weak var currentLevelField: UITextField!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentLocationField: UITextField!
    @IBOutlet weak var confirmChangesButton: UIButton!
}
