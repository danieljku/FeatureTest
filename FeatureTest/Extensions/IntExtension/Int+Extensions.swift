//
//  Int+Extensions.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import Foundation

extension Int {
    func repeatThis(block: () -> ()) {
        for _ in 0 ..< self {
            block()
        }
    }
}
