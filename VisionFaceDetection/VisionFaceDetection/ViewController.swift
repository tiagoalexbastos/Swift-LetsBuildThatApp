//
//  ViewController.swift
//  VisionFaceDetection
//
//  Created by Tiago Bastos on 21/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = UIImage(named: "semedo") {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            
            let scaledHeight = view.frame.width / image.size.width * image.size.height
                
            imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
            
            view.addSubview(imageView)
            
            let request = VNDetectFaceRectanglesRequest(completionHandler: { (req, error) in
                if error != nil {
                    return
                }
                
                req.results?.forEach({ (result) in
                    guard let faceObservation = result as? VNFaceObservation else {
                        return
                    }
                    
                    let width = self.view.frame.width * faceObservation.boundingBox.width
                    let height = scaledHeight * faceObservation.boundingBox.height
                    let x = self.view.frame.width * faceObservation.boundingBox.origin.x
                    let y = scaledHeight * (1 - faceObservation.boundingBox.origin.y) - height
 

                    let redView = UIView()
                    redView.backgroundColor = .green
                    redView.alpha = 0.4
                    redView.frame = CGRect(x: x, y: y, width: width, height: height)
                    self.view.addSubview(redView)
                    
                    
                })
            })
            
            if let cgImage = image.cgImage {
                
                
                let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
                do {
                    try handler.perform([request])
                } catch let requestError {
                    print("Failed to perform Request", requestError)
                }
            }

        }

    }


}

