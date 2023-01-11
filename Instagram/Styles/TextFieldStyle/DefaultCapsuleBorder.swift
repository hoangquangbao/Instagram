//
//  DefaultCapsuleBorder.swift
//  Instagram
//
//  Created by lhduc on 11/01/2023.
//

import SwiftUI

struct DefaultCapsuleBorder: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.subheadline)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.background)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color(.systemGray).opacity(0.8)))
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color(.systemGray).opacity(0.8)))
    }
}
