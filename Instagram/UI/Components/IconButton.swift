//
//  IconButton.swift
//  Instagram
//
//  Created by lhduc on 17/10/2022.
//

import SwiftUI

struct IconButton: View {
    let imageIcon: Image
    let onTap: () -> Void
    
    var body: some View {
        Button {
            onTap()
        } label: {
            imageIcon
        }

    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageIcon: Image.icnHeart, onTap: {})
    }
}
