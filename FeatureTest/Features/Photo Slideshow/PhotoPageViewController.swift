//
//  PhotoPageViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 9/18/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit

class PhotoPageViewController: UIPageViewController {
    var photos = [#imageLiteral(resourceName: "maxresdefault"), #imageLiteral(resourceName: "redhotchilipeppers"), #imageLiteral(resourceName: "maroon5")]
    var currentIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self

        if let viewController = previewPhotoViewController(currentIndex ?? 0) {
            let viewControllers = [viewController]
            setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        }

    }
    
    func previewPhotoViewController(_ index: Int) -> PreviewPhotoViewController? {
        guard let storyboard = storyboard,
            let page = storyboard.instantiateViewController(withIdentifier: "PreviewPhotoViewController")
                as? PreviewPhotoViewController else {
                    return nil
        }
        
        page.photoIndex = index
        page.photo = photos[index]
        
        return page
    }
}

extension PhotoPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewController = viewController as? PreviewPhotoViewController,
            let index = viewController.photoIndex,
            (index + 1) < photos.count {
            return previewPhotoViewController(index + 1)
        }
        
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
         if let viewController = viewController as? PreviewPhotoViewController,
            let index = viewController.photoIndex,
            index > 0 {
            return previewPhotoViewController(index - 1)
        }
        
        return nil
    }
}
