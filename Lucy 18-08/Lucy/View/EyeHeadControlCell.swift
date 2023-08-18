import UIKit

class EyeHeadControlCell: UITableViewCell {
    static let identifier = "EyeHeadControlCell"
    
    private let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        return button
    }()
    
    var buttonAction: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            button.heightAnchor.constraint(equalToConstant: 36)
            ])
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        buttonAction?()
    }
    
    func configure(with title: String) {
        button.setTitle(title, for: .normal)
    }
}
