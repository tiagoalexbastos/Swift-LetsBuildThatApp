//
//  ViewController.swift
//  ObjectDetectorSwift4
//
//  Created by Tiago Bastos on 21/08/2017.
//  Copyright © 2017 Tiago Bastos. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    
        setupLabel()

    }
    
    private func setupLabel() {
        view.addSubview(resultsLabel)
        resultsLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16).isActive = true
        resultsLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        resultsLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        resultsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model) { (finishedRequest, error) in
            if error != nil {
                return
            }
            
            guard let results = finishedRequest.results as? [VNClassificationObservation] else {
                return
            }
            
            if let observation = results.first {
                DispatchQueue.main.async {
                    self.resultsLabel.text = "\(observation.identifier) \(observation.confidence * 100)"
                }
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
        
    }
    
    let resultsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
}

