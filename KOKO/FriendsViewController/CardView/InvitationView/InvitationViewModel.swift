//
//  InvitationViewModel.swift
//  KOKO
//
//  Created by user on 2025/2/12.
//

import Foundation

class InvitationViewModel {
    var photo: String?
    var name: String
    var invitaion: String? = "邀請你成為好友：）"
    
    init(friendApiModel: FriendApiModel) {
        self.name = friendApiModel.name ?? ""
    }
}
