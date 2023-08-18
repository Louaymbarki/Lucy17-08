import UIKit
import ARKit
import CoreMotion
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var session: ARSession?
    let motionManager = CMMotionManager()
    let captureSession = AVCaptureSession()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("This device does not support ARKit.")
        }
        
        // Create an instance of EyeHeadControlViewController
        let viewController = EyeHeadControlViewController()
        
        // Create instances of the eye and head tracking models
        let eyeTrackingModel = EyeTrackingModel()
        let headTrackingModel = HeadTrackingModel()
        
        // Create instances of the eye and head tracking controllers with the respective models and capture session
        let eyeTrackingController = EyeTrackingController(eyeTrackingModel: eyeTrackingModel, captureSession: captureSession)
        let headTrackingController = HeadTrackingController(headTrackingModel: headTrackingModel, motionManager: motionManager)
        
        // Set up the eye and head tracking controllers in the view controller
        viewController.eyeTrackingController = eyeTrackingController
        viewController.headTrackingController = headTrackingController
        
        // Create the ARSCNView instance
        let sceneView = ARSCNView()
        viewController.view = sceneView
        
        // Create the ARSession instance
        let session = ARSession()
        self.session = session
        sceneView.session = session
        
        // Set the ARSession delegate
        session.delegate = viewController
        sceneView.delegate = viewController
        
        // Configure ARFaceTrackingConfiguration for face tracking
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        // Run the AR session with the configuration
        session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        // Set up video capture for eye tracking
        let videoOutput = AVCaptureVideoDataOutput()
        captureSession.addOutput(videoOutput)
        videoOutput.setSampleBufferDelegate(eyeTrackingController, queue: DispatchQueue.global(qos: .userInteractive))
        
        // Start motion updates for head tracking
        motionManager.startDeviceMotionUpdates()
        
        // Set up the UIWindow and make it visible
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        return true
    }
}
