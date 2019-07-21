//
//  FeedCell.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
    var feed: Feed?
    static var nib: UINib {
        return UINib(nibName: FeedCell.cellDescription, bundle: nil)
    }
    
    static var cellDescription: String {
        return String(describing: self)
    }
    
    @IBOutlet weak var feedImageView: UIImageView!
    @IBOutlet weak var feedNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func fetchFeedData() {
        if let unwrappedFeed = feed {
            self.feedNameLabel.text = unwrappedFeed.feedName
            Networking.shared.fetchImageFromServer(stringUrl: unwrappedFeed.imageURL, successCompletion: { [unowned self] image in
                
                self.feedImageView.image = image
            })
        }
    }
    
    func dependencyInjection(feed: Feed) {
        self.feed = feed
        self.fetchFeedData()
    }
}
