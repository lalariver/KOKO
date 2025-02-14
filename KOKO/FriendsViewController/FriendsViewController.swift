//
//  ViewController.swift
//  KOKO
//
//  Created by user on 2025/2/6.
//

import UIKit
import SnapKit
import Combine

class FriendsViewController: UIViewController {
    
    private lazy var topView = TopView()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "紫琳"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var userIDLabel: UILabel = {
        let label = UILabel()
        label.text = "KOKO ID：olylinhuang"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 13, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icInfoBackDeepGray"), for: .normal)
//        button.addTarget(self, action: #selector(atmButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tiramisu")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 26
        return imageView
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView(viewModel: viewModel)
        return view
    }()
    
    private lazy var tagView: TagView = {
        let tagView = TagView(titles: ["好友","聊天"])
        tagView.delegate = self
        return tagView
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
        return view
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pvc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pvc.setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        pvc.dataSource = self
        pvc.delegate = self
        return pvc
    }()
    
    private let pages: [UIViewController]
    
    private let viewModel = FriendsViewModel()
    
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.pages = [FriendsListViewController(viewModel: viewModel), UIViewController()]
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPageViewController()
    }

    private func setupView() {
        view.addSubview(topView)
        view.addSubview(userNameLabel)
        view.addSubview(userIDLabel)
        view.addSubview(rightArrowButton)
        view.addSubview(userPhoto)
        
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.addArrangedSubview(cardView)
        stackView.addArrangedSubview(tagView)
        view.addSubview(stackView)
        
        view.addSubview(lineView)
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
        }
        
        userIDLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
        }
        
        rightArrowButton.snp.makeConstraints { make in
            make.left.equalTo(userIDLabel.snp.right).offset(1)
            make.centerY.equalTo(userIDLabel)
        }
        
        userPhoto.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(27)
            make.top.equalTo(userNameLabel.snp.top).inset(-8)
            make.right.equalToSuperview().offset(-30)
            make.width.height.equalTo(52)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(userPhoto.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        cardView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide).offset(-30)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    private func setupPageViewController() {
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        pageViewController.didMove(toParent: self)
    }
}

extension FriendsViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index > 0
        else { return nil }
        return pages[index - 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController),
              index < pages.count - 1
        else { return nil }
        return pages[index + 1]
    }

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentVC = pageViewController.viewControllers?.first,
           let index = pages.firstIndex(of: currentVC) {
            tagView.selectTag(index: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        if let nextVC = pendingViewControllers.first,
           let nextIndex = pages.firstIndex(of: nextVC) {
            tagView.selectTag(index: nextIndex)
        }
    }
}

extension FriendsViewController: TagViewDelegate {
    func tagViewDidTapButton(_ index: Int) {
        guard index < pages.count else { return }
        
        let selectedPage = pages[index]
        let currentPage = pageViewController.viewControllers?.first
        
        let direction: UIPageViewController.NavigationDirection =
        (pages.firstIndex(of: currentPage!) ?? 0) < index ? .forward : .reverse
        
        pageViewController.setViewControllers([selectedPage], direction: direction, animated: true, completion: nil)
    }
}
