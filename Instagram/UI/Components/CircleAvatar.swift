//
//  CircleAvatar.swift
//  Instagram
//
//  Created by lhduc on 13/10/2022.
//

import SwiftUI
import Kingfisher

struct CircleAvatar: View {
    let imageUrl: String
    var radius: CGFloat = AppStyle.defaultAvatarSize
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .resizable()
            .scaledToFill()
            .frame(width: radius, height: radius)
            .clipShape(Circle())
    }
}

extension CircleAvatar {
    func addGradientBorder(gradient: LinearGradient, lineWidth: CGFloat = 2.3, spacing: CGFloat = 8) -> some View {
        ZStack {
            self
            Circle()
                .stroke(gradient, lineWidth: lineWidth)
                .frame(width: radius + spacing, height: radius + spacing)
        }
    }
    func addBorder(_ color: Color, lineWidth: CGFloat = 2.3, spacing: CGFloat = 8) -> some View {
        ZStack {
            self
            Circle()
                .stroke(color, lineWidth: lineWidth)
                .frame(width: radius + spacing, height: radius + spacing)
        }
    }
}

//struct CircleAvatar_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleAvatar(image: Image.imgProfile2)
//    }
//}
