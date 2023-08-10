//
//  File.swift
//  
//
//  Created by Max Ward on 09/08/2023.
//

import Foundation
import AVFoundation

public extension EasyCamera {
    
    @discardableResult
    func requestPermissions() async -> Bool {
        let currentStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if currentStatus == .authorized { return true}
        switch currentStatus {
        case .notDetermined:
            await AVCaptureDevice.requestAccess(for: .video)
            if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
                return true
            } else { return false }
        case .restricted, .denied:
            print("camera denied")
        case .authorized:
            return true
        @unknown default:
            return false
        }
        return false
    }
}
