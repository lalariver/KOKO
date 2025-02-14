//
//  EmptyView.swift
//  KOKO
//
//  Created by user on 2025/2/13.
//

import UIKit
import SnapKit

class EmptyView: UIView {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imgFriendsEmpty")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var addFriendLabel: UILabel = {
        let label = UILabel()
        label.text = "就從加好友開始吧：）"
        label.textColor = UIColor(red: 71/255, green: 71/255, blue: 71/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）"
        label.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var addFriendButton: GradientButton = {
        let button = GradientButton(title: "加好友")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                
        return button
    }()
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped() {
        print("按鈕被點擊了！")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        
        addSubview(imageView)
        addSubview(addFriendLabel)
        addSubview(subtitleLabel)
        addSubview(addFriendButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(172)
            make.width.equalTo(245)
        }
        
        addFriendLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(41)
            make.centerX.equalToSuperview()
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(addFriendLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(192)
            make.height.equalTo(40)
        }
    }
}
