//
//  APIModel.swift
//  AI-Trip-API
//
//  Created by Renato Oliveira Fraga on 6/9/23.
//

import Foundation

// MARK: - APIModel
struct APIModel: Codable, Identifiable {
    let id: String
    let plan: [Plan]
    let key: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case plan, key
    }
}

// MARK: - Plan
struct Plan: Codable {
    let day: Int
    let activities: [Activity]
}

// MARK: - Activity
struct Activity: Codable {
    let time, description: String
}
