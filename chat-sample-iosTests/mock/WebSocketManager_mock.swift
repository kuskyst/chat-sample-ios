//
//  WebSocketManager_mock.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import Foundation
@testable import chat_sample_ios

class MockWebSocketManager: WebSocketManager {
    var didSendMessage = false
    var sentMessage: String?

    override func sendMessage(_ message: String) {
        didSendMessage = true
        sentMessage = message
    }

    func simulateReceiveMessage(_ message: String) {
        NotificationCenter.default.post(name: .didReceiveMessage, object: nil, userInfo: ["message": message])
    }
}
