//
//  PreviewPhotoViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 9/18/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class PreviewPhotoViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photo: UIImage?
    var photoIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 4.0

        photoImageView.image = photo
        photoImageView.contentMode = .scaleAspectFit
    }
    
    @IBAction func onExit(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PreviewPhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
