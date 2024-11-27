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
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        let titleLabel = UILabel()
        titleLabel.text = "Event Type: \(event.type)"
        titleLabel.textAlignment = .center
        
        let repoLabel = UILabel()
        repoLabel.text = "Repository: \(event.repo.name)"
        repoLabel.textAlignment = .center
        
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.clipsToBounds = true
        
        if let url = URL(string: event.actor.avatarUrl) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    avatarImageView.image = UIImage(data: data)
                }
            }.resume()
        }
        
        view.addSubview(titleLabel)
        view.addSubview(repoLabel)
        view.addSubview(avatarImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        repoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(repoLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }

}
