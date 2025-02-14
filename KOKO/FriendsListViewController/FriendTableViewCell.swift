//
//  FriendTableViewCell.swift
//  KOKO
//
//  Created by user on 2025/2/8.
//

import UIKit
import SnapKit

protocol CellType {
    /// 用於註冊和復用的 Identifier
    var cellIdentifier: String { get }
    
    /// 配置 Cell 的邏輯
    func configure(cell: UITableViewCell)
}

struct FriendCellType: CellType {
    let model: FriendCellModel  // 此 Cell 對應的資料模型
    
    var cellIdentifier: String {
        return "FriendTableViewCell"
    }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? FriendTableViewCell else { return }
        cell.configure(with: model)  // 呼叫具體的配置方法
    }
}

class FriendTableViewCell: UITableViewCell {
    
    private lazy var rightStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var isFavoriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icFriendsStar")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tiramisu")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "凱凱"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let transferButton = BorderedButton(title: "轉帳", titleColor: .hotPink)
    
    private let invitingButton = BorderedButton(title: "邀請中", titleColor: .pinkishGrey)
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icFriendsMore"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var leftSpaceView = UIView()
    private lazy var rightSpaceView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setupUI() {
        self.selectionStyle = .none
        
        let leftStackView = UIStackView()
        leftStackView.axis = .horizontal
        leftStackView.spacing = 6
        leftStackView.alignment = .center
        
        leftStackView.addArrangedSubview(isFavoriteImageView)
        leftStackView.addArrangedSubview(userPhoto)
        contentView.addSubview(leftStackView)
        
        contentView.addSubview(userNameLabel)
        
        rightStackView.addArrangedSubview(transferButton)
        rightStackView.addArrangedSubview(leftSpaceView)
        rightStackView.addArrangedSubview(moreButton)
        rightStackView.addArrangedSubview(invitingButton)
        rightStackView.addArrangedSubview(rightSpaceView)
        contentView.addSubview(rightStackView)
        
        let underLineView = UIView()
        underLineView.backgroundColor = UIColor(red: 228/255, green: 228/255, blue: 228/255, alpha: 1.0)
        contentView.addSubview(underLineView)
        
        isFavoriteImageView.snp.makeConstraints { make in
            make.width.height.equalTo(14)
        }
        
        userPhoto.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
                
        leftStackView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.leading).offset(70)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(leftStackView.snp.right).offset(15)
            make.centerY.equalToSuperview()
        }
        
        rightStackView.snp.makeConstraints { make in
            make.centerY.right.equalToSuperview()
        }
        
        rightSpaceView.snp.makeConstraints { make in
            make.height.width.equalTo(10)
        }
        
        leftSpaceView.snp.makeConstraints { make in
            make.height.width.equalTo(25)
        }
        
        underLineView.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.left)
            make.right.equalToSuperview().offset(30)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    // 配置 cell 的方法
    public func configure(with model: FriendCellModel) {
        self.isFavoriteImageView.isHidden = !(model.isTop ?? false)
        self.userNameLabel.text = model.name
        self.invitingButton.isHidden = model.invitingIsHidden
        
        let width = model.leftStactViewSpace
        self.leftSpaceView.snp.updateConstraints { make in
            make.width.equalTo(width)
        }
        
        self.moreButton.isHidden = model.moreIsHidden
        self.rightSpaceView.isHidden = model.moreIsHidden
    }
}
