//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Роман Гах on 11.03.2020.
//  Copyright © 2020 Роман Гах. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let photoInfoController = PhotoInfoController()
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.descriptionLabel.text = ""
        self.copyrightLabel.text = ""
        self.copyrightLabel.isHidden = false
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            guard let photoInfo = photoInfo else { return }
            
            self.updateUI(with: photoInfo)
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else { return }

        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            
            guard let data = data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.title = photoInfo.title
                self.imageView.image = image
                self.descriptionLabel.text = photoInfo.description
                self.copyrightLabel.isHidden = false
                
                if let copyright = photoInfo.copyright  {
                    self.copyrightLabel.text = "Copyright \(copyright)"
                } else {
                    self.copyrightLabel.isHidden = true
                }
            }
        }
        
        task.resume()
    }


}

