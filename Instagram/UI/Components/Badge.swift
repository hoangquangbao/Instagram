//
//  Badge.swift
//  Instagram
//
//  Created by lhduc on 20/10/2022.
//

import SwiftUI

struct Badge: View {
    let text: String
    let foregroundColor: Color
    let backgroundColor: Color
    var size: CGFloat = 10
    
    var body: some View {
        Text(text)
            .font(.system(size: size))
            .bold()
            .foregroundColor(foregroundColor)
            .padding(5)
            .background(backgroundColor)
            .clipShape(Circle())
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge(text: "text", foregroundColor: .white, backgroundColor: .blue)
    }
}
