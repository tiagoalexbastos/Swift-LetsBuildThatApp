//
//  ViewController.swift
//  SwiftGroupedMessages
//
//  Created by Tiago Bastos on 06/02/2019.
//

import UIKit

final class ViewController: UITableViewController {
    
    private let cellId = "id"
    
    private let messagesFromServer = [
        ChatMessage(text: "Here's my very first message",
                    isIncoming: true,
                    date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap",
                    isIncoming: true,
                    date: Date.dateFromCustomString(customString: "08/03/2018")),
        ChatMessage(text: "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap",
                    isIncoming: false,
                    date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Yo, dawg, Whaddup!",
                    isIncoming: false,
                    date: Date()),
        ChatMessage(text: "This message should appear on the left with a white background bubble",
                    isIncoming: true,
                    date: Date.dateFromCustomString(customString: "09/15/2018")),
        ChatMessage(text: "Third Section message",
                    isIncoming: true,
                    date: Date.dateFromCustomString(customString: "10/31/2018"))
    ]
    
    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        configureTableView()
        
        attemptToGroupMessages()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    private func attemptToGroupMessages() {
        let groupedMessages = Dictionary(grouping: messagesFromServer) { element -> Date in
            return element.date
        }
        
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { key in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }

    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        
        return chatMessages[section].count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }

    class DateHeaderLabel: UILabel {
        
        override var intrinsicContentSize: CGSize {
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 12
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: originalContentSize.width + 20, height: height)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.backgroundColor = .black
            label.text = dateString
            label.textColor = .white
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 14)
            
            let containerView = UIView()
            containerView.addSubview(label)
            
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView

        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatMessageCell
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage
        return cell
    }
}

