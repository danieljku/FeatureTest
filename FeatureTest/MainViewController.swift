//
//  MainViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/23/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    var b: (() -> ())!
    var c: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MEMORY LEAK TEST
    func printHelloWorld() {
        print("Hello World")
    }

    @IBAction func onMemoryLeak(_ sender: Any) {
        while(true) {
            let mainVC = MainViewController()
            mainVC.b = {
                mainVC.printHelloWorld()
            }
        }
    }
    
    @IBAction func onNoMemoryLeak(_ sender: Any) {
        while(true) {
             let mainVC = MainViewController()
            
            mainVC.c = { [weak mainVC] in
                mainVC?.printHelloWorld()
            }
        }
        
    }
}
