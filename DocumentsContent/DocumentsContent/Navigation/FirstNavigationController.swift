//
//  NavigationController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 04.12.2021.
//

import UIKit

class FirstNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [LogInViewController()]
        self.title = "Files"
    }
}
