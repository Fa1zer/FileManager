//
//  SecondNavigationController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 19.12.2021.
//

import UIKit

class SecondNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [SettingsViewController()]
        self.title = "Settings"
        self.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gearshape"),
                                       selectedImage: UIImage(systemName: "gearshape"))
    }
}
