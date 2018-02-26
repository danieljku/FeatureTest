//
//  FloatingActionButtonViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/23/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class FloatingActionButtonViewController: UIViewController {
    var floatingActionButtonWindow: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
    }

    @IBAction func onShowFloatingIcon(_ sender: Any) {
        floatingActionButtonWindow = FloatingActionWindow(yOffset: 10, view: self.view)
    }
}
