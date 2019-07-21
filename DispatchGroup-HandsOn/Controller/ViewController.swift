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
    
    @IBOutlet weak var feedTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedData = Networking.shared.fetchDummyData()
        self.setupElements()
    }
    
    private func setupElements() {
        self.feedTableView.register(FeedCell.nib, forCellReuseIdentifier: FeedCell.cellDescription)
        
        self.feedTableView.delegate = self
        self.feedTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = self.feedTableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell
        return feedCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

