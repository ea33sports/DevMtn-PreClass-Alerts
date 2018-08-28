//
//  ViewController.swift
//  Alert
//
//  Created by Eric Andersen on 8/27/18.
//  Copyright © 2018 Eric Andersen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "Alert!", message: "This is an alert.", preferredStyle: .alert)
        
        let destructiveAction = UIAlertAction(title: "Warning!", style: .destructive) { alert -> Void in
            print("Something blew up.")
        }
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
            print("Okey dokey")
        }
        
        let defaultAction = UIAlertAction(title: "Cancel", style: .default) { alert -> Void in
            print("Boring")
        }
        
        alertController.addAction(destructiveAction)
        alertController.addAction(okAction)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

