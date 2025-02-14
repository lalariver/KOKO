//
//  CustomTabBarController.swift
//  KOKO
//
//  Created by user on 2025/2/6.
//

import UIKit
import SnapKit

class CustomTabBarController: UITabBarController {

    private lazy var centerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icTabbarHomeOff"), for: .normal)
        button.addTarget(self, action: #selector(centerButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
        setupCenterButton()
    }

    private func setupViewControllers() {
        let vc1 = createNavController(viewController: UIViewController(), imageName: "icTabbarProductsOff")
        let vc2 = createNavController(viewController: FriendsViewController(), imageName: "icTabbarFriendsOn")
        let vc3 = UIViewController() // 中間的按鈕不使用 UITabBarItem
        let vc4 = createNavController(viewController: UIViewController(), imageName: "icTabbarManageOff")
        let vc5 = createNavController(viewController: UIViewController(), imageName: "icTabbarSettingOff")

        viewControllers = [vc1, vc2, vc3, vc4, vc5]
    }
    
    private func createNavController(viewController: UIViewController, imageName: String) -> UIViewController {
        let tabBarItem = UITabBarItem()
        tabBarItem.image = UIImage(named: imageName)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0) // 調整上下間距
        viewController.tabBarItem = tabBarItem
        return viewController
    }

    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowImage = UIImage() // 移除系統陰影
        appearance.shadowColor = UIColor.lightGray // 設置分隔線顏色
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red: 236/255, green: 0, blue: 140/255, alpha: 1.0)
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBar.scrollEdgeAppearance = appearance
        }
    }

    private func setupCenterButton() {
        tabBar.addSubview(centerButton)

        centerButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-10) // 讓它凸出
            make.width.height.equalTo(60)
        }
    }

    @objc private func centerButtonTapped() {
        selectedIndex = 2
    }
}
