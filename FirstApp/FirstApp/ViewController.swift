//
//  ViewController.swift
//  FirstApp
//
//  Created by Роман Гах on 22.12.2019.
//  Copyright © 2019 Роман Гах. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var PressMeBtn: UIButton!

    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myLabel = UILabel()

        PressMeBtn.setTitleColor(.red, for: .normal)
        // scrollView.contentSize = CGSize(width: 100, height: 100)
        
        myLabel.text = "This is my label"
        
        scrollView.addSubview(myLabel)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        print("The button is pressed")
    }
    
}

