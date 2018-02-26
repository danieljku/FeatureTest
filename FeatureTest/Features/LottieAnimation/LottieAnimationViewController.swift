//
//  LottieAnimationViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/20/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class LottieAnimationViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    var lottieAnimation = LOTAnimationView()
    let activity = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
    
    override func viewDidLoad() {
        lottieAnimation = LOTAnimationView(name: "equalizer_corrected")
        lottieAnimation.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        lottieAnimation.loopAnimation = true
        lottieAnimation.isHidden = true
        activity.transform = CGAffineTransform(scaleX: 2, y: 2)
        button.addSubview(lottieAnimation)
        button.addSubview(activity)
    }
    
    @IBAction func onClick(_ sender: Any) {
        activity.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.displayLottie()
        }
        
    }
    
    func displayLottie() {
        activity.stopAnimating()
        lottieAnimation.isHidden = false
        lottieAnimation.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.lottieAnimation.pause()
        }
    }
}
