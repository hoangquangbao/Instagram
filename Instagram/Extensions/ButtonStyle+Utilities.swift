//
//  Button+Utilities.swift
//  Instagram
//
//  Created by lhduc on 07/11/2022.
//

import SwiftUI

enum MyButtonStyle {
    case `default`
    case bordered
    case borderless
}

extension Button {
    @ViewBuilder
    func myStyle(_ style: MyButtonStyle) -> some View {
        switch style {
            case .default:
                self.buttonStyle(DefaultButtonStyle())
        case .borderless:
            self.buttonStyle(BorderlessButtonStyle())
        case .bordered:
            self.buttonStyle(BorderedButtonStyle())
        }
    }
}
