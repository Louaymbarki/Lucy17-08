import CoreImage
import Vision

class EyeTrackingAlgorithm {
    func extractEyeFeatures(from pixelBuffer: CVPixelBuffer) -> EyeFeatures? {
        guard let faceLandmarks = detectFaceLandmarks(in: pixelBuffer),
            let landmarks = extractEyeLandmarks(from: faceLandmarks) else {
                return nil
        }
        
        let eyePosition = estimateEyePosition(from: landmarks)
        let eyeMovement = estimateEyeMovement(from: landmarks)
        
        let eyeFeatures = EyeFeatures(eyePosition: eyePosition, eyeMovement: eyeMovement, landmarks: landmarks)
        return eyeFeatures
    }
    
    private func detectFaceLandmarks(in pixelBuffer: CVPixelBuffer) -> VNFaceLandmarks2D? {
        var faceLandmarks: VNFaceLandmarks2D?
        do {
            let request = VNDetectFaceLandmarksRequest()
            let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
            try handler.perform([request])
            if let result = request.results?.first as? VNFaceObservation {
                faceLandmarks = result.landmarks
            }
        } catch {
            print("Failed to detect face landmarks: \(error.localizedDescription)")
        }
        return faceLandmarks
    }
    
    private func extractEyeLandmarks(from faceLandmarks: VNFaceLandmarks2D) -> [CGPoint]? {
        var eyeLandmarks: [CGPoint] = []
        let points: [VNFaceLandmarkRegion2D?] = [
            faceLandmarks.leftEye,
            faceLandmarks.rightEye
        ]
        for point in points {
            if let point = point {
                let normalizedLandmarks = point.normalizedPoints
                for normalizedLandmark in normalizedLandmarks {
                    eyeLandmarks.append(normalizedLandmark)
                }
            }
        }
        if eyeLandmarks.count == 0 {
            return nil
        }
        return eyeLandmarks
    }
    
    private func estimateEyePosition(from eyeLandmarks: [CGPoint]) -> EyePosition {
        let xValues = eyeLandmarks.map { $0.x }
        let yValues = eyeLandmarks.map { $0.y }
        let zValues = Array(repeating: 0.0, count: eyeLandmarks.count)
        
        let eyePosition = EyePosition(x: Float(xValues.reduce(0, +)) / Float(xValues.count),
                                      y: Float(yValues.reduce(0, +)) / Float(yValues.count),
                                      z: Float(zValues.reduce(0, +)) / Float(zValues.count))
        return eyePosition
    }
    
    private func estimateEyeMovement(from eyeLandmarks: [CGPoint]) -> EyeMovement {
        let pitch = 0.0 // Placeholder value, implement your own algorithm to estimate eye movement pitch
        let roll = 0.0 // Placeholder value, implement your own algorithm to estimate eye movement roll
        let yaw = 0.0 // Placeholder value, implement your own algorithm to estimate eye movement yaw
        
        let eyeMovement = EyeMovement(pitch: pitch, roll: roll, yaw: yaw)
        return eyeMovement
    }
}


