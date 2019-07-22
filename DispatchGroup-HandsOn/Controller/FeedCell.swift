//
//  FeedCell.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {
    
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
    
    func parseData(feedName: String, feedImage: UIImage?) {
        self.feedImageView.image = feedImage
        self.feedNameLabel.text = feedName
    }
}
