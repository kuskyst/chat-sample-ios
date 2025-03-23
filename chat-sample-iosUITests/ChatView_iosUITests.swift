//
//  ChatView_iosUITests.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import XCTest

class ChatViewUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testSendMessageButton() {
        let textField = app.textFields["Type a message"]
        let sendButton = app.buttons["Send"]

        // メッセージを入力
        textField.tap()
        textField.typeText("Hello, World!")

        // 送信ボタンをタップ
        sendButton.tap()

        // 送信メッセージが表示されるかを確認
        let messageLabel = app.staticTexts["Hello, World!"]
        XCTAssertTrue(messageLabel.exists)
    }
}
