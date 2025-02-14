//
//  FriendsApi.swift
//  KOKO
//
//  Created by user on 2025/2/11.
//

import Foundation

enum FriendsApi {
    case getUser
    case getFriends
    
    var baseURL: String {
        return "https://www.xxxx/open-api/"
    }
        
    var path: String {
        switch self {
        case .getUser:
            return "/getUser"
        case .getFriends:
            return "/getFriends"
        }
    }
    
    var lang: String {
        return "LocalizationManager.shared.getCurrentLangCode()"
    }
    
    var method: String {
        switch self {
        case .getUser:
            return "GET"
        case .getFriends:
            return "GET"
        }
    }
    
    var headers: [String: String] {
        return [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var parameters: [String: String?] {
        switch self {
        case .getUser:
            return [:]
        case .getFriends:
            return [:]
        }
    }
    
    var urlRequest: URLRequest {
        var urlComponents = URLComponents(string: baseURL + path)
        
        if !parameters.isEmpty {
            urlComponents?.queryItems = parameters.compactMap { key, value in
                value.map { URLQueryItem(name: key, value: $0) }
            }
        }
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL: \(baseURL + path)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }
}
