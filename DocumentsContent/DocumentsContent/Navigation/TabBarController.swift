//
//  TabBarController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 15.12.2021.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let controllers = [FirstNavigationController(), SecondNavigationController()]
        
        self.viewControllers = controllers
        self.selectedIndex = 1
        self.selectedIndex = 0
    }
}
