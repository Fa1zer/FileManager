//
//  LogInViewController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 15.12.2021.
//

import UIKit
import KeychainAccess

class LogInViewController: UIViewController {
    
    private let keychain = Keychain(service: "bdfg.DocumentsContent")
    var changePassword = false
    
    private let passwordTextField: UITextField = {
        let view = UITextField()
        
        view.tintColor = .black
        view.backgroundColor = .systemGray6
        view.textColor = .black
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.placeholder = "Password"
        view.isSecureTextEntry = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        view.leftViewMode = .always
        view.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        view.rightViewMode = .always
        
        return view
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        self.tabBarController?.tabBar.isHidden = true
        self.view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.tabBarItem = UITabBarItem(title: "Files",
                                       image: UIImage(systemName: "folder"),
                                       selectedImage: UIImage(systemName: "folder"))
        
        self.view.addSubview(passwordTextField)
        self.view.addSubview(logInButton)
        
        let constraints = [passwordTextField.centerXAnchor.constraint(equalTo:
                                                                view.safeAreaLayoutGuide.centerXAnchor),
                           passwordTextField.centerYAnchor.constraint(equalTo:
                                                                view.safeAreaLayoutGuide.centerYAnchor),
                           passwordTextField.trailingAnchor.constraint(equalTo:
                                                                view.safeAreaLayoutGuide.trailingAnchor,
                                                                constant: -20),
                           passwordTextField.leadingAnchor.constraint(equalTo:
                                                                view.safeAreaLayoutGuide.leadingAnchor,
                                                                constant: 20),
                           passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        
                           logInButton.leadingAnchor.constraint(equalTo:
                                                                    passwordTextField.leadingAnchor),
                           logInButton.trailingAnchor.constraint(equalTo:
                                                                    passwordTextField.trailingAnchor),
                           logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                                           constant: 15),
                           logInButton.heightAnchor.constraint(equalToConstant: 50)]
        
        NSLayoutConstraint.activate(constraints)
        
        if let _ = keychain["user"] {
            logInButton.setTitle("Введите пароль", for: .normal)
        } else {
            logInButton.setTitle("Создать пароль", for: .normal)
        }
    }
    
    private func checkPassword(password: String) {
        
        if keychain["user"] == password {
            
            self.navigationController?.pushViewController(FilesViewController(), animated: true)
            
        } else {
            
            passwordTextField.text = ""
            
            presentAlert(title: "Не правильный пароль")
        }
    }
    
    private func recheckPassword(password: String) {
        
        if keychain["user"] == password {
            
            if changePassword == true {
                
                self.navigationController?.popViewController(animated: true)
                self.tabBarController?.tabBar.isHidden = false
                
            } else {
                
                self.navigationController?.pushViewController(FilesViewController(), animated: true)
                
            }
            
        } else {
            
            passwordTextField.text = ""
            
            logInButton.setTitle("Создать пароль", for: .normal)
            
            presentAlert(title: "Не правильный пароль")
        }
    }
    
    private func createPassword(password: String) {
        
        guard password.count > 4 else {
            
            passwordTextField.text = ""
            
            presentAlert(title: "Слишком короткий пароль")
            
            return
        }
        
        keychain["user"] = password
        
        logInButton.setTitle("Повторите пароль", for: .normal)
        
        passwordTextField.text = ""
    }
    
    private func presentAlert(title: String) {
        let alertController = UIAlertController(title: title,
                                    message: nil,
                                    preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "ОК", style: .default)
        
        
        alertController.addAction(cancelAction)
        
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func logInButtonTapped() {
        if logInButton.titleLabel?.text == "Введите пароль", let password = passwordTextField.text {
            
            checkPassword(password: password)
            
        } else if logInButton.titleLabel?.text == "Повторите пароль",
                  let password = passwordTextField.text {
            
            recheckPassword(password: password)
            
        } else {
            createPassword(password: passwordTextField.text!)
        }
    }
}
