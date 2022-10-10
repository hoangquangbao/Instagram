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
    
    var body: some View {
        HStack {
            _LeadingIcon(image: image, color: self.foregroundColor)
            Text(titleKey).font(.subheadline).bold().lineLimit(1)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .foregroundColor(self.foregroundColor)
        .background(self.backgroundColor)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(60, 60, 67, withOpacity: 0.18), lineWidth: 1.5)
        }.onTapGesture(perform: self.onTap)
    }
}

private extension ChoiceChip {
    var foregroundColor: Color {
        return isSelected ? .white : .black
    }
    
    var backgroundColor: Color {
        return isSelected ? Color.black : Color.white
    }
    
    func onTap() {
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
