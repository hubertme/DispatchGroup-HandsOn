//
//  ViewController.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableViewDataSource = [(String, UIImage?)]()
    
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
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
    }
    
    private func setupData() {
        let feedData = Networking.shared.fetchDummyData()
        feedData.forEach { [unowned self] feed in
            Networking.shared.fetchImageFromServer(dispatchGroup: self.dispatchGroup, stringUrl: feed.imageURL, successCompletion: { (image) in
                self.tableViewDataSource.append((feed.feedName, image))
            })
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = self.feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        let currentData = self.tableViewDataSource[indexPath.row]
        feedCell.displayFeedCell(feedName: currentData.0, feedImage: currentData.1)
        
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

