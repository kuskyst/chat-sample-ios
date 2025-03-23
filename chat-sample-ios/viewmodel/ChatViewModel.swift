//
//  ChatViewModel.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import Foundation
import Starscream

class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var newMessage: String = ""
    private var webSocketManager: WebSocketManager

    init(webSocketManager: WebSocketManager) {
        self.webSocketManager = webSocketManager
        self.setupObservers()
    }

    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        let message = ChatMessage(text: newMessage, isSend: true)
        messages.append(message)
        webSocketManager.sendMessage(newMessage)
        newMessage = ""
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceive(_:)), name: .didReceive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMessage(_:)), name: .didReceiveMessage, object: nil)
    }

    @objc func didReceive(_ notification: Notification) {
        if let event = notification.userInfo?["event"] as? Starscream.WebSocketEvent {
            switch event {
            case .text(let message):
                if (messages.last?.text != message.replacing("\"", with: "")) {
                    let chat = ChatMessage(text: message.replacing("\"", with: ""), isSend: false)
                    messages.append(chat)
                }
            default: break
            }
        }
    }

    @objc func didReceiveMessage(_ notification: Notification) {
        if let messageText = notification.userInfo?["message"] as? String {
            let message = ChatMessage(text: messageText.replacing("\"", with: ""), isSend: false)
            messages.append(message)
        }
    }
}
