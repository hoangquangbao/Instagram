//
//  ConversationView.swift
//  Instagram
//
//  Created by lhduc on 10/01/2023.
//

import SwiftUI

struct ConversationView: View {
    let conversation: Conversation
        
    @StateObject var vm: ConversationViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    
    init(conversation: Conversation) {
        self.conversation = conversation
        _vm = StateObject(wrappedValue: ConversationViewModel(conversation))
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let participant = getParticipant(in: conversation) {
                    ConversationHeaderView(participant: participant)
                }
                
                Divider()
                
                ConversationMessageView(messages: conversation.messages ?? [])

                ConversationMessageBar()
            
            }
            .navigationBarBackButtonHidden(true)
            .environmentObject(vm)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

private extension ConversationView {
    func getParticipant(in conversation: Conversation) -> User? {
        return vm.getParticipant(of: sessionVm.userInfo, in: conversation)
    }
}


//struct ConversationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationView(currentUser: MockData.users[0] ,participant: MockData.users[1])
//    }
//}
