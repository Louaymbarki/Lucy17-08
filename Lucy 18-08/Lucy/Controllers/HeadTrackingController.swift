import CoreMotion

protocol HeadTrackingDelegate: AnyObject {
    func didUpdateHeadRotation(rotation: HeadRotationResult)
}

class HeadTrackingController: NSObject {
    let headTrackingModel: HeadTrackingModel
    let motionManager: CMMotionManager
    weak var delegate: HeadTrackingDelegate?
    
    init(headTrackingModel: HeadTrackingModel, motionManager: CMMotionManager) {
        self.headTrackingModel = headTrackingModel
        self.motionManager = motionManager
        super.init()
    }
    
    func startHeadTracking() {
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] (motion, error) in
            guard motion != nil else {
                return
            }
            
            let rotation = self?.headTrackingModel.calculateHeadRotation()
            
            DispatchQueue.main.async {
                self?.delegate?.didUpdateHeadRotation(rotation: rotation!)
            }
        }
    }
    
    func stopHeadTracking() {
        motionManager.stopDeviceMotionUpdates()
    }
}
