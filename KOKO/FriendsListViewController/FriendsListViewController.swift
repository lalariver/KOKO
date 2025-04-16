//
//  FriendsViewController.swift
//  KOKO
//
//  Created by user on 2025/2/8.
//

import UIKit
import SnapKit
import Combine

class FriendsListViewController: UIViewController {

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "想轉一筆給誰呢？"
        searchBar.setImage(UIImage(named: "icSearchBarSearchGray"), for: .search, state: .normal)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        return searchBar
    }()
    
    private lazy var addFriendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "icBtnAddFriends"), for: .normal)
        button.tintColor = .hotPink
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FriendTableViewCell.self, forCellReuseIdentifier: "FriendTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshPulled), for: .valueChanged)
        return tableView
    }()
    private let refreshControl = UIRefreshControl()
    
    private lazy var emptyView = EmptyView()
    
    public let searchEvent = PassthroughSubject<Bool, Never>()

    private let viewModel: FriendsViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: FriendsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        binding()
    }
    
    private func setupView() {
        view.addSubview(searchBar)
        view.addSubview(addFriendButton)
        view.addSubview(tableView)
        view.addSubview(emptyView)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(addFriendButton.snp.left).offset(-15)
            make.height.equalTo(36)
        }
        
        addFriendButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchBar)
            make.right.equalToSuperview().offset(-31)
            make.height.width.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func binding() {
        viewModel.$filteredList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$friendList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] list in
                self?.emptyView.isHidden = !list.isEmpty
            }
            .store(in: &cancellables)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func refreshPulled() {
        //        viewModel.fetchData()
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FriendsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.filteredList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellType.cellIdentifier, for: indexPath)
        cellType.configure(cell: cell)
        return cell
    }
}

extension FriendsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.setOriginalList()
        } else {
            viewModel.searchFriend(text: searchText)
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder() // 隱藏鍵盤
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchEvent.send(true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchEvent.send(false)
    }
}
