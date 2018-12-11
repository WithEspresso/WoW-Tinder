//
//  ViewController.swift
//  Messaging Demo
//
//  Created by Danielle Nunez on 11/21/18.
//  Copyright © 2018 Danielle Nunez. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase

class MessagingChildViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]();
    var contactName : String?
    var sender : String?
    var conversationId: String?
    
    // Creates outgoing bubble with lazy evaluation
    lazy var outgoingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleRed())
    }()
    
    // Creates incoming bubble with lazy evalutation.
    lazy var incomingBubble: JSQMessagesBubbleImage = {
        return JSQMessagesBubbleImageFactory()!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }()
    
    // Sets up the database query, user ID stuff.
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        inputToolbar.contentView.leftBarButtonItem = nil
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // Gets the currently logged in user for this session's information.
        let user = Auth.auth().currentUser
        if let user = user {
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = "Skarmorite"
            NSLog(user.email!)
            
            sender = "Skarmorite" //user.displayName;
            senderId = "1234" // user.uid
            senderDisplayName = "Skarmorite"

            
            /* Since Firebase only allows one SELECT query at the same time,
             conversations are organized by the conversationId, a combination
             of the two users messaging each other with the lexographically
             first user being the first Id. */
            if (contactName! > sender!) {
                conversationId = sender! + contactName!
            }
            else {
                conversationId = contactName! + senderDisplayName!
            }
        }
        
        
        /* Debug */
        //NSLog("User ID: " + senderId! + "/n Username: " + senderDisplayName! + "/n Recipient: " + contactName! + "/n ContactId: " + contactName!)
        
        // Query the database and create JSQMessage objects with the results.
        let query = Constants.refs.databaseChats.queryOrdered(byChild: "conversationId").queryEqual(toValue : conversationId)
        _ = query.observe(.childAdded, with: { [weak self] snapshot in
            if  let data        = snapshot.value as? [String: String],
                let id          = data["sender_id"],
                let name        = data["name"],
                let text        = data["text"],
                !text.isEmpty {
                if let message = JSQMessage(senderId: id, displayName: name, text: text) {
                    self?.messages.append(message)
                    self?.finishReceivingMessage()
                }
            }
        })
    }
    
    // Returns the index path of the messages.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData!
    {
        return messages[indexPath.item]
    }
    
    // Returns the number of messages.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource!
    {
        return messages[indexPath.item].senderId == senderId ? outgoingBubble: incomingBubble
    }
    
    // Hides avatars for chat bubbles
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource!
    {
        return nil
    }
    
    // Sets the name label for chat bubbles
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString!
    {
        return messages[indexPath.item].senderId == senderId ? nil : NSAttributedString(string: messages[indexPath.item].senderDisplayName)
    }
    
    // Set height
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) ->CGFloat
    {
        return messages[indexPath.item].senderId == senderId ? 0 : 15
    }
    
    // Sends a message to the database.
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!)
    {
        let ref = Constants.refs.databaseChats.childByAutoId()
        let message = ["conversationId": conversationId, "sender_id": senderId, "name": senderDisplayName, "text": text]
        ref.setValue(message)
        finishSendingMessage()
    }
}



