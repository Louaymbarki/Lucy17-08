import CoreGraphics

struct EyeFeatures {
    let eyePosition: EyePosition
    let eyeMovement: EyeMovement
    let landmarks: [CGPoint]
}

struct EyePosition {
    let x: Float
    let y: Float
    let z: Float
}

struct EyeMovement {
    let pitch: Double
    let roll: Double
    let yaw: Double
}
