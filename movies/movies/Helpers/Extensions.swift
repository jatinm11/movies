//
//  Extensions.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static var cache: [URL: UIImage] = [:]
    
    func downloadImage(imageType: ImageType, path: String) {
        
        guard let url = URL(string: imageType.rawValue + path) else {
            print("failed url")
            return
        }
        
        if let cached = UIImageView.cache[url] {
            self.image = cached
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [ weak self ] data, response, error in
            
            if let imageData = data, let img = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    UIImageView.cache[url] = img
                    self?.image = img
                    return
                }
            }
        }
        task.resume()
    }
}
