//
//  RepeatViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class RepeatViewController: UIViewController {
    @IBOutlet weak var repeatLabel: UILabel!
    
    static var count = 0
    
    var testArr = ["Hello", "How", "Are", "You?"]
    
    @IBAction func onRepeat(_ sender: Any) {
        testArr.count.repeatThis {
            RepeatViewController.count += 1
            repeatLabel.text = "\(RepeatViewController.count)"
        }
    }
    
}
