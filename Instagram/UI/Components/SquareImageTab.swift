//
//  SquareImageTab.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct SquareImageTab: View {
    let images: [Image]
    @Binding var currentStep: Int
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(0..<images.count, id: \.self) { index in
                ZStack() {
                    _SquareImage(image: images[index])
                    
                    if(images.count > 1) {
                        _ActiveIndexBadge(currentIndex: index + 1, total: images.count)
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

private struct _ActiveIndexBadge: View {
    let currentIndex: Int
    let total: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Spacer()
                HStack() {
                    Text("\(currentIndex)/\(total)")
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
    }
}

private struct _SquareImage: View {
    let image: Image
    
    var body: some View {
        image
            .resizable()
//            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth)
            .scaledToFill()
    }
}

struct SquareImageTab_Previews: PreviewProvider {
    static var previews: some View {
        SquareImageTab(images: [Image("img_profile"), Image("img_profile2")], currentStep: .constant(1))
    }
}
