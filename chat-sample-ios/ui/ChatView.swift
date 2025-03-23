//
//  ChatView.swift
//  chat-sample-ios
//
//  Created by kohsaka on 2025/03/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel

    init(webSocketManager: WebSocketManager) {
        _viewModel = StateObject(wrappedValue: ChatViewModel(webSocketManager: webSocketManager))
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.messages, id: \.text) { message in
                        HStack {
                            if message.isSend {
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue, in: RoundedRectangle(cornerRadius: 8))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.green, in: RoundedRectangle(cornerRadius: 8))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            HStack {
                TextField("Type a message", text: $viewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                Button(action: {
                    viewModel.sendMessage()
                }) {
                    Text("Send")
                }
                .padding()
            }
        }
        .padding(.top)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(webSocketManager: WebSocketManager())
    }
}
