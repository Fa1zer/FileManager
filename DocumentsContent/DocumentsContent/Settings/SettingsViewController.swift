//
//  SettingsViewController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 15.12.2021.
//

import UIKit
import KeychainAccess

class SettingsViewController: UIViewController {
    
    private let keychain = Keychain(service: "bdfg.DocumentsContent")
    private let userDefaults = UserDefaults.standard
    private let cellId = "settings"
    
    private let tableView: UITableView = {
        let view  = UITableView(frame: .zero, style: .plain)
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: cellId)
        
        setupViews()
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = "Settings"
        self.title = "Settings"
        self.tabBarItem = UITabBarItem(title: "Settings",
                                       image: UIImage(systemName: "gearshape"),
                                       selectedImage: UIImage(systemName: "gearshape"))
        
        self.view.addSubview(tableView)
        
        let constraints = [tableView.topAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.topAnchor),
                           tableView.bottomAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.bottomAnchor),
                           tableView.trailingAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.trailingAnchor),
                           tableView.leadingAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.leadingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                            for: indexPath) as! SettingsTableViewCell
        
        if indexPath.row == 0 {
            cell.name = "Сортировать файлы в алфавитном порядке"
        } else {
            cell.name = "Изменить пароль"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            DispatchQueue.main.async { [weak self] in
                
                if (self?.userDefaults.bool(forKey: "sorted"))! {
                
                    self?.userDefaults.setValue(false, forKey: "sorted")
                
                } else {
                    
                    self?.userDefaults.setValue(true, forKey: "sorted")
                
                }
                
                NotificationCenter.default.post(name: NSNotification.Name("sorted"), object: nil)
            }
            
        } else {
            
            let controller = LogInViewController()
            
            controller.changePassword = true
            
            self.navigationController?.pushViewController(controller, animated: true)
            
            try? keychain.remove("user", ignoringAttributeSynchronizable: true)
        }
    }
}
