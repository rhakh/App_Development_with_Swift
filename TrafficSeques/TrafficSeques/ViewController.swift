//
//  ViewController.swift
//  TrafficSeques
//
//  Created by Роман Гах on 06.01.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func unwindToRed(unwind: UIStoryboardSegue) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segue.destination.navigationItem.title = textField.text
    }
    
}

