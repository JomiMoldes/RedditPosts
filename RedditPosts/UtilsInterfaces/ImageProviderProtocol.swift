//
//  ImageProviderProtocol.swift
//  UtilsInterfaces
//
//  Created by Miguel Moldes on 11/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageProviderProtocol {
    
    func loadImage(imageURL: String, callback: @escaping (UIImage?) -> Void) -> URLSessionDataTask?
    
}
