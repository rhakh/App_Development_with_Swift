//
//  ViewController.swift
//  Light
//
//  Created by Роман Гах on 25.12.2019.
//  Copyright © 2019 Роман Гах. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var lightOn = true
 
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn.toggle()
        updateUI()
    }
    
    func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }


}

