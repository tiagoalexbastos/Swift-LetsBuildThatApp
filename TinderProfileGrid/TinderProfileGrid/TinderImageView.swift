//
//  TinderImageView.swift
//  TinderProfileGrid
//
//  Created by Tiago Bastos on 30/07/2018.
//  Copyright © 2018 Tiago Bastos. All rights reserved.
//

import UIKit

class TinderImageView: UIImageView {
  
  @IBInspectable
  var imageIndex: NSNumber! {
    didSet {
      let imageName = "daenerys\(imageIndex.stringValue)"
      self.image = UIImage(named: imageName)
      layer.cornerRadius = 5
      indexLabel.text = imageIndex.stringValue
    }
  }
  
  lazy var indexLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = .boldSystemFont(ofSize: 16)
    label.layer.shadowOpacity = 0.7
    label.layer.shadowOffset = .zero
    return label
  }()
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    addSubview(indexLabel)
    indexLabel.translatesAutoresizingMaskIntoConstraints = false
    indexLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
    indexLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
  }
}
