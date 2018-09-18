//
//  PagingViewController.swift
//  FeatureTest
//
//  Created by Daniel Ku on 2/23/18.
//  Copyright © 2018 Daniel Ku. All rights reserved.
//

import UIKit
import UserNotifications

class PagingViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurePageControl()
        scrollView.delegate = self
        
        let view1 = UIView()
        view1.backgroundColor = UIColor.black
        let view2 = UIView()
        view2.backgroundColor = UIColor.blue
        let view3 = UIView()
        view3.backgroundColor = UIColor.green
        
        let views = [view1, view2, view3]
        let viewWidth = self.view.bounds.width / 2
        let xOffset = (self.view.bounds.width - viewWidth) / 2
        var count: CGFloat = 0.0
        
        for view in views {
            view.frame = CGRect(x: (self.view.bounds.width * count) + xOffset, y: 0, width: viewWidth, height: scrollView.bounds.height)
            scrollView.addSubview(view)
            count += 1.0
        }
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width * count, height: scrollView.bounds.height)
    }
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = 3
        self.pageControl.currentPage = 0
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.gray
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
