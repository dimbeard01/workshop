

import UIKit

class BaseTextButton: BaseButton {
    var stackView: UIStackView!
    
    var isSelected: Bool = false {
        didSet {
            setNeedsLayout()
            layoutSubviews()
        }
    }
    
    var status = ButtonStatus.normal {
        willSet {
            switch newValue {
            case .busy:
                showActivityIndicator()
                break
            case .normal:
                hideActivityIndicator()
                self.alpha = 1.0
                break
            case .deactive:
                hideActivityIndicator()
                self.alpha = 0.7
                break
            }
        }
    }
    
    let tilteLabel: UILabel = {
        let label = UILabel()
        label.font = Styles.Fonts.Subhead1
        label.text = "Button"
        label.textAlignment = .center
        label.isHidden = false
        
        return label
    }()
    
    internal let activityIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.heightToWidth(of: activity)
        activity.isHidden = true
        
        return activity
    }()
    
    private var buttonColor: UIColor?
    private var textColor: UIColor?
    
    var needMaxWeight: Bool = true
    
    var insets: UIEdgeInsets = UIEdgeInsets(top: Styles.Sizes.VPaddingMedium,
                                            left: Styles.Sizes.HPaddingMedium * 2,
                                            bottom: Styles.Sizes.VPaddingMedium,
                                            right: Styles.Sizes.HPaddingMedium * 2)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        stackView = UIStackView(arrangedSubviews: [tilteLabel])
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.spacing = Styles.Sizes.HPaddingBase
        
        self.addSubview(stackView)
        self.addSubview(activityIndicatorView)
        
        stackView.leftToSuperview(offset: insets.left, relation: .equalOrGreater)
        stackView.rightToSuperview(offset: -insets.right, relation: .equalOrLess)
        stackView.topToSuperview(offset: insets.top, relation: .equalOrGreater)
        stackView.bottomToSuperview(offset: -insets.bottom, relation: .equalOrLess)
        stackView.centerInSuperview()
        
        //        self.stack([icon, tilteLabel], axis: .horizontal, spacing: Styles.Sizes.HPaddingBase)
        
        activityIndicatorView.leftToSuperview(offset: 0, relation: .equalOrGreater)
        activityIndicatorView.rightToSuperview(offset: 0, relation: .equalOrLess)
        activityIndicatorView.topToSuperview(offset: 0, relation: .equalOrGreater)
        activityIndicatorView.bottomToSuperview(offset: 0, relation: .equalOrLess)
        
        activityIndicatorView.centerInSuperview()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.makeRound()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if status == .normal {
            super.touchesEnded(touches, with: event)
        }
    }
}

extension BaseTextButton {
    @discardableResult
    func setTitle(title: String?) -> BaseTextButton {
        self.tilteLabel.text = title
        
        return self
    }
    
    @discardableResult
    func setButtonColor(color: UIColor) -> BaseTextButton  {
        self.buttonColor = color
        
        self.backgroundColor = color
        
        return self
    }
    
    @discardableResult
    func setTextColor(color: UIColor) -> BaseTextButton  {
        self.textColor = color
        
        tilteLabel.textColor = color
        activityIndicatorView.color = color
        
        return self
    }
    
    @discardableResult
    func setTitleFont(font: UIFont) -> BaseTextButton  {
        tilteLabel.font = font
        
        return self
    }
}

extension BaseTextButton: BaseButtonStatusProtocol {
    @discardableResult
    func setStatus(status: BaseButton.ButtonStatus) -> Self {
        self.status = status
        
        return self
    }
    
    @discardableResult
    func updateStatus() -> Self {
        if status == .busy, !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        } 
        
        return self
    }
    
    func showActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase) { [weak self] in
            self?.stackView.isHidden = true
            self?.activityIndicatorView.isHidden = false
            
            self?.activityIndicatorView.startAnimating()
            
            self?.layoutIfNeeded()
        }
    }
    
    func hideActivityIndicator() {
        UIView.animate(withDuration: Styles.Constants.animationDurationBase) { [weak self] in
            self?.stackView.isHidden = false
            self?.activityIndicatorView.isHidden = true
            
            self?.activityIndicatorView.stopAnimating()
            
            self?.layoutIfNeeded()
        }
    }
}


