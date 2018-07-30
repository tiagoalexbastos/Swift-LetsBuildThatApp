//
//  ProfileController.swift
//  TinderProfileGrid
//
//  Created by Tiago Bastos on 30/07/2018.
//  Copyright © 2018 Tiago Bastos. All rights reserved.
//

import UIKit

class ProfileController: UICollectionViewController {
  
  fileprivate let headerId = "headerId"
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView?.backgroundColor = .white
    
    navigationItem.title = "Profile"
    collectionView?.alwaysBounceVertical = true
    
    let headerNib = UINib(nibName: "Header", bundle: nil)
    collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
  }
  
}

//MARK:- UICollectionView
extension ProfileController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: view.frame.width)
  }
}
