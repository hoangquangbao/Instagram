//
//  ChatView.swift
//  Instagram
//
//  Created by lhduc on 05/01/2023.
//

import SwiftUI

struct MainChatView: View {
    private let vm = MainChatViewModel()
    
    @State var searchText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            MainChatBackButtonView()
            
            SearchBar(searchText: $searchText) {
                
            }
            
            MainChatConversationsView()
                .environmentObject(vm)
            
            Spacer()
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatView()
            .environmentObject(SessionViewModel())
        
        MainChatView()
            .environmentObject(SessionViewModel())
            .preferredColorScheme(.dark)
    }
}
