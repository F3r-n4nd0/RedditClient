//
//  NetworkManager.swift
//  RedditClient
//
//  Created by Fernando Luna on 10/5/20.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    let cache = NSCache<NSString, UIImage>()
    
    func downloadImage(from url: URL, completed: @escaping (UIImage?) -> Void ) {
        let cacheKey = NSString(string: url.absoluteString)
        if let image =  cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                print("Error download image url:\(url.absoluteString)")
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
}
