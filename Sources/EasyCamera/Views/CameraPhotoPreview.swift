//
//  CameraLayerView.swift
//  SimpleCameraApp
//
//  Created by Max Ward on 04/08/2023.
//

import SwiftUI
import UIKit
import AVFoundation

public struct CameraPhotoPreview: UIViewRepresentable {
    private var captureLayer: AVCaptureVideoPreviewLayer
    
    public init(captureLayer: AVCaptureVideoPreviewLayer) {
        self.captureLayer = captureLayer
    }
    
    public func makeUIView(context: Context) -> CaptureLayerView {
        let view = CaptureLayerView()
        captureLayer.videoGravity = .resizeAspect
        captureLayer.frame = view.frame
        view.layer.addSublayer(captureLayer)
        return view
    }
    public func updateUIView(_ uiView: CaptureLayerView, context: Context) { }
}

extension CameraPhotoPreview {
    public class CaptureLayerView: UIView {
        public override func layoutSubviews() {
            super.layoutSubviews()
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.sublayers?.forEach({ layer in
                layer.frame = frame
            })
            CATransaction.commit()
        }
    }
}
