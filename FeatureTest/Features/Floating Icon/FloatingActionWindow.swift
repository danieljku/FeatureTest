//
//  FloatingActionWindow.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/23/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import Foundation
import UIKit

class FloatingActionWindow: UIWindow {
    let mainWindow = UIScreen.main
    var isKeyboardPresent = false
    var currentView: UIView?
    var yOffset: CGFloat!
    
    let button = UIButton(frame: CGRect(origin: CGPoint.init(x: 0, y: 0), size: CGSize(width: 75, height: 75)))
    
    init(yOffset: CGFloat, view: UIView) {
        super.init(frame: CGRect(origin: CGPoint.init(x: mainWindow.bounds.maxX - 95, y: mainWindow.bounds.maxY - (yOffset + 95)), size: CGSize(width: 75, height: 75)))
        
        self.yOffset = yOffset
        self.currentView = view
        self.backgroundColor = UIColor.clear
        self.isUserInteractionEnabled = true
        self.windowLevel = UIWindowLevelAlert + 1
        self.isHidden = false
        self.screen = UIScreen.main
        
        initFABButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let radiusSquared = (button.bounds.size.width / 2) * (button.bounds.size.width / 2)
        let xSquared = (point.x - button.center.x) * (point.x - button.center.x)
        let ySquared = (point.y - button.center.y) * (point.y - button.center.y)
        
        if (xSquared + ySquared) > radiusSquared {
            return nil
        }
        return button
    }
    
    func initFABButton() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didDeviceRotate), name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
        
        button.addTarget(self, action: #selector(didTapFAB), for: UIControlEvents.touchUpInside)
        
        button.setImage(#imageLiteral(resourceName: "maxresdefault"), for: .normal)
        button.backgroundColor = UIColor.white
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.27).cgColor
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 1.0
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.cornerRadius = self.frame.height / 2
        button.layer.masksToBounds = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(didPan(panner:)))
        self.addGestureRecognizer(pan)
        
        self.addSubview(button)
    }
    
    @objc func didTapFAB() {
        print("TAPPED")
    }
    
    @objc func didPan(panner: UIPanGestureRecognizer) {
        let offset = panner.translation(in: currentView)
        panner.setTranslation(CGPoint.zero, in: currentView)
        var center = self.center
        center.x += offset.x
        center.y += offset.y
        self.center = center

        if panner.state == .ended || panner.state == .cancelled {
            UIView.animate(withDuration: 0.3) {
                self.snapButtonToSocket()
            }
        }
    }
    
    private func snapButtonToSocket() {
        var bestSocket = CGPoint.zero
        var distanceToBestSocket = CGFloat.infinity
        let center = self.center
        for socket in sockets {
            let distance = hypot(center.x - socket.x, center.y - socket.y)
            if distance < distanceToBestSocket {
                distanceToBestSocket = distance
                bestSocket = socket
            }
        }
        self.center = bestSocket
    }

    private var sockets: [CGPoint] {
        let buttonSize = self.button.bounds.size
        guard let rect = currentView?.bounds.insetBy(dx: 4 + buttonSize.width / 2, dy: 4 + buttonSize.height / 2) else {fatalError()}
        let sockets: [CGPoint] = [
            CGPoint(x: rect.minX + 20, y: rect.minY + 20),
            CGPoint(x: rect.minX + 20, y: rect.maxY - (20 + yOffset)),
            CGPoint(x: rect.maxX - 20, y: rect.minY + 20),
            CGPoint(x: rect.maxX - 20, y: rect.maxY - (20 + yOffset)),
            CGPoint(x: rect.maxX - 20, y: rect.midY),
            CGPoint(x: rect.minX + 20, y: rect.midY),
            CGPoint(x: rect.midX, y: rect.maxY - (20 + yOffset)),
            CGPoint(x: rect.midX, y: rect.minY + 20)
        ]

        return sockets
    }
    
    @objc func didDeviceRotate() {
        self.frame.origin = CGPoint(x: mainWindow.bounds.maxX - 95, y: mainWindow.bounds.maxY - (95 + yOffset))
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        isKeyboardPresent = true

        if let keyboardFrame: NSValue = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            if (mainWindow.bounds.height - self.frame.origin.y) < keyboardHeight {
                UIView.animate(withDuration: 0.2) {
                    self.frame.origin = CGPoint(x: self.frame.origin.x, y: self.mainWindow.bounds.maxY - (95 + keyboardHeight))
                }
            }
        }
    }
    
    @objc func keyboardWillDisappear(note: NSNotification) {
        isKeyboardPresent = false
        if let keyboardFrame: NSValue = note.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
                if (mainWindow.bounds.height - self.frame.origin.y) == (keyboardHeight + 95) {
                    UIView.animate(withDuration: 0.2) {
                        self.frame.origin = CGPoint(x: self.mainWindow.bounds.maxX - 95, y: self.mainWindow.bounds.maxY - (95 + self.yOffset))
                    }
                }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
