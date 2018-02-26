//
//  ClickableTextViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/1/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class ClickableTextViewController: UIViewController {
    @IBOutlet weak var termsTextView: UITextView!

    override func viewDidLayoutSubviews() {
        let attributedString = NSMutableAttributedString(string:"By proceeding, you agree with Bandsintown’s \nTerms of Service and Privacy Policy")
        attributedString.setAsLink(textToFind: "Terms of Service", linkURL: "http://corp.bandsintown.com/terms", font: termsTextView.font!)
        attributedString.setAsLink(textToFind: "Privacy Policy", linkURL: "http://corp.bandsintown.com/privacy", font: termsTextView.font!)
        
        termsTextView.linkTextAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
            NSAttributedStringKey.underlineColor.rawValue: UIColor.white,
            NSAttributedStringKey.underlineStyle.rawValue: NSUnderlineStyle.styleSingle.rawValue]
        termsTextView.attributedText = attributedString
        termsTextView.textColor = UIColor.black
        termsTextView.textAlignment = .center
    }
}

extension NSMutableAttributedString {
    public func setAsLink(textToFind: String, linkURL: String, font: UIFont) {
        let paragraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.alignment = .center
        
        let foundRange = self.mutableString.range(of: textToFind)
        
        if foundRange.location != NSNotFound {
            self.addAttribute(NSAttributedStringKey.link, value: linkURL, range: foundRange)
        }
    }
}
