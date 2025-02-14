//
//  NetworkService.swift
//  KOKO
//
//  Created by user on 2025/2/11.
//

import Foundation

enum APIError: Error {
    case requestFailed(Error)
    case invalidResponse
    case noData
    case decodingFailed(Error)
}

class NetworkService {
    static let shared = NetworkService()
    
    func request<T: Codable>(api: FriendsApi) async throws -> T {
        let urlRequest = api.urlRequest
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            guard !data.isEmpty else {
                throw APIError.noData
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingFailed(error)
            }
        } catch {
            throw APIError.requestFailed(error)
        }
    }
}
