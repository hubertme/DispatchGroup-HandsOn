//
//  ViewController.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var feedData = [Feed]()
    var data = [(String, UIImage?)]()
    
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var feedTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupElements()
        
        self.dispatchGroup.notify(queue: .main) {
            self.feedTableView.reloadData()
        }
    }
    
    private func setupElements() {
        self.feedTableView.register(FeedCell.nib, forCellReuseIdentifier: FeedCell.cellDescription)
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
    }
    
    private func setupData() {
        self.feedData = Networking.shared.fetchDummyData()
        self.feedData.forEach { [unowned self] feed in
            self.fetchImage(feedName: feed.feedName, stringUrl: feed.imageURL)
        }
    }
    
    private func fetchImage(feedName: String, stringUrl: String) {
        self.dispatchGroup.enter()
        
        guard let url = URL(string: stringUrl) else {
            fatalError("Invalid URL")
        }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { [unowned self] data, response, error in
            if let error = error {
                print("Error in networking", error.localizedDescription)
            } else if let data = data {
                let image = UIImage(data: data)
                self.data.append((feedName, image))
                
                self.dispatchGroup.leave()
            }
        }.resume()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = self.feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        feedCell.feedNameLabel.text = self.data[indexPath.row].0
        feedCell.feedImageView.image = self.data[indexPath.row].1
        
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

