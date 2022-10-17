//
//  SquareImageTab.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct SquareImageTab: View {
    let images: [String]
    @Binding var currentStep: Int
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(0..<images.count, id: \.self) { index in
                ZStack() {
                    HStack() {
                        Image(images[index])
                            .resizable()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
                            .scaledToFill()
                    }
                    VStack(alignment: .leading) {
                        HStack() {
                            Spacer()
                            HStack() {
                                Text("\(index + 1)/\(images.count)")
                                    .font(.system(size: 12))
                            }
                            .padding(7)
                            .background(Color._121212.opacity(0.7))
                            .foregroundColor(Color.f9F9F9)
                                .cornerRadius(10)
                        }
                        .padding(15)
                        Spacer()
                    }
                    Spacer()
                }
                .tag(index)
            }
        }
        .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

struct SquareImageTab_Previews: PreviewProvider {
    static var previews: some View {
        SquareImageTab(images: ["img_profile", "img_profile2"], currentStep: .constant(1))
    }
}
