//
//  PhotoLibraryService.swift
//  Core
//
//  Created by Max Ward on 07/08/2023.
//

import Foundation
import Photos

open class PhotoLibraryService {
    
    public init() {}
    
    public var isPhotoLibraryReadAndWriteAccessGranted: Bool {
        PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized
    }
    
    public var requestAuthorization: PHAuthorizationStatus {
        get async { await PHPhotoLibrary.requestAuthorization(for: .readWrite) }
    }
    
    public func save(data: Data) async {
        guard isPhotoLibraryReadAndWriteAccessGranted else { return }
        PHPhotoLibrary.shared().performChanges {
            let request = PHAssetCreationRequest.forAsset()
            request.addResource(with: .photo, data: data, options: nil)
        } completionHandler: { success, error in
            if let error {
                print("error saving photo: \(error.localizedDescription)")
                return
            }
        }
    }
}
