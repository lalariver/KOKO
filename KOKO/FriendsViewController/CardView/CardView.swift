//
//  CardView.swift
//  KOKO
//
//  Created by user on 2025/2/7.
//

import UIKit
import SnapKit
import Combine

class CardView: UIView {
    private let stackView = UIStackView()
    
    private var isExpanded = false
    
    private let viewModel: FriendsViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        binding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // 設置 StackView
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        let view = UIView()
        
        stackView.addArrangedSubview(view)
        
        // 設置 StackView 位置
        stackView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.height.equalTo(0)
        }
        
        // 添加點擊事件
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleExpand))
        stackView.addGestureRecognizer(tapGesture)
    }
    
    private func binding() {
        viewModel.$invitingList
            .receive(on:DispatchQueue.main)
            .sink { [weak self] list in
                guard !list.isEmpty else { return }
                self?.stackView.spacing = 10
                self?.stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
                
                list.enumerated().forEach { (index, invitationModel) in
                    let view = InvitationView(model: invitationModel)
                    view.isHidden = index != 0
                    
                    self?.stackView.addArrangedSubview(view)
                }
                self?.layoutIfNeeded()
            }
            .store(in: &cancellables)
    }

    private func setupView(_ view: UIView, color: UIColor, label: String) {
        view.backgroundColor = color
        view.layer.cornerRadius = 8
        view.isUserInteractionEnabled = true
        stackView.addArrangedSubview(view)
        
        // 設定高度
        view.snp.makeConstraints { make in
            make.height.equalTo(70)
        }
    }
    
    @objc private func toggleExpand() {
        isExpanded.toggle()
        
        if isExpanded {
            // 先展開
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.arrangedSubviews.forEach {
                    $0.isHidden = false
                    $0.alpha = 1
                }
                self.layoutIfNeeded()
            })
        } else {
            // 先收合
            UIView.animate(withDuration: 0.3, animations: {
                self.stackView.arrangedSubviews.enumerated().forEach { index, view in
                    if index != 0 {
                        view.alpha = 0 // 讓它漸漸消失
                        view.isHidden = true
                    }
                }
                
                self.layoutIfNeeded()
            })
        }
    }
}
