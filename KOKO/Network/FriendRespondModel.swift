//
//  FriendRespondModel.swift
//  KOKO
//
//  Created by user on 2025/2/8.
//

import Foundation

// MARK: - News
struct FriendRespondModel: Codable {
    var response: [FriendApiModel]?
}

// MARK: - Response
struct FriendApiModel: Codable {
    var name: String?
    var status: Int?
    var isTop, fid, updateDate: String?
}
