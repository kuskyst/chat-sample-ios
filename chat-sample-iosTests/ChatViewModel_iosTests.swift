//
//  ChatViewModel_iosTests.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import XCTest
@testable import chat_sample_ios

class ChatViewModelTests: XCTestCase {

    var viewModel: ChatViewModel!
    var mockWebSocketManager: MockWebSocketManager!

    override func setUp() {
        super.setUp()
        mockWebSocketManager = MockWebSocketManager()
        viewModel = ChatViewModel(webSocketManager: mockWebSocketManager)
    }

    override func tearDown() {
        viewModel = nil
        mockWebSocketManager = nil
        super.tearDown()
    }

    func testSendMessage() {
        let message = "Hello, WebSocket!"
        viewModel.newMessage = message
        viewModel.sendMessage()
        // 送信メッセージがWebSocketManagerで送られたかを確認
        XCTAssertTrue(mockWebSocketManager.didSendMessage)
        XCTAssertEqual(mockWebSocketManager.sentMessage, message)
    }

    func testReceiveMessage() {
        let receivedMessage = "Hello from server!"
        mockWebSocketManager.simulateReceiveMessage(receivedMessage)
        // 受信メッセージがViewModelのmessagesに追加されたかを確認
        XCTAssertEqual(viewModel.messages.count, 1)
        XCTAssertEqual(viewModel.messages.first?.text, receivedMessage)
    }
}
