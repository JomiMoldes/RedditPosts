//
//  ImageProvider.swift
//  Utils
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit

public class ImageProvider: ImageProviderProtocol {
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    public init() { }
    
    public func loadImage(imageURL: String, callback: @escaping (UIImage?) -> Void) -> URLSessionDataTask? {
        if let image = self.imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            callback(image)
            return nil
        }
        guard let url = URL(string: imageURL) else {
            callback(nil)
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                callback(nil)
                return
            }
            guard let data = data,
                let image = UIImage(data: data) else {
                    callback(nil)
                    return
            }
            self.imageCache.setObject(image, forKey: imageURL as AnyObject)
            callback(image)
        }
        task.resume()
        return task
    }
    
}
