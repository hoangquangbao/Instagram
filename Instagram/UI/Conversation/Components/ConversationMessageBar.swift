//
//  ConversationMessageBar.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct ConversationMessageBar: View {
    @EnvironmentObject var vm: ConversationViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            
            TextField("Message...", text: $vm.messageText)
                .textFieldStyle(DefaultCapsuleBorder())
            
            Button {
                
            } label: {
                Image.icnShare
                    .renderingMode(.template)
                    .foregroundColor(Color.primary)
            }
            .disabled(vm.messageText.isEmpty)
        }
        .padding(.horizontal, AppStyle.defaultSpacing)
        .padding(.bottom)
    }
}

struct ConversationMessageBar_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessageBar()
    }
}
