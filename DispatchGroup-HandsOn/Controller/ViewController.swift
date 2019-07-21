//
//  ViewController.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.testImageFetch()
    }
    
    private func testImageFetch() {
        Networking.shared.fetchImageFromServer(stringUrl: "https://images.pexels.com/photos/2668676/pexels-photo-2668676.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500", successCompletion: { (image) in
            self.imageView.image = image
        }) {
            print("Fail to load image")
        }
    }
}

