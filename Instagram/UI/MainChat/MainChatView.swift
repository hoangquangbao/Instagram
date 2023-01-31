//
//  ChatView.swift
//  Instagram
//
//  Created by lhduc on 05/01/2023.
//

import SwiftUI

struct MainChatView: View {
    @StateObject var vm = MainChatViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                _backButton
                
                MainChatSearchBar()
                
                _bodyBuilder
                
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
        }
        .environmentObject(vm)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

private extension MainChatView {
    @ViewBuilder var _backButton: some View {
        if vm.mode == .normal {
            MainChatBackButtonView()
        }
    }
    
    @ViewBuilder var _bodyBuilder: some View {
        if vm.mode == .normal {
            MainChatConversationsView()
        } else {
            MainChatUserSearchResultView()
        }
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
