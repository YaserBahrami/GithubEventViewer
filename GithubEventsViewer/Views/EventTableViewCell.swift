//
//  EventTableViewCell.swift
//  GithubEventsViewer
//
//  Created by Yaser on 27.11.2024.
//

// EventTableViewCell.swift
import UIKit
import SnapKit

class EventTableViewCell: UITableViewCell {
    
    private let avatarImageView = UIImageView()
    private let userNameLabel = UILabel()
    private let eventTypeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        // Configure avatarImageView
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill
        contentView.addSubview(avatarImageView)
        
        // Configure userNameLabel
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        contentView.addSubview(userNameLabel)
        
        // Configure eventTypeLabel
        eventTypeLabel.font = UIFont.systemFont(ofSize: 12)
        eventTypeLabel.textColor = .gray
        contentView.addSubview(eventTypeLabel)
        
        // Add constraints using SnapKit
        avatarImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(40)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        
        eventTypeLabel.snp.makeConstraints { make in
            make.left.equalTo(userNameLabel.snp.left)
            make.top.equalTo(userNameLabel.snp.bottom).offset(5)
        }
    }
    
    func configure(with event: GitHubEvent) {
        userNameLabel.text = event.actor.login
        eventTypeLabel.text = event.type
        
        // Load the avatar image
        if let url = URL(string: event.actor.avatarUrl) {
            avatarImageView.loadImage(from: url)
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
