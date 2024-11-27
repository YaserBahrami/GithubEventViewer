//
//  EventDetailViewController.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

import UIKit
import SnapKit

class EventDetailViewController: UIViewController {
    
    private let event: GitHubEvent
    
    private let eventTypeLabel = UILabel()
    private let eventRepoUrlLabel = UILabel()
    private let repoNameLabel = UILabel()
    private let actorNameLabel = UILabel()
    private let avatarImageView = UIImageView()
    
    init(event: GitHubEvent) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureUI()
    }
    
    private func setupUI() {
        // Add labels and image views to the view
        view.backgroundColor = .systemBackground
        
        // Add views
        view.addSubview(avatarImageView)
        view.addSubview(actorNameLabel)
        view.addSubview(eventTypeLabel)
        view.addSubview(eventRepoUrlLabel)
        view.addSubview(repoNameLabel)
        
        
        
        // Constraints for avatar image
        avatarImageView.snp.makeConstraints { make in
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.width.height.equalTo(80)
        }
        
        // Constraints for actor name
        actorNameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalTo(avatarImageView.snp.top)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
        }
        
        // Constraints for event type label
        eventTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(actorNameLabel.snp.left)
            make.top.equalTo(actorNameLabel.snp.bottom).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)

            
        }
        
        // Constraints for repo name label
        repoNameLabel.snp.makeConstraints { make in
            make.left.equalTo(eventTypeLabel.snp.left)
            make.top.equalTo(eventTypeLabel.snp.bottom).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.height.greaterThanOrEqualTo(30)
            
        }
        
        repoNameLabel.numberOfLines = -1
        
        // Constraints for event description label
        eventRepoUrlLabel.snp.makeConstraints { make in
            make.left.equalTo(repoNameLabel.snp.left)
            make.top.equalTo(repoNameLabel.snp.bottom).offset(10)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)

            make.height.greaterThanOrEqualTo(30)
        }
        eventRepoUrlLabel.numberOfLines = -1
        
    }
    
    private func configureUI() {
        // Set the data from the event
        eventTypeLabel.text = "Event Type: \(event.type)"
        eventRepoUrlLabel.text = "Repo Url: \(event.repo.url)"
        repoNameLabel.text = "Repo: \(event.repo.name)"
        actorNameLabel.text = "Actor: \(event.actor.login)"
        
        // Load avatar image asynchronously
        if let url = URL(string: event.actor.avatarUrl) {
            avatarImageView.loadImage(from: url)
        }
    }
}
