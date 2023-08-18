import AVFoundation

protocol EyeTrackingDelegate: AnyObject {
    func didDetectBlink()
    func didDetectNoBlink()
}

class EyeTrackingController: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    let eyeTrackingModel: EyeTrackingModel
    let captureSession: AVCaptureSession
    weak var delegate: EyeTrackingDelegate?
    
    init(eyeTrackingModel: EyeTrackingModel, captureSession: AVCaptureSession) {
        self.eyeTrackingModel = eyeTrackingModel
        self.captureSession = captureSession
        super.init()
        
        guard let videoOutput = captureSession.outputs.first as? AVCaptureVideoDataOutput else {
            return
        }
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue.global(qos: .userInteractive))
    }
    
    func startEyeTracking() {
        if !captureSession.isRunning {
            captureSession.startRunning()
        }
    }
    
    func stopEyeTracking() {
        if captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        guard let eyeFeatures = eyeTrackingModel.extractEyeFeatures(from: pixelBuffer) else {
            return
        }
        
        let landmarks = eyeFeatures.landmarks
        let isBlinking = BlinkDetectionAlgorithm().detectBlink(from: landmarks)
        
        DispatchQueue.main.async {
            if isBlinking {
                self.delegate?.didDetectBlink()
            } else {
                self.delegate?.didDetectNoBlink()
            }
        }
    }
}
