//
//  MainChatConversationsView.swift
//  Instagram
//
//  Created by lhduc on 10/01/2023.
//

import SwiftUI

struct MainChatConversationsView: View {
    @EnvironmentObject var vm: MainChatViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                
                Text("Messages")
                    .font(.headline).bold()
                    .padding(.top)
                
                ForEach(vm.conversations) { conversation in
                    NavigationLink {
                        ConversationView(conversation: conversation)
                    } label: {
                        MessageRowView(conversation: conversation)
                    }
                }
            }
        }
        .padding(.top, 2)
    }
}



struct MainChatConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatConversationsView()
            .environmentObject(MainChatViewModel())
    }
}
