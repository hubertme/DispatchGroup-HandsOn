//
//  Networking.swift
//  DispatchGroup-HandsOn
//
//  Created by Hubert Wang on 21/07/2019.
//  Copyright © 2019 Hubert Wang. All rights reserved.
//

import Foundation
import UIKit

final class Networking {
    static var shared = Networking()
    
    private init() {}
    
    func fetchImageFromServer(stringUrl: String, _ completion : @escaping (UIImage) -> Void) {
        guard let url = URL(string: stringUrl) else {
            fatalError("Invalid URL")
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response {
                print(response)
            }
        }.resume()
    }
}
