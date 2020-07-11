//
//  ImageProviderFake.swift
//  TestingResources
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UtilsInterfaces
import UIKit

public class ImageProviderFake: ImageProviderProtocol {
    
    public init() { }
    
    public func loadImage(imageURL: String, callback: (UIImage?) -> Void) {
        callback(nil)
        return
    }
    
}
