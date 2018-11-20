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
            //scrollView could be nil, so use question mark
            scrollView?.contentSize = imageView.frame.size
            //stop the spinner when the image is set
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
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
            //turn on the spinner
            spinner.startAnimating()
            //use multithreading to put fetching images to the background queue
            //also need to consider, when user cancel fetching images in the middle of
            //this function, should cancel the action (remove from the heap) -> use "weak self"
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let urlContents = try? Data(contentsOf: url)
                //Anything related to the UI setting can only be set to the "main" queue
                DispatchQueue.main.async {
                    //also need to check whether the returned url equals to the url I want
                    if let imageData = urlContents, url == self?.imageURL {
                        self?.image = UIImage(data: imageData)
                    }
                }
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if imageURL == nil {
        //            imageURL = DemoURLs.stanford
        //        }
    }
}
