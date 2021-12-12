//
//  FileTableViewCell.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 05.12.2021.
//

import UIKit

class FileTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .white
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var fileName: String? {
        didSet {
            self.fileNameLabel.text = fileName
        }
    }
        
    private let fileNameLabel: UILabel = {
        let label = UILabel()
        
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupView() {
        self.addSubview(fileNameLabel)
        
        let constraints = [fileNameLabel.leadingAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.leadingAnchor),
                           fileNameLabel.trailingAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.trailingAnchor),
                           fileNameLabel.topAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.topAnchor),
                           fileNameLabel.bottomAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.bottomAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
