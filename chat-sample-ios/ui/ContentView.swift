//
//  ContentView.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var webSocketManager = WebSocketManager()
    
    var body: some View {
        ChatView(webSocketManager: webSocketManager)
    }
}
