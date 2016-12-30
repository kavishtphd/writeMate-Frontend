//
//  ViewController.swift
//  RightMate2
//
//  Created by Riddhi Maharana on 7/23/16.
//  Copyright © 2016 Lakshay Maharana. All rights reserved.
//

//
//  ViewController.swift
//  ZeroToApp
//

import UIKit




class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    }
    
        /*
    // pragma mark - UITableViewDataSource overrides
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatMessageCell", forIndexPath: indexPath) as! ChatMessageTableViewCell
        let chatMessage = messages[indexPath.row]
        cell.nameLabel.text = chatMessage.name
        cell.messageLabel.text = chatMessage.message
        cell.photoView.image = chatMessage.image
        return cell
    }
    
    // pragma mark - UITableViewDelegate overrides
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let chatMessage = messages[indexPath.row]
        if (chatMessage.image != nil) {
            return 345.0
        } else {
            return 58.0
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // Create a chat message from a FIRDataSnapshot
    func chatMessageFromSnapshot(snapshot: FIRDataSnapshot) -> ChatMessage? {
        let data = snapshot.value as! Dictionary<String, String>
        guard let name = data["name"] as String! else { return nil }
        guard let message = data["message"] as String! else { return nil }
        let chatMessage = ChatMessage(name: name, message: message, image: nil)
        return chatMessage
    }
 */

 
/*
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
*/

