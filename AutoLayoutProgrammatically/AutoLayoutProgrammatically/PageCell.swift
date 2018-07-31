//
//  PageCell.swift
//  AutoLayoutProgrammatically
//
//  Created by Tiago Bastos on 31/07/2018.
//  Copyright © 2018 Tiago Bastos. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
  
  var page: Page? {
    didSet {
      guard let unwrappedPage = page else {
        return
      }
      startImageView.image = UIImage(named: unwrappedPage.imageName)
      
      let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
      attributedText.append(NSAttributedString(string: "\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
      descriptionTextView.attributedText = attributedText
      descriptionTextView.textAlignment = .center
    }
  }
  
  //MARK:- View Closure creation
  private lazy var startImageView: UIImageView = {
    let iv = UIImageView(image: #imageLiteral(resourceName: "bear_first"))
    iv.contentMode = .scaleAspectFit
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  private lazy var halfContainerView: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    return container
  }()
  
  private lazy var descriptionTextView: UITextView = {
    let tv = UITextView()
    tv.isEditable = false
    tv.isScrollEnabled = false
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubViews()
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addSubViews() {
    addSubview(halfContainerView)
    halfContainerView.addSubview(startImageView)
    addSubview(descriptionTextView)
  }
  
  private func setupViews() {
    halfContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    halfContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    halfContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    halfContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    
    startImageView.centerXAnchor.constraint(equalTo: halfContainerView.centerXAnchor).isActive = true
    startImageView.centerYAnchor.constraint(equalTo: halfContainerView.centerYAnchor).isActive = true
    startImageView.heightAnchor.constraint(equalTo: halfContainerView.heightAnchor, multiplier: 0.5).isActive = true
    
    descriptionTextView.topAnchor.constraint(equalTo: halfContainerView.bottomAnchor).isActive = true
    descriptionTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
    descriptionTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
    descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
  }
  
}
