//
//  WebSocketManager_iosTests.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import XCTest
@testable import chat_sample_ios

class WebSocketManagerTests: XCTestCase {

    var webSocketManager: WebSocketManager!

    override func setUp() {
        super.setUp()
        webSocketManager = WebSocketManager()
    }

    override func tearDown() {
        webSocketManager = nil
        super.tearDown()
    }

    func testWebSocketConnect() {
        // 接続確認
        XCTAssertNotNil(webSocketManager.socket)
    }

    func testSendMessage() {
        let message = "Test message"
        webSocketManager.sendMessage(message)
        // 送信されたメッセージが正しいかを確認viewmodel側でいいか
    }
}
