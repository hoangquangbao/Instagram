//
//  ChoiceChip.swift
//  Instagram
//
//  Created by lhduc on 06/10/2022.
//

import SwiftUI

struct ChoiceChip: View {
    let titleKey: String
    var image: Image?
    @Binding var isSelected: Bool
    var onSelected: () -> ()
    
    private let _cornerRadius: CGFloat = 10
    
    var body: some View {
        HStack {
            _LeadingIcon(image: image, color: _foregroundColor)
            Text(titleKey).font(.subheadline).bold().lineLimit(1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .foregroundColor(_foregroundColor)
        .background(_backgroundColor)
        .cornerRadius(_cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: _cornerRadius)
                .stroke(Color("#3C3C43"), lineWidth: 1.5)
        }
        .onTapGesture(perform: _onTap)
    }
}

private extension ChoiceChip {
    var _foregroundColor: Color {
        return isSelected ? Color("#FFFFFF") : Color("#000000")
    }
    
    var _backgroundColor: Color {
        return isSelected ? Color("#000000") : Color("#FFFFFF")
    }
    
    func _onTap() {
        self.onSelected()
    }
}

private struct _LeadingIcon: View {
    var image: Image?
    var color: Color
    
    var body: some View {
        if let image = image {
            image
                .renderingMode(.template)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(color)
        }
    }
}

struct ChoiceChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChoiceChip(titleKey: "Shop", image: Image("icn_shop"), isSelected: .constant(true)) {}
            ChoiceChip(titleKey: "Shop", image: Image(systemName: "pencil"), isSelected: .constant(false)){}
        }
    }
}
