//
//  SettingsTableViewCell.swift
//  DocumentsContent
//
//  Created by Artemiy Zuzin on 19.12.2021.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var name: String? {
        didSet {
            label.text = name ?? ""
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private func setupViews() {
        
        self.addSubview(label)
        
        let constraints = [label.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                            label.bottomAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.bottomAnchor),
                            label.leadingAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.leadingAnchor,
                                                          constant: 15),
                            label.trailingAnchor.constraint(equalTo:
                                                            self.safeAreaLayoutGuide.trailingAnchor,
                                                           constant: -15)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
