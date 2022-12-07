//
//  DefaultToast.swift
//  Instagram
//
//  Created by lhduc on 07/12/2022.
//

import SwiftUI

struct DefaultToast: ViewModifier {
    var toastOptions: ToastOptions
    
    @Binding var isPresent: Bool
    
    func body(content: Content) -> some View {
        ZStack(alignment: toastOptions.toAlignment()) {
            content
            
            if isPresent {
                HStack {
                    toastOptions.leadingIcon
                    
                    Text(toastOptions.title).padding(.horizontal)
                    
                    toastOptions.trailingIcon
                }
                .padding(.vertical, 5)
                .foregroundColor(toastOptions.color)
                .background(toastOptions.bgColor)
                .clipShape(Capsule())
                .animation(.easeInOut(duration: 1.2), value: isPresent)
                .transition(AnyTransition.move(edge: toastOptions.toAnimationEdge()).combined(with: .opacity))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + toastOptions.timeLeft) {
                        withAnimation {
                            self.isPresent = false
                        }
                    }
                }
            }
        }
    }
}

struct DefaultToast_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            
        }.showToast(toastOption: ToastOptions(title: "Toast is presented"), isPresent: .constant(true))
    }
}
