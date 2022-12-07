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
    @State private var shouldAnimate = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 5 : 0)
            
            
            if(isLoading) {
                Color.black.opacity(0.1).ignoresSafeArea()
                HStack {
                    Circle()
                        .foregroundColor(Color.seaBuckthorn700)
                        .frame(width: 12, height: 12)
                        .scaleEffect(shouldAnimate ? 0.6 : 0.3)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
                    
                    Circle()
                        .foregroundColor(Color.seaBuckthorn600)
                        .frame(width: 12, height: 12)
                        .scaleEffect(shouldAnimate ? 0.7 : 0.3)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.1), value: shouldAnimate)
                    
                    Circle()
                        .foregroundColor(Color.seaBuckthorn500)
                        .frame(width: 12, height: 12)
                        .scaleEffect(shouldAnimate ? 0.8 : 0.3)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.2), value: shouldAnimate)
                    
                    Circle()
                        .foregroundColor(Color.seaBuckthorn400)
                        .frame(width: 12, height: 12)
                        .scaleEffect(shouldAnimate ? 0.9 : 0.3)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
                    
                    Circle()
                        .foregroundColor(Color.seaBuckthorn300)
                        .frame(width: 12, height: 12)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.3)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.4), value: shouldAnimate)
                }
                .onAppear {
                    self.shouldAnimate = true
                }
            }
        }
    }
}

struct CustomWaitingDialog_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            
        }.showWaitingDialog(title: "Loading", isLoading: .constant(true))
    }
}
