//
//  Photo.swift
//  RightMate2
//
//  Created by Riddhi Maharana on 7/23/16.
//  Copyright © 2016 Lakshay Maharana. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit
import Firebase
import FBSDKLoginKit
import Photos


class Photo : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Outlets
    var downloadURL = ""
    //change to ? if necessary
    
    @IBOutlet weak var OCRTextLabel: UILabel?
    
    @IBOutlet weak var OCRTEXLabel: UILabel?
    @IBOutlet weak var Label: UILabel!
    // Useful app properties
    let imagePicker = UIImagePickerController()
    var username: String!
    
    
    var OCRText: String!
    
    // Firebase services
    var database: FIRDatabase!
    var auth: FIRAuth!
    var storage: FIRStorage!
    
    //audio
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view loaded")
        
//        SeeMessage()
       //self.OCRTextLabel?.hidden = true
        
        // Initialize navigation bar
        self.title = "RightMate"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log in",
                                                            style: UIBarButtonItemStyle.Plain,
                                                            target: self,
                                                            action: #selector(toggleAuthState))
        
        //print("lakshsy has a headache")
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera,
                                                           target: self,
                                                           action: #selector(selectImage))
        // Initialize send button
        
        // Initialize UIImagePicker
        imagePicker.delegate = self
        
        // Initialize other properties
        
        // Initialize UITableView
        
        
        // Initialize Database, Auth, Storage
        database = FIRDatabase.database()
        auth = FIRAuth.auth()
        storage = FIRStorage.storage()
        
        // Listen for when child nodes get added to the collection
        
     
        
        
    }
    
    // Send a chat message
    
    // Show a popup when the user asks to sign in
    func toggleAuthState() {
        if (auth.currentUser != nil) {
            // Allow the user to sign out
            do {
                try auth.signOut()
            } catch {}
        } else {
            // Log in to Facebook
            let login = FBSDKLoginManager()
            login.logInWithReadPermissions(["public_profile"], fromViewController: self, handler: { (result, error) in
                if (error != nil || result.isCancelled) {
                    print(error)
                } else {
                    // Log in to Firebase via Facebook
                    let credential = FIRFacebookAuthProvider.credentialWithAccessToken(result.token.tokenString)
                    FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
                        if (error != nil) {
                            print(error)
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func SeeMessage(){
        var to_print : String?
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(10 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())  {
            
            let baseURL_2 = "http://192.168.90.77/get_contents.php"
            let components_2 = NSURLComponents(string: baseURL_2)
            //var g_dataString = ""
            let completeURL_2 = components_2?.URL
            let task_2 = NSURLSession.sharedSession().dataTaskWithURL(completeURL_2!) {(data, response, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                //g_dataString = NSString(data:data!, encoding:NSUTF8StringEncoding) as! String
                //print(g_dataString)
                to_print = String(data: (data!), encoding: NSUTF8StringEncoding)
                
                dispatch_async(dispatch_get_main_queue(), {() in
                print("Setting OCR Txt Label")
                    self.OCRTEXLabel?.text = String(to_print)
                    //self.txt2.text = String(to_print)
                    self.performSegueWithIdentifier("presentLabel", sender: to_print)
                })
            }
            
            task_2.resume()
            
        }

        
        print ("set hidden to false");
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "presentLabel") {
            let vc: OCRLabelViewController = segue.destinationViewController as! OCRLabelViewController
            vc.OCRString = sender as! String
        }
    }
    
    
    //actually take photo
    // Handle photo uploads button
    @IBAction func selectImage() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
           }
    
    // pragma mark - UIImagePickerDelegate overrides
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Get local file URLs
        guard let image: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            print("not an image!")
            return
        }
        let imageData = UIImageJPEGRepresentation(image, 0.1)!
        
        // Get a reference to the location where we'll store our photos
        let photosRef = storage.reference().child("chat_photos")
        
        // Get a reference to store the file at chat_photos/<FILENAME>
        let photoRef = photosRef.child("\(NSUUID().UUIDString).png")
        
        // Upload file to Firebase Storage
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/png"
        
        photoRef.putData(imageData, metadata: metadata) { (metadata, error) in
            // When the image has successfully uploaded, we get it's download URL
            let text = metadata?.downloadURL()?.absoluteString
            self.downloadURL = text!
            print(text)
            // Set the download URL to the message box, so that the user can send it to the database
            self.dismissViewControllerAnimated(true, completion: nil)
            let baseURL = "http://192.168.90.77/download_file.php"
            let components = NSURLComponents(string: baseURL)
            let queryItem = NSURLQueryItem(name: "url", value: self.downloadURL)
            components?.queryItems = [queryItem]
            //var g_dataString = ""
            
            let completeURL = components!.URL
            let task = NSURLSession.sharedSession().dataTaskWithURL(completeURL!) {(data, response, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding))
                //g_dataString = NSString(data:data!, encoding:NSUTF8StringEncoding) as! String
                //print(g_dataString)
                
            }
            
            
            
            task.resume()
            
            
           
        }
        
        
       


    /*
   @IBAction func uploadIMG() {
        let baseURL = "http://192.168.90.77/download_file.php"
        let components = NSURLComponents(string: baseURL)
        let queryItem = NSURLQueryItem(name: "url", value: self.downloadURL)
        components?.queryItems = [queryItem]
        let completeURL = components!.URL
        let task = NSURLSession.sharedSession().dataTaskWithURL(completeURL!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
        }
        
        task.resume()
    }

        
    */
    
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
     as==QWSSS3S
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
}

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

}
