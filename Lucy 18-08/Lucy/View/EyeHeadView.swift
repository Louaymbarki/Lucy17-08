import UIKit

class EyeHeadView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Eye & Head Control"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.black
        return label
    }()
    
    private let eyeStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    private let headRotationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(eyeStatusLabel)
        addSubview(headRotationLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            eyeStatusLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            eyeStatusLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            headRotationLabel.topAnchor.constraint(equalTo: eyeStatusLabel.bottomAnchor, constant: 16),
            headRotationLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    func updateEyeStatus(isBlinking: Bool) {
        let status = isBlinking ? "Blinking" : "Not Blinking"
        eyeStatusLabel.text = "Eye Status: \(status)"
    }
    
    func updateHeadRotation(rotation: HeadRotationResult) {
        let pitch = String(format: "%.2f", rotation.pitch)
        let roll = String(format: "%.2f", rotation.roll)
        let yaw = String(format: "%.2f", rotation.yaw)
        headRotationLabel.text = "Head Rotation: Pitch: \(pitch), Roll: \(roll), Yaw: \(yaw)"
    }
}
