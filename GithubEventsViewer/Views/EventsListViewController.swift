//
//  EventsListViewController.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import UIKit
import SnapKit
import Combine

class EventsListViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: EventsListViewModel
    
    //
    private let eventTypes = [
        "Push": "PushEvent",
        "Watch": "WatchEvent",
        "Pull Request": "PullRequestEvent",
        "Issues": "IssuesEvent",
        "Fork": "ForkEvent"
    ]
    private let filterSegmentedControl = UISegmentedControl(items: ["Push", "Watch", "Pull Request", "Issues", "Fork"])
    
    private var cancellables = Set<AnyCancellable>()
    
    init (viewModel: EventsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
        
        viewModel.fetchEvents(type: "PushEvent")

    }
    
    private func setupUI() {
        title = "GitHub Events"
        view.backgroundColor = .systemBackground
        
        filterSegmentedControl.selectedSegmentIndex = 0
        filterSegmentedControl.addTarget(self, action: #selector(filterChanged), for: .valueChanged)
        view.addSubview(filterSegmentedControl)
        filterSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: "EventCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(filterSegmentedControl.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    
    private func setupBindings() {
        viewModel.$filteredEvents
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    @objc private func filterChanged() {
        let selectedIndex = filterSegmentedControl.selectedSegmentIndex
        let selectedTitle = filterSegmentedControl.titleForSegment(at: selectedIndex)!
        let eventType = eventTypes[selectedTitle] ?? ""
        viewModel.filterEvents(by: eventType)
    }
}

extension EventsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = viewModel.filteredEvents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventTableViewCell
        cell.configure(with: event)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = viewModel.filteredEvents[indexPath.row]
        let detailVC = EventDetailViewController(event: event)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
