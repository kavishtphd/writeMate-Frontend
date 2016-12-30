//
//  Record.swift
//  RightMate2
//
//  Created by Riddhi Maharana on 7/24/16.
//  Copyright © 2016 Lakshay Maharana. All rights reserved.
//
/*

import Foundation
import AVFoundation
import UIKit
class Record: UIViewController, AVAudioRecorderDelegate {
    
    var recordButton: UIButton?
    var recordingSession: AVAudioSession?
    var whistleRecorder: AVAudioRecorder?
    var stackView: UIStackView?

    override func viewDidLoad() {
        super.viewDidLoad()
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession!.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession!.setActive(true)
            recordingSession!.requestRecordPermission() { [unowned self] (allowed: Bool) -> Void in
             
                
                
                dispatch_async(dispatch_get_main_queue()) {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadRecordingUI() {
        recordButton = UIButton()
        recordButton?.translatesAutoresizingMaskIntoConstraints = false
        recordButton?.setTitle("Tap to Record", forState: .Normal)
        recordButton?.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        recordButton?.addTarget(self, action: #selector(recordTapped), forControlEvents: .TouchUpInside)
        stackView?.addArrangedSubview(recordButton!)
    }
    
    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline)
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        
        stackView?.addArrangedSubview(failLabel)
    }
    func recordTapped() {
        if whistleRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    class func getWhistleURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("whistle.mp3")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
   @IBAction func startRecording() {
        // 1
        
        // 2
        recordButton?.setTitle("Tap to Stop", forState: .Normal)
        
        // 3
        let audioURL = Record.getWhistleURL()
        print(audioURL.absoluteString)
        
        // 4
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            // 5
            whistleRecorder = try AVAudioRecorder(URL: audioURL, settings: settings)
            whistleRecorder?.delegate = self
            whistleRecorder?.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
   @IBAction func finishRecording(success success: Bool) {
       
        
        whistleRecorder?.stop()
        whistleRecorder = nil
        
        if success {
            recordButton?.setTitle("Tap to Re-record", forState: .Normal)
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(recordTapped))
        } else {
            recordButton?.setTitle("Tap to Record", forState: .Normal)
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }

    @IBAction func finish(){
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
 
 */