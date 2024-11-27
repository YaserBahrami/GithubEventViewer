//
//  GithubEvent.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import Foundation

struct GitHubEvent: Decodable {
    let id: String
    let type: String
    let actor: Actor
    let repo: Repository
}
