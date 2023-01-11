//
//  ConversationView.swift
//  Instagram
//
//  Created by lhduc on 10/01/2023.
//

import SwiftUI

struct ConversationView: View {
    @ObservedObject var vm: ConversationViewModel
    
    init(conversation: Conversation) {
        vm = ConversationViewModel(conversation)
    }
    
    var body: some View {
        if let participant = vm.participant {
            VStack {
                ConversationHeaderView(participant: participant)
                
                ScrollView {
                    ForEach(vm.conversation.messages) { message in
                        Text(message.text)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(conversation: MockData.conversations[0])
    }
}
