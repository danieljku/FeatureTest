//
//  ScreenSize.swift
//  Test
//
//  Created by Daniel Ku on 1/24/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import Foundation
import UIKit


extension UIDevice {
    var iPhone: Bool {
        return UIDevice().userInterfaceIdiom == .phone
    }
    
    var iPad: Bool {
        return UIDevice().userInterfaceIdiom == .pad
    }
    
    enum DeviceType: String {
        case iPad_Pro9_7_Air
        case iPadPro10_5
        case iPadPro12_9
        case iPhone5_SE
        case iPhone6_7_8
        case iPhonePlus
        case iPhoneX
        case Unknown
    }
    
    var deviceType: DeviceType {
        switch UIScreen.main.nativeBounds.height {
        case 2048:
            return .iPad_Pro9_7_Air
        case 2224:
            return .iPadPro10_5
        case 2732:
            return .iPadPro12_9
        case 1136:
            return .iPhone5_SE
        case 1334:
            return .iPhone6_7_8
        case 1920:
            return .iPhonePlus
        case 2208:
            return .iPhonePlus
        case 2436:
            return .iPhoneX
        default:
            return .Unknown
        }
    }
    
}
