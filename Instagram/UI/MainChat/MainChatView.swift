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
                ZStack {
                    VStack(alignment: .leading) {
                        MainChatBackButtonView()
        
                        SearchBar(searchText: $searchText) {
        
                        }
        
                        MainChatConversationsView()
                            .environmentObject(vm)
        
                    }
                    .padding(.horizontal, AppStyle.defaultSpacing)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        
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
