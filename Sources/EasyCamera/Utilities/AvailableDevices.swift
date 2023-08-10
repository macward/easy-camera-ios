//
//  File.swift
//  
//
//  Created by Max Ward on 09/08/2023.
//

import AVFoundation

public extension AVCaptureDevice {
    static func availableCaptureDevices() -> [AVCaptureDevice] {
        AVCaptureDevice.DiscoverySession(
            deviceTypes: [
                .builtInTrueDepthCamera,
                .builtInDualCamera,
                .builtInDualWideCamera,
                .builtInTripleCamera,
                .builtInWideAngleCamera,
                .builtInUltraWideCamera,
                .builtInLiDARDepthCamera,
                .builtInTelephotoCamera
            ],
            mediaType: .video,
            position: .unspecified
        ).devices
    }
}

