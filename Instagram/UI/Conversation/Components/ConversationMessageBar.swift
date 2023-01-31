//
//  ConversationMessageBar.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ConversationMessageBar: View {
    @EnvironmentObject var vm: ConversationViewModel
    @EnvironmentObject var sessionVm: SessionViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            
            TextField("Message...", text: $vm.messageText)
                .textFieldStyle(DefaultCapsuleBorder())
            
            Button {
                vm.sendMessage(by: sessionVm.userInfo, to: vm.participant)
            } label: {
                Image.icnShare
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
            }
            .disabled(vm.messageText.isEmpty)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
    }
}

struct ConversationMessageBar_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessageBar()
            .environmentObject(SessionViewModel())
    }
}
