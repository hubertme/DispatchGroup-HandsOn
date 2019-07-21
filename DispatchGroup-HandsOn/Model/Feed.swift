//
//  Feed.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import Foundation
import UIKit

class Feed: Codable {
    let id: Int
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "imageUrl"
    }
}
