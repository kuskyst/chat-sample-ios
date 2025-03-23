//
//  WebSocketManager.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import Foundation
import Starscream

class WebSocketManager: ObservableObject {
    var socket: WebSocket?

    init() {
        setupWebSocket()
    }

    private func setupWebSocket() {
        var request = URLRequest(url: URL(string: "ws://localhost:8080/ws")!)
        request.timeoutInterval = 5

        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }

    func sendMessage(_ message: String) {
        socket?.write(string: message)
    }

    func disconnect() {
        socket?.disconnect()
    }
}

extension WebSocketManager: WebSocketDelegate {
    func didReceive(event: Starscream.WebSocketEvent, client: any Starscream.WebSocketClient) {
        NotificationCenter.default.post(name: .didReceive, object: nil, userInfo: ["event": event])
    }

    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket is connected")
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected: \(String(describing: error))")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        NotificationCenter.default.post(name: .didReceiveMessage, object: nil, userInfo: ["message": text])
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // Handle binary data if needed
    }
}

extension Notification.Name {
    static let didReceive = Notification.Name("didReceive")
    static let didReceiveMessage = Notification.Name("didReceiveMessage")
}
