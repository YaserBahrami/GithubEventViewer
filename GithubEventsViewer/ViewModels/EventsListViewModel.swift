//
//  EventsListViewModel.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import Foundation
import Combine

class EventsListViewModel {
    private var events: [GitHubEvent] = []
    @Published var filteredEvents: [GitHubEvent] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let timer = Timer.publish(every: 10.0, on: .main, in: .common).autoconnect()
    
    init() {
        setupTimer()
    }
    func fetchEvents(type: String = "") {
        NetworkService.shared.fetchEvents()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching events: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] events in
                self?.events = events
                self?.filterEvents(by: type)
            }
            .store(in: &cancellables)
    }
    
    func filterEvents(by type: String) {
        if type.isEmpty {
            filteredEvents = events
        } else {
            filteredEvents = events.filter { $0.type == type }
        }
    }
    
    private func setupTimer() {
//        fetchAndMergeNewEvents()
        timer.sink { [weak self] _ in
            self?.fetchAndMergeNewEvents()
        }
        .store(in: &cancellables)
    }
    
    private func fetchAndMergeNewEvents() {
        
        NetworkService.shared.fetchEvents()
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching new events: \(error)")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] newEvents in
                guard let self = self else { return }
                
                let existingIDs = Set(self.events.map { $0.id })
                let uniqueNewEvents = newEvents.filter { !existingIDs.contains($0.id) }
                self.events.insert(contentsOf: uniqueNewEvents, at: 0)
                
                if let currentFilter = self.filteredEvents.first?.type, !currentFilter.isEmpty {
                    let filteredNewEvents = uniqueNewEvents.filter { $0.type == currentFilter }
                    self.filteredEvents.insert(contentsOf: filteredNewEvents, at: 0)
                } else {
                    self.filteredEvents.insert(contentsOf: uniqueNewEvents, at: 0)
                }
            }
            .store(in: &cancellables)
    }
}
