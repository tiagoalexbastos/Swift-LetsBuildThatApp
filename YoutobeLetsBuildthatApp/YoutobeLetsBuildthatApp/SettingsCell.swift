//
//  SettingsCell.swift
//  YoutubeLBTA
//
//  Created by Tiago Bastos on 18/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit

class SettingCell: BaseCell {
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(nameLabel)
        addSubview(imageIcon)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: imageIcon, nameLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: imageIcon)

        addConstraint(NSLayoutConstraint(item: imageIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    var setting: Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.imageName {
                imageIcon.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                imageIcon.tintColor = .darkGray

            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = .systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "settings")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            nameLabel.textColor = isHighlighted ? .white : .black
            imageIcon.tintColor = isHighlighted ? .white : .darkGray

        }
    }
}
