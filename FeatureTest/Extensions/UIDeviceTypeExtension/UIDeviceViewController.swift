//
//  UIDeviceViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class UIDeviceViewController: UIViewController {
    @IBOutlet weak var deviceTypeLabel: UILabel!

    @IBAction func onCheckDevice(_ sender: Any) {
        if UIDevice().iPad {
            switch UIDevice().deviceType {
            case .iPad_Pro9_7_Air:
                deviceTypeLabel.text = "iPad_Pro9_7_Air"
                break
            case .iPadPro10_5:
                deviceTypeLabel.text = "IPADPRO 10.5"
                break
            case .iPadPro12_9:
                deviceTypeLabel.text = "IPADPRO 12.9"
                break
            default:
                deviceTypeLabel.text = "Unknown iPad"
                break
            }
        } else if UIDevice().iPhone {
            switch UIDevice().deviceType {
            case .iPhone5_SE:
                deviceTypeLabel.text = "IPHONE 5_SE"
                break
            case .iPhone6_7_8:
                deviceTypeLabel.text = "IPHONE 6_7_8"
                break
            case .iPhonePlus:
                deviceTypeLabel.text = "IPHONE PLUS"
                break
            case .iPhoneX:
                deviceTypeLabel.text = "IPHONE X"
                break
            default:
                deviceTypeLabel.text = "Unknown iPhone"
                break
            }
        } else {
            deviceTypeLabel.text = "Wait how...."
        }
    }
}
