//
//  ViewController.swift
//  AutoLayoutProgrammatically
//
//  Created by Tiago Bastos on 30/07/2018.
//  Copyright © 2018 Tiago Bastos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK:- View Closure creation
  private lazy var startImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "bear_first")
    iv.contentMode = .scaleAspectFit
    iv.translatesAutoresizingMaskIntoConstraints = false
    return iv
  }()
  
  private lazy var descriptionTextView: UITextView = {
    let tv = UITextView()
    let attributedText = NSMutableAttributedString(string: "Join us today in our fun and games!", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
    attributedText.append(NSAttributedString(string: "\n\nAre you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon.", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
    tv.attributedText = attributedText
    tv.textAlignment = .center
    tv.isEditable = false
    tv.isScrollEnabled = false
    tv.translatesAutoresizingMaskIntoConstraints = false
    return tv
  }()
  
  private lazy var halfContainerView: UIView = {
    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    return container
  }()
  
  private lazy var previousButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("PREV", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.setTitleColor(.gray, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("NEXT", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    let pinkColor = UIColor(displayP3Red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    button.setTitleColor(pinkColor, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.numberOfPages = 4
    pc.currentPage = 0
    pc.currentPageIndicatorTintColor = .red
    pc.pageIndicatorTintColor = UIColor(displayP3Red: 249/255, green: 207/255, blue: 224/255, alpha: 1)

    return pc
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addSubViews()
    
    setupViews()
  }
  
  private func addSubViews() {
    view.addSubview(halfContainerView)
    halfContainerView.addSubview(startImageView)
    view.addSubview(descriptionTextView)
  }
  
  private func setupBottonControls() {
    let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
    bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
    bottomControlsStackView.distribution = .fillEqually
    
    view.addSubview(bottomControlsStackView)
    
    NSLayoutConstraint.activate([
      bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)
      ])
  }
  
  private func setupViews() {
    halfContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    halfContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    halfContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    halfContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
    startImageView.centerXAnchor.constraint(equalTo: halfContainerView.centerXAnchor).isActive = true
    startImageView.centerYAnchor.constraint(equalTo: halfContainerView.centerYAnchor).isActive = true
    startImageView.heightAnchor.constraint(equalTo: halfContainerView.heightAnchor, multiplier: 0.5).isActive = true
    
    descriptionTextView.topAnchor.constraint(equalTo: halfContainerView.bottomAnchor).isActive = true
    descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
    descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
}

