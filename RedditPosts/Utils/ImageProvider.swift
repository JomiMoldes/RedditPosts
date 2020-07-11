//
//  ImageProvider.swift
//  Utils
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UtilsInterfaces
import UIKit

public class ImageProvider: ImageProviderProtocol {
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    public init() { }
    
    public func loadImage(imageURL: String, callback: @escaping (UIImage?) -> Void) {
        if let image = self.imageCache.object(forKey: imageURL as AnyObject) as? UIImage {
            callback(image)
            return
        }
        guard let url = URL(string: imageURL) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                return
            }
            guard let data = data,
                let image = UIImage(data: data) else {
                return
            }
            self.imageCache.setObject(image, forKey: imageURL as AnyObject)
            callback(image)
        }
    }
    
}
