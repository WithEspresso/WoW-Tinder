//
//  ContactsTableViewController.swift
//  Login
//
//  Created by Danielle Nunez on 12/3/18.
//  Copyright © 2018 James Clark. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {

    var contacts:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "contactCell")
        retreiveContacts()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Returns the current size of the contacts array. Used when creating the table view.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    // Creates cells for the tableView.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let contact = contacts[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell") as! ContactCell
            let contactName:String? = String(contact.getName())
            let characterClass:String? = String(contact.getCharacterClass())
            cell.textLabel?.text = contactName
            return cell
    }
    
    //Pulls matches from the database to populate cells.
    func retreiveContacts() {
        // Temporary hard coded variables.
        var temp_contact = Contact.init(contactName: "Khadgar", characterClass:  "<insertPathtoIcon>")
        self.contacts.append(temp_contact)
        temp_contact = Contact.init(contactName: "Deathwing", characterClass: "<insertPathtoIcon>")
        self.contacts.append(temp_contact)
        temp_contact = Contact.init(contactName: "Sylvanas", characterClass: "<insertPathtoIcon>")
        self.contacts.append(temp_contact)
        
        for contact in contacts {
            NSLog(contact.contactName! + contact.characterClass!)
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
