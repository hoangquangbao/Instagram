//
//  MessageRowView.swift
//  Instagram
//
//  Created by lhduc on 06/01/2023.
//

import SwiftUI

struct MessageRowView: View {
    private let _avatarSize: CGFloat = 50
    private let vm: MessageRowViewModel
    
    @EnvironmentObject var sessionVm: SessionViewModel
    @EnvironmentObject var mainChatVm: MainChatViewModel
    
    init(conversation: Conversation) {
        vm = MessageRowViewModel(conversation)
    }
    
    var body: some View {
        if let participant = vm.participant {
            HStack(spacing: 15) {
                CircleAvatar(imageUrl: participant.avatarUrl, radius: _avatarSize)
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(participant.fullName)
                            .foregroundColor(Color._000000)
                            .fontWeight(vm.isNotSeen ? .bold : .medium)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        if (vm.isNotSeen) {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color(.systemBlue))
                        }
                    }
                    
                    HStack(spacing: 5) {
                        _lastMessageText
                        
                        Text("• \(vm.lastMessage?.sendAtAgo ?? "")")
                            .font(.subheadline)
                            .lineLimit(1)
                            .foregroundColor(Color.semiText)
                        
                    }
                }
            }
        }
    }
}

private extension MessageRowView {
    var _messageColor: Color {
        guard let lastMessage = vm.lastMessage else {
            return Color.semiText
        }
        
        if (vm.isSender(lastMessage) || lastMessage.hasSeen == true) {
            return Color.semiText
        }
        
        return Color._000000
    }
    
    var _lastMessageText: some View {
        var message = vm.lastMessage?.text ?? ""
        
        if vm.isSender(vm.lastMessage!) {
            message = "You: \(message)"
        }
        
        return Text(message)
            .font(.subheadline)
            .lineLimit(1)
            .foregroundColor(_messageColor)
    }
}

struct MessageRowView_Previews: PreviewProvider {
    static private let messages: [Message] = [
        Message(sender: MockData.users[0], text: "Hello"),
        Message(sender: MockData.users[1], text: "Hi adsadkmcmkmckskkdk akdkadkas kd k 1"),
        Message(sender: MockData.users[0], text: "Hello"),
        Message(sender: MockData.users[1], text: "Hi adsadkmcmkmckskkdk akdkadkas kd k 1"),
    ]
    
    static private let conversation: Conversation = Conversation(
        user1: MockData.users[0],
        user2: MockData.users[1],
        messages: messages)
    
    static var previews: some View {
        MessageRowView(conversation: conversation)
    }
}
