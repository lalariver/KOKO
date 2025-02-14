//
//  ViewModel.swift
//  KOKO
//
//  Created by user on 2025/2/12.
//

import Foundation

class FriendsViewModel {
    @Published var invitingList: [InvitationViewModel] = []
    @Published var filteredList: [CellType] = []
    @Published var friendList: [CellType] = []
    
    init() {
        Task {
            sleep(3)
            await self.parseJSONFile()
        }
        
        // 模擬網路下載
//        Task {
//            await self.fetchDate()
//        }
    }
    
    public func searchFriend(text: String) {
        guard let list = friendList as? [FriendCellType] else { return }
        self.filteredList = list.filter {
            $0.model.name?.lowercased().contains(text.lowercased()) == true
        }
    }
    
    public func setOriginalList() {
        self.filteredList = friendList
    }
    
    private func parseJSONFile() async {
        guard let url = Bundle.main.url(forResource: "userData", withExtension: "json") else {
            print("找不到檔案")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let respondModel = try JSONDecoder().decode(FriendRespondModel.self, from: data)

            guard let response = respondModel.response else { return }
            let zero = response.filter { $0.status == 0 }
            let nonZero = response.filter { $0.status != 0 }
            
            if !zero.isEmpty {
                self.invitingList = zero.map { InvitationViewModel(friendApiModel: $0) }
            }
            
            if !nonZero.isEmpty {
                let cellModels = nonZero.map { FriendCellModel(friendApiModel: $0) }

                self.friendList = cellModels.map { FriendCellType(model: $0) }
                self.filteredList = self.friendList
            }
        } catch {
            print("解析 JSON 失敗: \(error)")
            return
        }
    }

    private func fetchDate() async {
        do {
            let friends: FriendRespondModel = try await NetworkService.shared.request(api: .getFriends)
            print("Fetched Friends:", friends)
        } catch let apiError as APIError {
            switch apiError {
            case .requestFailed(let error):
                print("Network request failed:", error)
            case .invalidResponse:
                print("Invalid server response")
            case .noData:
                print("No data received from API")
            case .decodingFailed(let error):
                print("JSON decoding failed:", error)
            }
        } catch {
            print("Unexpected error:", error)
        }
    }
}
