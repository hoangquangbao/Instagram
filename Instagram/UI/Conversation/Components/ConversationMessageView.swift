//
//  ConversationMessageView.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ConversationMessageView: View {
    let messages: [Message]
    private let columns = [GridItem(.flexible(minimum: 10))]
    
    @EnvironmentObject var sessionVm: SessionViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(messages) { message in
                    let isReceive = message.sender.id != sessionVm.uid
                    
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
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
    }
}

struct ConversationMessageView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessageView(messages: MockData.messages)
            .environmentObject(SessionViewModel())
    }
}
