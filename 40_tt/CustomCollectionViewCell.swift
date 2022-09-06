

import UIKit
import SnapKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    private let doorSpinnerView = SpinnerView()
    
    private let doorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Front door"
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let doorLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(red: 185/255, green: 185/255, blue: 185/255, alpha: 1)
        return label
    }()
    
    private let statusImageViewTwo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "lockedTwo")
        return imageView
    }()
    
    private let statusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locked")
        return imageView
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.text = "Locked"
        label.textColor = UIColor(red: 0, green: 68/255, blue: 139/255, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = CGColor(red: 227/255, green: 234/255, blue: 234/255, alpha: 1)
        
        contentView.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.centerX.equalTo(self.contentView)
        }
        
        contentView.addSubview(doorSpinnerView)
        doorSpinnerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(27)
            make.right.equalToSuperview().inset(20)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        doorSpinnerView.isHidden = true
        
        contentView.addSubview(statusImageView)
        statusImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(27)
            make.top.equalToSuperview().inset(18)
            make.size.equalTo(CGSize(width: 41, height: 41))
        }
        
        contentView.addSubview(statusImageViewTwo)
        statusImageViewTwo.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.right.equalToSuperview().inset(27)
            make.width.equalTo(40)
            make.height.equalTo(45)
        }
        
        contentView.addSubview(doorNameLabel)
        doorNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(22)
            make.left.equalTo(statusImageView.snp_rightMargin).inset(-20)
        }
        
        contentView.addSubview(doorLocationLabel)
        doorLocationLabel.snp.makeConstraints { make in
            make.left.equalTo(statusImageView.snp_rightMargin).inset(-20)
            make.top.equalTo(doorNameLabel.snp_bottomMargin).inset(-4)
        }
    }
    
    private func openingPhase() {
        statusLabel.text = "Unlocking..."
        statusLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.17)
        statusImageView.image = UIImage(named: "unlocking")
        doorSpinnerView.isHidden = false
        statusImageViewTwo.isHidden = true
        doorSpinnerView.animate()

    }
    
    private func openPhase() {
        statusImageViewTwo.isHidden = false
        doorSpinnerView.isHidden = true
        statusLabel.text = "Unlocked"
        statusLabel.textColor = UIColor(red: 0, green: 68/255, blue: 139/255, alpha: 0.5)
        statusImageView.image = UIImage(named: "unlocked")
        statusImageViewTwo.image = UIImage(named: "unlockedTwo")
        
    }
    
    private func closedPhase() {
        statusLabel.text = "Locked"
        statusLabel.textColor = UIColor(red: 0, green: 68/255, blue: 139/255, alpha: 1)
        statusImageView.image = UIImage(named: "locked")
        statusImageViewTwo.image = UIImage(named: "lockedTwo")
    }
    
    func changeStatus() {
        openingPhase()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
            self.openPhase()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
                self.closedPhase()
            })
        })
    }
}

