//
//  GradientView.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class InitialGradientLayer: CAGradientLayer, CALayerDelegate {
    var frameObserver: NSKeyValueObservation?
    
    init(window: UIWindow) {
        super.init()
        
        startPoint = CGPoint(x: 0.0, y: 0.0)
        endPoint = CGPoint(x: 1.0, y: 1.0)
        locations = [0.0, 0.49, 0.55, 1.0]
        opacity = 0.0
        colors = [UIColor(hex: "E951F0").cgColor , UIColor(hex: "888CE1").cgColor,
                  UIColor(hex: "888BE1").cgColor, UIColor(hex: "02DCCC").cgColor]
        zPosition = -1
        needsDisplayOnBoundsChange = true
        if UIDevice().iPad {
            let largerSize = max(window.bounds.width, window.bounds.height)
            frame = CGRect(x: 0.0, y: 0.0, width: largerSize, height: largerSize)
        } else {
            frame = window.bounds
        }
        
        var windowTopLayer = window.layer
        while windowTopLayer.superlayer != nil {
            windowTopLayer.backgroundColor = UIColor.clear.cgColor
            windowTopLayer = windowTopLayer.superlayer!
        }
        windowTopLayer.addSublayer(self)
        
        frameObserver = windowTopLayer.observe(\CALayer.frame) { [weak self] layer, values in
            guard let weakSelf = self else { return }
            weakSelf.frame = windowTopLayer.bounds
            windowTopLayer.setNeedsDisplay()
            windowTopLayer.displayIfNeeded()
        }
    }
    
    deinit {
        frameObserver?.invalidate()
    }
    
    override var backgroundColor: CGColor? {
        get {
            return superlayer?.backgroundColor
        }
        set {
            superlayer?.backgroundColor = newValue
        }
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

fileprivate var gradientLayer: InitialGradientLayer? = nil

class InitialGradientView: UIView {
    
    // MARK: Initialization
    var targetBackgroundColor: UIColor?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }

    private func commonInit() {
        targetBackgroundColor = backgroundColor
        backgroundColor = UIColor.clear
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        
        guard let window = newWindow else { return }
        
        if gradientLayer == nil {
            
            gradientLayer = InitialGradientLayer(window: window)
            if gradientLayer == nil { return }
            
            gradientLayer!.backgroundColor = UIColor.white.cgColor
            
            animateInitalAppearanceIfAvailableWithDelay(0.2)
        }
    }
    
    func animateInitalAppearanceIfAvailableWithDelay(_ delay: Double) {
        
        guard let gradientLayer = gradientLayer else { return }
        
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fillMode = kCAFillModeForwards
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.duration = 0.4
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAAnimationLinear)
        animation.toValue = 1.0
        animation.delegate = self
        
        gradientLayer.add(animation, forKey: "fade")
    }
    
    func animateGradientPulse(stop: Bool = false) {
        
        guard let gradientLayer = gradientLayer else { return }
        
        let animationName = "pulse"
        
        if stop {
            if gradientLayer.animation(forKey: animationName) != nil {
                CATransaction.begin()
                CATransaction.disableActions()
                if let opacity = gradientLayer.presentation()?.opacity {
                    gradientLayer.opacity = opacity
                }
                CATransaction.commit()
                gradientLayer.removeAnimation(forKey: animationName)
            }
        } else {
            
            let animation = CABasicAnimation.init(keyPath: "opacity")
            animation.fillMode = kCAFillModeForwards
            animation.fromValue = 1.0
            animation.toValue = 0.2
            animation.autoreverses = true
            animation.repeatCount = Float.infinity
            animation.duration = 3.0
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.isRemovedOnCompletion = false
            gradientLayer.add(animation, forKey:animationName)
        }
    }
}

extension InitialGradientView: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        guard let gradientLayer = gradientLayer else { return }
        
        gradientLayer.removeAllAnimations()
        gradientLayer.opacity = 1.0
        gradientLayer.backgroundColor = targetBackgroundColor?.cgColor
        
        self.animateGradientPulse()
    }
}
