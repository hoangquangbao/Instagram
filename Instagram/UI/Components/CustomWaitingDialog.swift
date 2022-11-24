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
                HStack {
                    Circle()
                        .fill(AngularGradient(colors: [.yellow, .purple], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270)))
                        .frame(width: 20, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
                    Circle()
                        .fill(AngularGradient(colors: [.purple, .red], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270)))
                        .frame(width: 20, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
                    Circle()
                        .fill(AngularGradient(colors: [.red, .yellow], center: .bottomTrailing, startAngle: .degrees(180), endAngle: .degrees(270)))
                        .frame(width: 20, height: 20)
                        .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
                }
                .onAppear {
                    self.shouldAnimate = true
                }
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
        VStack{
            
        }.showWaitingDialog(title: "Loading", isLoading: .constant(true))
    }
}
