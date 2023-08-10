//
//  CameraError.swift
//  SimpleCameraApp
//
//  Created by Max Ward on 09/08/2023.
//

import Foundation

public enum CameraError: Error {
    case None
    case ErrorCreaingDevice
    case ErrorCreatingInputFromDevice
    case CantAddDeviceInput
    case CantAddDeviceOutput
    case Unknown
}
