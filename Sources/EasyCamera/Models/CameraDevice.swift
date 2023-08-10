//
//  File.swift
//  
//
//  Created by Max Ward on 09/08/2023.
//

import Foundation

public enum CameraDevice {
    case front
    case back
    case doubleFront
    case doubleBack
    case null
    
    public var switchMode: CameraDevice {
        switch self {
        case .front:
            return .back
        case .back:
            return .front
        case .doubleFront:
            return .doubleBack
        case .doubleBack:
            return .doubleFront
        case .null:
            return .null
        }
    }
}
