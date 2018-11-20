//
//  CassiniViewController.swift
//  Cassini
//
//  Created by wry on 2018/11/20.
//  Copyright © 2018年 jiacheng. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {
    
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier] {
                if let imageVC = segue.destination.contents as? ImageViewController {
                    //"prepare" function happens before outlet is set
                    //so the url is nil
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
 

}

//contents is the NavigationController of itself
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}
