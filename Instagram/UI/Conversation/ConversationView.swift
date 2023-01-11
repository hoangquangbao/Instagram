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
        ZStack {
            if let participant = vm.participant {
                VStack {
                    
                    ConversationHeaderView(participant: participant)
                    
                    Divider()
                    
                    ConversationMessageView(messages: vm.conversation.messages)
                    
                    ConversationMessageBar()
                        .ignoresSafeArea()
                
                }
                .navigationBarBackButtonHidden(true)
                .environmentObject(vm)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}


struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(conversation: MockData.conversations[0])
    }
}
