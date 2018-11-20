//
//  ImageViewController.swift
//  Cassini
//
//  Created by wry on 2018/11/20.
//  Copyright © 2018年 jiacheng. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    //model
    var imageURL: URL? {
        didSet {
            imageView.image = nil
            //only fetch image when this view is on the screen
            if view.window != nil {
                fetchImage()
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if imageView.image == nil {
            fetchImage()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    private func fetchImage() {
        
        if let url = imageURL {
            
            let urlContents = try? Data(contentsOf: url)
            if let imageData = urlContents {
                imageView.image = UIImage(data: imageData)
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
