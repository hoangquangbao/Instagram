//
//  BubbleChatView.swift
//  Instagram
//
//  Created by lhduc on 17/01/2023.
//

import SwiftUI


struct BubbleMessageView: View {
    let message: Message
    var isReceive: Bool = false
    
    var body: some View {
        HStack {
            ZStack {
                Text(message.text)
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                    .background(isReceive ? Color.clear : Color.gray.opacity(0.3))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(isReceive ? Color.gray.opacity(0.3) : Color.clear, lineWidth: 1)
                    )
            }
            .frame(width: UIScreen.screenWidth * 0.7, alignment: isReceive ? .leading : .trailing)
            .padding(.vertical, 5)
        }
        .frame(maxWidth: .infinity, alignment: isReceive ? .leading : .trailing)
        .id(message.id)
    }
}

struct BubbleMessageView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleMessageView(message: MockData.messages[0], isReceive: true)
        BubbleMessageView(message: MockData.messages[1])
    }
}
