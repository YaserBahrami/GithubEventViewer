//
//  Repository.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let url: String
}
