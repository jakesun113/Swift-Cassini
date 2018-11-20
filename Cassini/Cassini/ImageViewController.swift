//
//  ImageViewController.swift
//  Cassini
//
//  Created by wry on 2018/11/20.
//  Copyright © 2018年 jiacheng. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {
    
    //model
    var imageURL: URL? {
        didSet {
            image = nil
            //only fetch image when this view is on the screen
            if view.window != nil {
                fetchImage()
            }
            
        }
    }
    
    private var image: UIImage? {
        get {
            return imageView.image
        }
        
        set {
            imageView.image = newValue
            //once adding the iamge, set image size and scrollView contentSize
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            //add zooming function, set max and min scale
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            //set delegate to self
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    //return what to show when zooming
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageView = UIImageView()
    
    
    private func fetchImage() {
        
        if let url = imageURL {
            
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                image = UIImage(data: imageData)
 
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageURL == nil {
            imageURL = DemoURLs.stanford
        }
    }
}
