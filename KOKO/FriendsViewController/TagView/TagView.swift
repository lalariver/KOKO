//
//  TagView.swift
//  KOKO
//
//  Created by user on 2025/2/7.
//

import UIKit
import SnapKit

protocol TagViewDelegate: AnyObject {
    func tagViewDidTapButton(_ index: Int)
}

class TagView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 36
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        view.backgroundColor = .hotPink
        return view
    }()
    
    private let titles: [String]
    
    private var subviewsArray: [UIView] = []
    
    weak var delegate: TagViewDelegate?
    
    init(titles: [String], frame: CGRect = .zero) {
        self.titles = titles
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        addSubview(underlineView)
        
        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        // 新增指定數量的 views
        for i in 0..<titles.count {
            let button = UIButton(type: .system)
            button.setTitle(titles[i], for: .normal)
            button.setTitleColor(.greyishBrown, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            subviewsArray.append(button)
        }
        
        if !subviewsArray.isEmpty {
            underlineView.snp.makeConstraints { make in
                make.top.equalTo(subviewsArray[0].snp.bottom).offset(6)
                make.centerX.equalTo(subviewsArray[0])
                make.bottom.equalToSuperview()
                make.height.equalTo(4)
                make.width.equalTo(20)
            }
        } else {
            underlineView.snp.makeConstraints { make in
                make.top.equalTo(subviewsArray[0].snp.bottom).offset(6)
                make.left.equalTo(stackView.snp.right).offset(3)
                make.bottom.equalToSuperview()
                make.height.equalTo(4)
                make.width.equalTo(20)
            }
        }
    }
    
    public func selectTag(index: Int) {
        UIView.animate(withDuration: 0.3) {
            self.underlineView.snp.remakeConstraints { make in
                make.top.equalTo(self.subviewsArray[index].snp.bottom).offset(6)
                make.centerX.equalTo(self.subviewsArray[index])
                make.bottom.equalToSuperview()
                make.height.equalTo(4)
                make.width.equalTo(20)
            }
            self.layoutIfNeeded()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        delegate?.tagViewDidTapButton(sender.tag)
        UIView.animate(withDuration: 0.3, animations: {
            self.underlineView.snp.remakeConstraints { make in
                make.top.equalTo(sender.snp.bottom).offset(6)
                make.centerX.equalTo(sender)
                make.bottom.equalToSuperview()
                make.height.equalTo(4)
                make.width.equalTo(20)
            }
            self.layoutIfNeeded()
        })
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
