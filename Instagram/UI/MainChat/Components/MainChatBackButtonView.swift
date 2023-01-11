//
//  MainChatBackButtonView.swift
//  Instagram
//
//  Created by lhduc on 10/01/2023.
//

import SwiftUI

struct MainChatBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var sessionVm: SessionViewModel
    
    var body: some View {
        HStack {
            IconButton(imageIcon: Image.icnBack) {
                presentationMode.wrappedValue.dismiss()
            }
            
            Text(sessionVm.userInfo?.username ?? "lhduc2205")
                .font(.title)
                .bold()
                .padding(.leading, 10)
            
            Spacer()
            
        }
    }
}

struct MainChatBackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MainChatBackButtonView()
    }
}
