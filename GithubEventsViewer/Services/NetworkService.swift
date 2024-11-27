//
//  NetworkService.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//
import Foundation
import Combine

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchEvents() -> AnyPublisher<[GitHubEvent], Error> {
        guard let url = URL(string: "https://api.github.com/events") else {
            return Fail(error: NSError(domain: "Invalid URL", code: -1, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NSError(domain: "Invalid response", code: -1, userInfo: nil)
                }
                return data
            }
            .decode(type: [GitHubEvent].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
