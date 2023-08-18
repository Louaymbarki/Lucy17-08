import UIKit
import ARKit

class EyeHeadViewController: UIViewController {
    let eyeHeadView: EyeHeadView
    
    init() {
        self.eyeHeadView = EyeHeadView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view = eyeHeadView
    }
}
