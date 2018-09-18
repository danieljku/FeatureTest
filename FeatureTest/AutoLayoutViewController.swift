//
//  AutoLayoutViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 9/12/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class AutoLayoutViewController: UIViewController {
    
    let eqImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "maxresdefault"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let helloLabel: UILabel = {
        let label = UILabel()
        label.text = "HELLO WORLD! :)"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(eqImageView)
        self.view.addSubview(helloLabel)
        
        setupLayouts()
    }
    
    private func setupLayouts() {
        eqImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        eqImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        eqImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        eqImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        helloLabel.topAnchor.constraint(equalTo: eqImageView.bottomAnchor, constant: 80).isActive = true
        helloLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        helloLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60).isActive = true
    }
}
