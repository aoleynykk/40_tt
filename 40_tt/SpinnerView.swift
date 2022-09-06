

import UIKit

class SpinnerView: UIView {
    
    private let spinner = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        
        let rect = self.bounds
        let cirlePath = UIBezierPath(ovalIn: rect)
        
        spinner.path = cirlePath.cgPath
        spinner.fillColor = UIColor.clear.cgColor
        spinner.strokeColor = UIColor(red: 0.169, green: 0.722, blue: 0.31, alpha: 1).cgColor
        spinner.lineWidth = 2
        spinner.strokeEnd = 0.75
        spinner.lineCap = .round

        self.layer.addSublayer(spinner)
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.transform = CGAffineTransform(rotationAngle: .pi)
        } completion: { _ in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: 0)
            } completion: { _ in self.animate() }
        }
    }
}
