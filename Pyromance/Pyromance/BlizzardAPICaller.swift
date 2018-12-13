//
//  BlizzardAPICaller.swift
//  Pyromance
//
//  Created by Danielle Nunez on 12/13/18.
//

/*
 This class contains static functions to interact with the Blizzard API and parses
 JSON data retreived from the API calls. Access tokens will be moved to file after project is
 out of production stage.
 */

import Foundation

class BlizzardAPICaller {
    
    let accessToken : String = "USmxnkyZXIt7lXAri5seZSrkcgBW0dd28C"
    
    let raceDictionary : Dictionary = [
        1: "Human",
        2: "Orc",
        3: "Dwarf",
        4: "Night Elf",
        5: "Undead",
        6: "Tauren",
        7: "Gnome",
        8: "Troll",
        9: "Goblin",
        10: "Blood Elf",
        11: "Draenei",
        22: "Worgen",
        24: "Pandaren",
        25: "Pandaren",
        26: "Pandaren",
        13: "Nightborne",
        14: "Highmountain",
        17: "Zandalari Troll",
        18: "Kul Tiran Human",
        29: "Void Elf",
        30: "Lightforged Draenei",
        34: "Dark Iron",
        36: "Mag'Har Orc",
    ]
    
    let classDictionary : Dictionary = [
        1: "Warrior",
        2: "Paladin",
        3: "Hunter",
        4: "Rogue",
        5: "Priest",
        6: "Death Knight",
        7: "Shaman",
        8: "Mage",
        9: "Warlock",
        10: "Monk",
        11: "Druid",
        12: "Demon Hunter",
        ]

    let genderDictionary : Dictionary = [
        0: "Male",
        1: "Female",
        ]
    
    var characterName : String?
    var realm : String?
    var race: String?
    var characterClass: String?
    var gender: String?
    var level: String?
    var thumbnail: String?
    
    init(characterName : String?, realm : String?) {
        getUserProfile(characterName: characterName, realm: realm)
    }
    
    func getUserProfile(characterName : String?, realm : String?) {
        if let realm = realm {
            if let characterName = characterName {
                let userContextUrl: NSURL = NSURL(string: "https://us.api.blizzard.com/wow/character/\(realm)/\(characterName)?locale=en_US&access_token=\(accessToken)")!
                
                print("Creating API call with URL: \(userContextUrl)")
                
                let myRequest: NSURLRequest = NSURLRequest(url: userContextUrl as URL)
                let mySession = URLSession.shared
                let task = mySession.dataTask(with: myRequest as URLRequest) { data, response, error in
                    do {
                        let jsonresult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]

                        print("Getting character class: ")
                        let classKey = (jsonresult!["class"] as? NSNumber)?.intValue
                        let tempCharacterClass = (self.classDictionary[classKey!] as! String)
                        self.characterClass = tempCharacterClass
                        print("Character class is: \(String(describing: self.characterClass))")
                        
                        print("Getting race: ")
                        let raceKey = (jsonresult!["class"] as? NSNumber)?.intValue
                        let tempRace = (self.classDictionary[raceKey!] as! String)
                        self.race = tempRace
                        print("Race is: \(String(describing: self.race))")
                        
                        print("Getting gender: ")
                        let genderKey = (jsonresult!["gender"] as? NSNumber)?.intValue
                        let tempGender = (self.classDictionary[genderKey!] as! String)
                        self.gender = tempGender
                        print("Gender is: \(String(describing: self.gender))")
                        
                        print("Getting level: ")
                        let level = (jsonresult!["level"] as? NSNumber)?.intValue
                        print("Level is: \(String(describing: level))")
                        self.level = (String(describing: level))
                        
                        print("Getting thumnail: ")
                        let thumbnail = jsonresult!["thumbnail"] as! String
                        print("thumbnail is: \(thumbnail)")
            
                    } catch {
                        print(error)
                    }
                }
                task.resume()
            }
        }
    }
}
