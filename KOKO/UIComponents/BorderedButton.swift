//
//  BorderedLabel.swift
//  KOKO
//
//  Created by user on 2025/2/8.
//

import UIKit

class BorderedButton: UIButton {
    init(title: String, titleColor: UIColor) {
        super.init(frame: CGRect(x: 0, y: 0, width: 47, height: 24))
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.tintColor = .clear
        self.titleLabel?.textAlignment = .center
        self.layer.borderWidth = 1
        self.layer.borderColor = titleColor.cgColor
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        
        var config = UIButton.Configuration.filled()
        config.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 9, bottom: 2, trailing: 9)
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
