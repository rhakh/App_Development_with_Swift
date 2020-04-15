//
//  ViewController.swift
//  Hello
//
//  Created by Роман Гах on 28.12.2019.
//  Copyright © 2019 Роман Гах. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func respondToTapGesture(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        let x = floor(location.x)
        let y = floor(location.y)
        print("x = \(x), y = \(y)")
    }
    
}

