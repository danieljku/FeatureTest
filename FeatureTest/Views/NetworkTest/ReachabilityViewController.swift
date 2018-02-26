//
//  ReachabilityViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class ReachabilityViewController: UIViewController {
    @IBOutlet weak var networkStatusLabel: UILabel!
    
    @IBAction func onNetworkCheck(_ sender: Any) {
        if Reachability.isConnectedToNetwork() {
            networkStatusLabel.text = "WE GOT INTERNET"
        } else {
            networkStatusLabel.text = "NO INTERNET :("
        }
    }
}
