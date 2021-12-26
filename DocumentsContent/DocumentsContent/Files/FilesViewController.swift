//
//  ViewController.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 04.12.2021.
//

import UIKit

class FilesViewController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        DispatchQueue.main.async {

            UserDefaults.standard.set(true, forKey: "sorted")

            NotificationCenter.default.post(name: NSNotification.Name("sorted"), object: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cellId = "file"
    private let fileManager = FileManager.default
    
    private lazy var documentURL = try! fileManager.url(for: .documentDirectory, in: .userDomainMask,
                                                       appropriateFor: nil, create: false)
    private lazy var notSortContent = content
    
    private lazy var content = try! fileManager.contentsOfDirectory(at: documentURL,
                                                                    includingPropertiesForKeys: nil,
                                                                    options: []) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let imagePicker: UIImagePickerController = {
       let controller = UIImagePickerController()
        
        controller.sourceType = .photoLibrary
        controller.allowsEditing = true
        
        return controller
    }()
        
    private let tableView: UITableView = {
       let view = UITableView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FileTableViewCell.self, forCellReuseIdentifier: cellId)
        
        imagePicker.delegate = self
        
        setupViews()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("sorted"),
                                               object: nil, queue: nil) { [weak self] _ in
            
            if UserDefaults.standard.bool(forKey: "sorted") {
                
                self?.content.sort { $0.absoluteString > $1.absoluteString }
                
            } else {
                
                self?.content = self?.notSortContent ?? []
                
            }
        }
    }
    
    private func setupViews() {
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "Files"
        self.title = "Files"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        self.view.addSubview(tableView)
        
        let constraints = [tableView.topAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.topAnchor),
                           tableView.bottomAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.bottomAnchor),
                           tableView.leadingAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.leadingAnchor),
                           tableView.trailingAnchor.constraint(equalTo:
                                                        self.view.safeAreaLayoutGuide.trailingAnchor)]
        
        NSLayoutConstraint.activate(constraints)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Pick image",
            style: .plain,
            target: self,
            action: #selector(pushImagesController)
        )
    }
    
    @objc private func pushImagesController() {
        self.present(imagePicker, animated: true)
    }
}

extension FilesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FileTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId,
                                                                for: indexPath) as! FileTableViewCell
        
        cell.fileName = content[indexPath.row].path
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo
                               info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue:
                                                    "UIImagePickerControllerEditedImage")] as? UIImage,
           let data = image.pngData() {
            
            var newURL = documentURL.appendingPathComponent("image\(Int.random(in: 0...100000)).png")
            
            content.forEach { url in
                if newURL == url {
                    newURL = documentURL.appendingPathComponent("image\(Int.random(in: 0...100000)).png")
                }
            }
            
            fileManager.createFile(atPath: newURL.path, contents: data, attributes: nil)
            
            content.append(newURL)
            
            notSortContent.append(newURL)
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
