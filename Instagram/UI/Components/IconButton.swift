//
//  IconButton.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct IconButton: View {
    let imageIcon: Image
    var size: CGFloat = 20
    var color: Color = Color.appPrimary
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            imageIcon
                .renderingMode(.template)
                .foregroundColor(color)
        }
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageIcon: Image.icnHeart, color: Color.black, onTap: {})
    }
}
