//
//  ViewController.swift
//  RedditPosts
//
//  Created by Miguel Moldes on 09/07/2020.
//  Copyright © 2020 Miguel Moldes. All rights reserved.
//

import UIKit
import PostsBrowserFeature
import PostsBrowserFeatureInterfaces
import ServicesInterfaces
import ModelsInterfaces
import Services
import UtilsInterfaces
import Utils
import Models

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        let service: PostServiceProtocol = PostsService(deviceId: UIDevice.current.identifierForVendor!.uuidString)
        let decodable = DecodableHelper()
        let postsCreator: PostsListCreatorProtocol = PostsListCreator(decodableHelper: decodable)
        let paginator: PostsPaginatorProtocol = PostsPaginator(service: service,
                                                               postsCreator: postsCreator)
        let imageProvider = ImageProvider()
        let viewModel: PostsSplitViewModelProtocol = PostsSplitViewModel()
        let controller = PostsSplitViewController(viewModel: viewModel,
                                                  paginator: paginator,
                                                  imageProvider: imageProvider)

        self.navigationController?.pushViewController(controller, animated: false)
    }

}
