//
//  TopView.swift
//  KOKO
//
//  Created by user on 2025/2/6.
//

import UIKit
import SnapKit

class TopView: UIView {
        
    private lazy var atmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkWithdraw"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
        
    private lazy var transferButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkTransfer"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
        
    private lazy var scanButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icNavPinkScan"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(atmButton)
        addSubview(transferButton)
        addSubview(scanButton)
        
        atmButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.width.equalTo(24)
        }
        
        transferButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(atmButton.snp.right).offset(24.3)
            make.height.width.equalTo(24)
        }
        
        scanButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.height.width.equalTo(24)
        }
    }
}
