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
    
    func fetchImageFromServer(stringUrl: String, successCompletion : @escaping (UIImage?) -> Void, failCompletion: (() -> Void)? = nil) {
        guard let url = URL(string: stringUrl) else {
            fatalError("Invalid URL")
        }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Error in networking", error.localizedDescription)
                if let failCompletion = failCompletion {
                    DispatchQueue.main.async {
                        failCompletion()
                    }
                }
            } else if let response = response, let data = data {
                print("Networking response:", response)
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    successCompletion(image)
                }
            }
        }.resume()
    }
    
    func fetchDummyData() -> [Feed] {
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            do {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url, options: .mappedIfSafe)
                
                let feedData = try JSONDecoder().decode(Array<Feed>.self, from: data)
                return feedData
            } catch {
                // Hanldle error
                print("Error in fetching dummy data:", error.localizedDescription)
            }
        }
        
        return []
    }
}
