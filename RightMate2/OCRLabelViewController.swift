//
//  OCRLabelViewController.swift
//  RightMate2
//
//  Created by Riddhi Maharana on 7/24/16.
//  Copyright © 2016 Lakshay Maharana. All rights reserved.
//

import Foundation
import UIKit

class OCRLabelViewController: UIViewController {

    @IBOutlet weak var OCRTextLabel: UILabel!
    var OCRString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OCRTextLabel.text = OCRString
    }

}
