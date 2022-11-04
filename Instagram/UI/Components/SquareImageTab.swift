//
//  SquareImageTab.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI
import Kingfisher

struct SquareImageTab: View {
    let images: [Any]
    @Binding var currentStep: Int
    
    init(imagesUrl: [String], currentStep: Binding<Int>) {
        self.images = imagesUrl
        _currentStep = currentStep
    }
    
    init(images: [UIImage], currentStep: Binding<Int>) {
        self.images = images
        _currentStep = currentStep
    }
    
    var body: some View {
        TabView(selection: $currentStep) {
            ForEach(0..<images.count, id: \.self) { index in
                ZStack() {
                    _imageBuilder(image: images[index])
                    
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

private extension SquareImageTab {
    @ViewBuilder
    func _imageBuilder(image: Any) -> some View {
        if(image is String) {
            _KFImage(imageUrl: image as! String)
        } else {
            _UIImage(image: image as! UIImage)
        }
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

private struct _KFImage: View {
    let imageUrl: String
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .scaledToFill()
    }
}

private struct _UIImage: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
    }
}

struct SquareImageTab_Previews: PreviewProvider {
    static var previews: some View {
        SquareImageTab(imagesUrl: ["shorturl.at/rUV36"], currentStep: .constant(1))
    }
}
