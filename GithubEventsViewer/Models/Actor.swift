//
//  Actor.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import Foundation

struct Actor: Decodable {
    let id: Int
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
    }
}
