import UIKit

class EyeHeadControlViewController: UIViewController, EyeTrackingDelegate, HeadTrackingDelegate {
    private let eyeDetectionAlgorithm = EyeTrackingAlgorithm()
    private let headTrackingAlgorithm = HeadTrackingAlgorithm()
    
    private lazy var eyeTrackingController: EyeTrackingController = {
        let controller = EyeTrackingController(eyeDetectionAlgorithm: eyeDetectionAlgorithm)
        controller.delegate = self
        return controller
    }()
    
    private lazy var headTrackingController: HeadTrackingController = {
        let controller = HeadTrackingController(headTrackingAlgorithm: headTrackingAlgorithm)
        controller.delegate = self
        return controller
    }()
    
    private let eyeHeadView = EyeHeadView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startTracking()
    }
    
    private func setupView() {
        view.addSubview(eyeHeadView)
        eyeHeadView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eyeHeadView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eyeHeadView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            eyeHeadView.topAnchor.constraint(equalTo: view.topAnchor),
            eyeHeadView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    private func startTracking() {
        eyeTrackingController.startEyeTracking()
        headTrackingController.startHeadTracking()
    }
    
    // MARK: - EyeTrackingDelegate
    
    func didDetectBlink() {
        eyeHeadView.updateEyeStatus(isBlinking: true)
    }
    
    func didDetectNoBlink() {
        eyeHeadView.updateEyeStatus(isBlinking: false)
    }
    
    // MARK: - HeadTrackingDelegate
    
    func didUpdateHeadRotation(rotation: HeadRotationResult) {
        eyeHeadView.updateHeadRotation(rotation: rotation)
    }
}
