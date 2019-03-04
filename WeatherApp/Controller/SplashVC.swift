//
//  SplashViewController.swift
//  Upcloud
//
//  Created by Joseph on 3/1/19.
//  Copyright © 2019 Joseph. All rights reserved.
//

import UIKit
import Gifu

class SplashViewController: UIViewController {
    @IBOutlet weak var gif: GIFImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gif?.animate(withGIFNamed: "splach", loopCount: 3)
        
        delayWithSeconds(3) {
            
            DispatchQueue.main.async {
                
                self.performSegue(withIdentifier: "home", sender: nil)
            }
        }

    }
    

    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
