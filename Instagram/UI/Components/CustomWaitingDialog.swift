//
//  CustomWaitingDialog.swift
//  Instagram
//
//  Created by lhduc on 02/11/2022.
//

import SwiftUI

struct CustomWaitingDialog: ViewModifier {
    var title: String
    
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            content.disabled(isLoading)
            
            if(isLoading) {
                Color.black
                    .opacity(0.7)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isLoading.toggle()
                    }
                VStack (spacing: 12) {
                    Text(title)
                        .font(.system(.subheadline))
                        .foregroundColor(Color.black)
                    
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                    
                }
                .padding(15)
                .background(.white)
                .cornerRadius(10, corners: .allCorners)
                .shadow(color: Color(.systemGray2), radius: 5, x: 0, y: 0)
            }
        }
    }
}

extension View {
    func showWaitingDialog(title: String, isLoading: Binding<Bool>) -> some View {
        modifier(CustomWaitingDialog(title: title, isLoading: isLoading))
    }
}

struct CustomWaitingDialog_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().showWaitingDialog(title: "Loading", isLoading: .constant(true))
    }
}
