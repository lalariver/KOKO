//
//  GradientButton.swift
//  KOKO
//
//  Created by user on 2025/2/13.
//

import UIKit
import SnapKit

class GradientButton: UIButton {

    private let gradientLayer = CAGradientLayer()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(title: String, image: String? = "icAddFriendWhite") {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setupButton()
        setupView(image: image)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        // 設定圓角
        layer.cornerRadius = 20
        clipsToBounds = true
        
        // 設定漸層背景
        gradientLayer.colors = [
            UIColor(red: 16/255, green: 204/255, blue: 66/255, alpha: 1.0).cgColor,
            UIColor(red: 86/255, green: 179/255, blue: 11/255, alpha: 1.0).cgColor
        ]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        
        // 設定文字樣式
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private func setupView(image: String?) {
        guard let imageName = image else { return }
        addSubview(rightImageView)
        rightImageView.image = UIImage(named: imageName)
        
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.height.width.equalTo(24)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
