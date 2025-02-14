//
//  InvitationView.swift
//  KOKO
//
//  Created by user on 2025/2/7.
//

import UIKit
import SnapKit

class InvitationView: UIView {
    private let backgroundContainerView = UIView()
    
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tiramisu")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var invitationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnFriendsAgree"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btnFriendsDelet"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(model: InvitationViewModel) {
        super.init(frame: .zero)
        setupView()
        self.userNameLabel.text = model.name
        self.invitationLabel.text = model.invitaion
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 6
        
        backgroundContainerView.backgroundColor = .white
        backgroundContainerView.layer.cornerRadius = 6
        backgroundContainerView.layer.masksToBounds = true
        
        addSubview(backgroundContainerView)
        addSubview(userPhoto)
        addSubview(userNameLabel)
        addSubview(invitationLabel)
        addSubview(confirmButton)
        addSubview(cancelButton)
        
        backgroundContainerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userPhoto.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.width.height.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userPhoto.snp.top)
            make.left.equalTo(userPhoto.snp.right).offset(15)
        }
        
        invitationLabel.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.left)
            make.top.equalTo(userNameLabel.snp.bottom).offset(2)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(cancelButton.snp.left).offset(-15)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }
    
    public func setupView(_ model: InvitationViewModel) {
        self.userNameLabel.text = model.name
        self.invitationLabel.text = model.invitaion
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
