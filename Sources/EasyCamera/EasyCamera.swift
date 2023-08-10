// The Swift Programming Language
// https://docs.swift.org/swift-book

import AVFoundation
import CoreImage
import SwiftUI

@available(iOS 13.0, *)
open class EasyCamera: NSObject, ObservableObject {
    
    // MARK: Session
    private var _captureSession: AVCaptureSession = AVCaptureSession()
    
    private let _sessionQueue: DispatchQueue = DispatchQueue.global(qos: .userInitiated)
    
    private var _isConfigured: Bool = false
    
    // MARK: Input
    private var _captureInput: AVCaptureInput?
    
    // MARK: Output
    private var _captureOutput: AVCaptureOutput?
    
    // MARK: Preview
    public lazy var cameraPreviewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: _captureSession)
    
    // MARK: Device
    private var _captureDevice: AVCaptureDevice?
    
    // MARK: PROPERTIES
    @Published public var imageData: Data?
    
    // MARK: - Devices
    lazy var captureDevices: [AVCaptureDevice] = {
        AVCaptureDevice.availableCaptureDevices()
    }()
    
    public lazy var frontCaptureDevices: [AVCaptureDevice] = {
        captureDevices.filter { device in
            device.position == .front
        }
    }()
    
    public lazy var backCaptureDevices: [AVCaptureDevice] = {
        captureDevices.filter { device in
            device.position == .back
        }
    }()
    
    public var captureSession: AVCaptureSession  {
        self._captureSession
    }
    
    public var cameraPermissionStatus: AVAuthorizationStatus {
        AVCaptureDevice.authorizationStatus(for: .video)
    }
    
    public override init() {
        super.init()
    }
    
    // MARK: LIFE CYCLE
    public func startSession() {
        guard _isConfigured, !_captureSession.isRunning else { return }
        _sessionQueue.async { [unowned self] in
            _captureSession.startRunning()
        }
    }
    
    public func stopSession() {
        guard _captureSession.isRunning else { return }
        _sessionQueue.async { [unowned self] in
            _captureSession.stopRunning()
        }
    }
    
    // MARK: CAPTURE SESSION CONFIG
    public func configCaptureSession() async {
        _sessionQueue.async { [unowned self] in
            self._captureSession.sessionPreset = .photo
            do {
                self._captureSession.beginConfiguration()
                _captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                         for: .video,
                                                         position: .unspecified)
                guard let _captureDevice else {
                    throw CameraError.Unknown
                }
                
                let captureInput = try AVCaptureDeviceInput(device: _captureDevice)
                guard _captureSession.canAddInput(captureInput) else {
                    throw CameraError.Unknown
                }
                
                self._captureInput = captureInput
                self._captureSession.addInput(captureInput)
                
                _captureOutput = AVCapturePhotoOutput()
                guard let _captureOutput else {
                    throw CameraError.Unknown
                }
                guard _captureSession.canAddOutput(_captureOutput) else {
                    throw CameraError.CantAddDeviceOutput
                }
                
                self._captureSession.addOutput(_captureOutput)
                
                self._captureSession.commitConfiguration()
                
                self._isConfigured = true
                
                self.startSession()
            } catch {
                fatalError()
            }
        }
    }
    
    public func takePhoto() {
        // PHOTO SETTINGS
        var photoSettings: AVCapturePhotoSettings
        
        guard let captureOut = self._captureOutput as? AVCapturePhotoOutput else { return }
        
        if captureOut.availablePhotoCodecTypes.contains(.hevc) {
            photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
        } else {
            photoSettings = .init()
        }
        photoSettings.flashMode = .auto
        
        captureOut.capturePhoto(with: photoSettings, delegate: self)
    }
}

@available(iOS 13.0, *)
extension EasyCamera: AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print("didCapturePhotoFor")
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput,
                            willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print(#function)
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput,
                            willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        print(#function)
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput,
                            didFinishCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings, error: Error?) {
        print(#function)
    }
    
    public func photoOutput(_ output: AVCapturePhotoOutput,
                            didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        print(#function)
        self.imageData = photo.fileDataRepresentation()
    }
}
