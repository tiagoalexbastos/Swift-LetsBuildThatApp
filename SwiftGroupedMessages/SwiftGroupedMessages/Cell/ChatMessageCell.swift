//
//  ChatMessageCell.swift
//  SwiftGroupedMessages
//
//  Created by Tiago Bastos on 06/02/2019.
//

import UIKit

final class ChatMessageCell: UITableViewCell {
    
    var chatMessage: ChatMessage! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming ? .white : .darkGray
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
    }
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "We want to provide a longer string that is actually going" +
        "to wrap onto the next line and maybe even a third line"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bubbleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        setupSubViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubViews() {
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        leadingConstraint.isActive = false
        trailingConstraint.isActive = true

        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16).isActive = true
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16).isActive = true
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16).isActive = true
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16).isActive = true
    }
}
