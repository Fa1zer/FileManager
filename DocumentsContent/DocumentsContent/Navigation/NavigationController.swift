//
//  NavigationController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 04.12.2021.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [FilesViewController()]
        self.title = "Files"
        
    }
}
