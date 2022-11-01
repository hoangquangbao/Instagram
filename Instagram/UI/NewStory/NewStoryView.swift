//
//  NewStoryView.swift
//  Instagram
//
//  Created by lhduc on 01/11/2022.
//

import SwiftUI

struct NewStoryView: View {
    let user: User
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                Text("New story")
                    .font(.system(size: 18))
                    .bold()
                HStack {
                    IconButton(imageIcon: Image(systemName: "xmark")) {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(Color._000000)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Text("Upload").font(.subheadline)
                    }
                }
            }
            .padding(.horizontal, AppStyle.defaultSpacing)
            .padding(.top, 5)
            Spacer()
        }
    }
}

struct NewStoryView_Previews: PreviewProvider {
    static var previews: some View {
        NewStoryView(user: MockData.users[0])
    }
}
