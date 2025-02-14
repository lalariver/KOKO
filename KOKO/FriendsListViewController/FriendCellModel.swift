//
//  FriendCellModel.swift
//  KOKO
//
//  Created by user on 2025/2/8.
//

import Foundation

struct FriendCellModel {
    var isTop: Bool?
    // 預設是網址會去下載
    var friendPhoto: String?
    var name: String?
    // 1: 顯示... 2: 邀請中
    var status: Int?
    
    var invitingIsHidden: Bool {
        return status == 1
    }
    
    var moreIsHidden: Bool {
        return status == 2
    }
        
    var leftStactViewSpace: CGFloat {
        return status == 2 ? 10 : 25
    }
    
    init(friendApiModel: FriendApiModel) {
        self.isTop = friendApiModel.isTop == "1"
        self.friendPhoto = "tiramisu"
        self.name = friendApiModel.name
        self.status = friendApiModel.status
    }
}
