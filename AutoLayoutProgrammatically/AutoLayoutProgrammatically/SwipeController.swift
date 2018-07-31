//
//  SwipeController.swift
//  AutoLayoutProgrammatically
//
//  Created by Tiago Bastos on 31/07/2018.
//  Copyright © 2018 Tiago Bastos. All rights reserved.
//

import UIKit

class SwipeController: UICollectionViewController {
  
  //MARK:- Model
  fileprivate let cellID = "cellID"
  fileprivate let pages = [
    Page(imageName: "bear_first", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
    Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
    Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: ""),
    Page(imageName: "bear_first", headerText: "Join use today in our fun and games!", bodyText: "Are you ready for loads and loads of fun? Don't wait any longer! We hope to see you in our stores soon."),
    Page(imageName: "heart_second", headerText: "Subscribe and get coupons on our daily events", bodyText: "Get notified of the savings immediately when we announce them on our website. Make sure to also give us any feedback you have."),
    Page(imageName: "leaf_third", headerText: "VIP members special services", bodyText: "")
  ]
  
  //MARK:- View Closures
  private lazy var previousButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("PREV", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    button.setTitleColor(.gray, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handlePrev), for: .touchUpInside)

    return button
  }()
  
  private lazy var nextButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("NEXT", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 14)
    let pinkColor = UIColor(displayP3Red: 232/255, green: 68/255, blue: 133/255, alpha: 1)
    button.setTitleColor(pinkColor, for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
    return button
  }()
  
  private lazy var pageControl: UIPageControl = {
    let pc = UIPageControl()
    pc.numberOfPages = pages.count
    pc.currentPage = 0
    pc.currentPageIndicatorTintColor = .red
    pc.pageIndicatorTintColor = UIColor(displayP3Red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
    
    return pc
  }()
  
  //MARK:- Swipe handlers
  @objc private func handleNext() {
    let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
    let indexPath = IndexPath(item: nextIndex, section: 0)
    pageControl.currentPage = nextIndex
    collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  @objc private func handlePrev() {
    let nextIndex = max(pageControl.currentPage - 1, 0)
    let indexPath = IndexPath(item: nextIndex, section: 0)
    pageControl.currentPage = nextIndex
    collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBottonControls()
    
    collectionView?.backgroundColor = .white
    collectionView?.register(PageCell.self, forCellWithReuseIdentifier: cellID)
    collectionView?.isPagingEnabled = true
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    
    coordinator.animate(alongsideTransition: { (_) in
      self.collectionViewLayout.invalidateLayout()
      
      if self.pageControl.currentPage == 0 {
        self.collectionView?.contentOffset = .zero
      } else {
        let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
        self.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      }
      
    }) { (_) in
      
    }
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let x = targetContentOffset.pointee.x
    pageControl.currentPage = Int(x / view.frame.width)
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PageCell
    
    let page = pages[indexPath.item]
    cell.page = page
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
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
}

//MARK:- UICollectionViewDelegateFlowLayout
extension SwipeController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.height)
  }
  
}
