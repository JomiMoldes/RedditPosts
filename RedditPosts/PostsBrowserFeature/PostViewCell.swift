//
//  PostViewCell.swift
//  PostsBrowserFeature
//
//  Created by Miguel Moldes on 10/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import Foundation
import UIKit

final class PostViewCell: UITableViewCell {
    
    static let identifier: String = "PostViewCell"
    
    func setup(_ viewModel: PostViewCellViewModel) {
        self.textLabel?.text = viewModel.title
    }
}
